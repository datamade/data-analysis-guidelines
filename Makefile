MAKEFLAGS += --warn-undefined-variables
SHELL := bash
VPATH = examples/analyses
.SHELLFLAGS := -eu -o pipefail
.DEFAULT_GOAL := all

all : report.pdf

include examples/LaTeX.mk
