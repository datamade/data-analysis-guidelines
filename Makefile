MAKEFLAGS += --warn-undefined-variables
SHELL := bash
VPATH = examples examples/analyses
.SHELLFLAGS := -eu -o pipefail
.DEFAULT_GOAL := all

PG_DB=libraries

.PHONY : all data clean

.INTERMEDIATE : library-data.csv.tmp

data : libraries.table examples/library-data.csv
all : report.pdf
clean :
	dropdb $(PG_DB)

$(PG_DB).database :
	createdb $(basename $@); \
	touch $@

libraries.table : library-data.csv $(PG_DB).database
	csvsql --db postgresql:///$(PG_DB) --insert --table $(basename $@) $<; \
	touch $@

examples/library-data.csv : library-data.csv.tmp
	csvcut -C 1,2,3,4,5 $< > $@

library-data.csv.tmp :
	wget --no-use-server-timestamps -O $@ https://data.cityofchicago.org/resource/psqp-6rmg.csv

include examples/LaTeX.mk
