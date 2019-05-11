SHELL := /usr/bin/env bash
.SECONDEXPANSION:

CLASS = ~/git/fork/class/class

directories = 0_0_0_0_0_0_0 1_0_0_0_0_0_0 2_0_0_0_0_0_0 0_1_0_0_0_0_0 0_2_0_0_0_0_0 0_0_1_0_0_0_0 0_0_2_0_0_0_0 0_0_0_1_0_0_0 0_0_0_2_0_0_0 0_0_0_0_1_0_0 0_0_0_0_2_0_0 0_0_0_0_0_1_0 0_0_0_0_0_2_0 0_0_0_0_0_0_1 0_0_0_0_0_0_2

programs = $(patsubst %,%/Programs/drive_logZscroll_Ts,$(directories))
outdirs = $(patsubst %,%/Output_files,$(directories))
classOutfile = $(patsubst %,output/%-cl_lensed.dat,$(directories))

class: $(classOutfile)

output/%-cl_lensed.dat: %.ini
	mkdir -p $(@D)
	$(CLASS) $< # cl_ref.pre

21cmfast: $(outdirs)

%/Output_files: %/Programs/drive_logZscroll_Ts
	cd $(<D) && ./drive_logZscroll_Ts
	rm -rf $*/Boxes

compile: $(programs)

%/Programs/drive_logZscroll_Ts: %/Parameter_files/ANAL_PARAMS.H %/Parameter_files/HEAT_PARAMS.H
	cd $(@D) && make CC='gcc -fopenmp -Ofast -ffast-math -march=native' CPPFLAGS="-I $$HOME/21cmfast/local/include" $(@F)

print-%:
	$(info $* = $($*))
