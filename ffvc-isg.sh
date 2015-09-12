#!/bin/bash

cwd=`dirname $0`

###
# set base directory
BASEDIR=/myapps

###
# taget

arg=$2
if [ "x${arg}" = "x" ]; then
  echo "argument $2 is empty."
  exit 1
fi


# OpenMP option
if [ "x${arg}" = "xintel" ]; then
  OPT_OMP=" -openmp"
elif [ "x${arg}" = "xgnu" ]; then
  OPT_OMP=" -fopenmp"
else
  OPT_OMP=""
fi


# Host option
OPT_HOST=""
if [ "x${arg}" = "xfx" ]; then
	OPT_HOST="--host=sparc64-unknown-linux-gnu"
fi



# Compiler
if [ "x${arg}" = "xintel" ]; then
	ARCH="INTEL"
	TMP_CCC="mpicc"
	TMP_CXX="mpicxx"
	TMP_F90="mpif90"
	CFLAG_BASE="-O3"
    FFLAG_BASE="-O3"
    CFLAG_APPS="-O3 -openmp -qopt-report=5"
    FFLAG_APPS="-O3 -Warn unused -fpp -openmp -qopt-report=5"
elif [ "x${arg}" = "xgnu" ]; then
	ARCH="GNU"
	TMP_CCC="mpicc"
	TMP_CXX="mpicxx"
	TMP_F90="mpif90"
	CFLAG_BASE="-O3"
    FFLAG_BASE="-O3"
    CFLAG_APPS="-O3 -fopenmp"
    FFLAG_APPS="-O3 -cpp -fopenmp -ffree-form --free-line-length-none"
elif [ "x${arg}" = "xfx" ]; then
	ARCH="FJ"
	TMP_CCC="mpifccpx"
	TMP_CXX="mpiFCCpx"
	TMP_F90="mpifrtpx"
	CFLAG_BASE="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc -x0"
    FFLAG_BASE="-Kfast,ocl,preex,simd=2,uxsimd,array_private,parallel,openmp,optmsg=2 -V -Nsrc"
    CFLAG_APPS="$CFLAG_BASE"
    FFLAG_APPS="$FFLAG_BASE"
fi

###
# set Version

cd $BASEDIR/TextParser
VER_TP=`git describe --tags`

cd $BASEDIR/PMlib
VER_PM=`git describe --tags`

cd $BASEDIR/Polylib
VER_PL=`git describe --tags`

#cd $BASEDIR/Cutlib
#VER_CT=`git describe --tags`

cd $BASEDIR/CPMlib
VER_CM=`git describe --tags`

cd $BASEDIR/CDMlib
VER_CO=`git describe --tags`

cd $BASEDIR/FFVC
VER_FV=`git describe --tags` 

cd $cwd


###
# replae version by awk script

cat $1 | awk -v ht="$OPT_HOST" \
			-v arch="$ARCH" \
			-v ccc_cmp="$TMP_CCC" \
			-v cpp_cmp="$TMP_CXX" \
			-v f90_cmp="$TMP_F90" \
			-v cflag_base="$CFLAG_BASE" \
			-v fflag_base="$FFLAG_BASE" \
			-v cflag_apps="$CFLAG_APPS" \
			-v fflag_apps="$FFLAG_APPS" \
			-v tp="$VER_TP" \
			-v pm="$VER_PM" \
			-v pl="$VER_PL" \
			-v cm="$VER_CM" \
			-v co="$VER_CO" \
			-v fv="$VER_FV" \
			-v op="$OPT_OMP" '

BEGIN {
}

NR == 5 {  
	sub("TEMPLATE","");
}

{
	sub("@VER_TP@",tp);
	sub("@VER_PM@",pm);
	sub("@VER_PL@",pl);
	sub("@VER_CPM@",cm);
	sub("@VER_CDM@",co);
	sub("@VER_FFVC@",fv);
	sub("@OPT_OMP@",op);
	sub("@OPT_HOST@",ht);
	sub("@ARCH@",arch);
	sub("@TMP_CCC@",ccc_cmp);
	sub("@TMP_CXX@",cpp_cmp);
	sub("@TMP_F90@",f90_cmp);
	sub("@CFLAG_BASE@",cflag_base);
    sub("@FFLAG_BASE@",fflag_base);
    sub("@CFLAG_APPS@",cflag_apps);
    sub("@FFLAG_APPS@",fflag_apps);
	print;
} 

END {
}
'

