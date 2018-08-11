#! /bin/bash
# Chris Watson, 2018-08-09

usage() {
    cat << !

 Export some directory- and filename-related variables for DTI preprocessing,
 analysis, etc. using FSL tools.

!
}

projdir=${PWD}
if [[ ${bids} -eq 1 ]]; then
    target=sub-${subj}
    rawdir=rawdata/sub-${subj}/
    if [[ ${long} -eq 1 ]]; then
        target=${target}_ses-${sess}
        rawdir=${rawdir}/ses-${sess}
    fi
    if [[ ${acq} != '' ]]; then
        target=${target}_acq-${acq}_dwi
    fi
    rawdir=${rawdir}/dwi
    srcdir=${rawdir/rawdata/sourcedata}
    resdir=${rawdir/rawdata/tractography}
    resdir=${resdir/dwi/dti2}
else
    target=dwi_orig
    rawdir=${subj}
    if [[ ${acq} != '' ]]; then
        rawdir=${rawdir}/${acq}
    fi
    srcdir=${rawdir}
    resdir=${rawdir}
fi

[[ ! -d ${srcdir} ]] && echo -e "Subject ${subj} is not valid!\n" && exit 2

export projdir target rawdir srcdir resdir