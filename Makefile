MAKEFLAGS += --warn-undefined-variables
SHELL := bash
VPATH = examples examples/data examples/analyses
.SHELLFLAGS := -eu -o pipefail
.DEFAULT_GOAL := all

PG_DB=libraries

.PHONY : all data clean

.INTERMEDIATE : cpl-wifi.csv.tmp

data : wifi.table cpl-wifi.csv
all : report.pdf
clean :
	dropdb $(PG_DB)
	rm *.table *.database examples/data/*

$(PG_DB).database :
	createdb $(basename $@); \
	touch $@

wifi.table : cpl-wifi.csv $(PG_DB).database
	csvsql --no-inference --db postgresql:///$(PG_DB) --insert --table $(basename $@) $<; \
	psql $(basename $(word 2, $^)) -c " \
	  alter table $(basename $@) \
	    alter column cumulative_number_of_sessions type integer USING CAST(cumulative_number_of_sessions AS integer), \
		alter column number_of_sessions type integer USING CAST(number_of_sessions AS integer), \
		alter column year type integer USING CAST(year AS integer)"; \
	touch $@

examples/data/cpl-wifi.csv :
	wget --no-use-server-timestamps -O $@ https://data.cityofchicago.org/resource/cxkd-f8x2.csv

appendix_b-pandas.md : data pandas.mdw
	pweave --output=$@ $(word 2, $^)

include examples/LaTeX.mk
