#!/usr/bin/env bash

for subdir in 0_0_0_0_0_0_0 1_0_0_0_0_0_0 2_0_0_0_0_0_0 0_1_0_0_0_0_0 0_2_0_0_0_0_0 0_0_1_0_0_0_0 0_0_2_0_0_0_0 0_0_0_1_0_0_0 0_0_0_2_0_0_0 0_0_0_0_1_0_0 0_0_0_0_2_0_0 0_0_0_0_0_1_0 0_0_0_0_0_2_0 0_0_0_0_0_0_1 0_0_0_0_0_0_2; do

    # symlink these directories directly
    for dir in Cosmo_c_files External_tables; do
        ln -s ../../$dir $subdir
    done

    # for these directories, symlink individual files
    dir=Parameter_files
    mkdir -p $subdir/$dir
    for file in COSMOLOGY.H INIT_PARAMS.H; do
        ln -s ../../../$dir/$file $subdir/$dir
    done

    dir=Programs
    mkdir -p $subdir/$dir
    for file in boxcar_smooth_field.c bubble_helper_progs.c delta_ps.c delta_T.c drive_logZscroll_Ts.c drive_xHIscroll.c drive_zscroll_noTs.c elec_interp.c extract_delTps.pl fftCMB.c filter.c filter_den_hist.c find_halos.c find_HII_bubbles.c gen_size_distr.c heating_helper_progs.c init.c kSZ_power.c Makefile perturb_field.c print_power_spec_ICs.c PROGRAM_LIST ps.c redshift_interpolate_boxes.c Ts.c update_halo_pos.c; do
        ln -s ../../../$dir/$file $subdir/$dir
    done
done
