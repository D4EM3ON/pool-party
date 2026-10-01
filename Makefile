# All folders under src/, minus the ones starting with _ or py_
DIRS  := $(filter-out src/_% src/py_%,$(wildcard src/*/))
DATA  := $(wildcard $(addsuffix data.r,$(DIRS)))
PLOTS := $(wildcard $(addsuffix plots.r,$(DIRS)))

.PHONY: all data plots list

all: data plots

data:
	@for f in $(DATA); do echo "==> $$f"; Rscript $$f || exit 1; done

plots:
	@for f in $(PLOTS); do echo "==> $$f"; Rscript $$f || exit 1; done

list:
	@echo "data:  $(DATA)"; echo "plots: $(PLOTS)"