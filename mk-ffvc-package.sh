#!/bin/sh

echo "Generate install.sh"
/Users/keno/bin/ffvc_generate_install-script.sh

#########
# check branch, see if which is alternatives

###
# set base directory
export BASEDIR=/myapps

###
# set Version

pushd $BASEDIR/TextParser
export VER_TP=`git describe --tags`
popd

pushd $BASEDIR/PMlib
export VER_PM=`git describe --tags`
popd

pushd $BASEDIR/Polylib
export VER_PL=`git describe --tags`
popd

# pushd $BASEDIR/Cutlib
# export VER_CUT=`git describe --tags`
# popd

pushd $BASEDIR/CPMlib
export VER_CPM=`git describe --tags`
popd

pushd $BASEDIR/CDMlib
export VER_CDM=`git describe --tags`
popd

pushd $BASEDIR/FFVC
export VER_FFV=`git describe --tags` 
popd

echo TextParser $VER_TP
echo PMlib      $VER_PM
echo Polylib    $VER_PL
echo CPMlib     $VER_CPM
echo CDMlib     $VER_CDM
echo FFVC       $VER_FFV

# echo Cutlib     $VER_CUT


#########

mkdir ffvc_package-$1
cd ffvc_package-$1

mv ~/install_*.sh .
chmod +x ./install_*.sh


pushd $BASEDIR/CDMlib
git archive --format=tar --prefix=CDMlib-$VER_CDM/ $VER_CDM | gzip > CDMlib-$VER_CDM.tar.gz
popd
mv $BASEDIR/CDMlib/CDMlib-$VER_CDM.tar.gz . 


pushd $BASEDIR/CPMlib
git archive --format=tar --prefix=CPMlib-$VER_CPM/ $VER_CPM | gzip > CPMlib-$VER_CPM.tar.gz
popd
mv $BASEDIR/CPMlib/CPMlib-$VER_CPM.tar.gz . 


# pushd $BASEDIR/Cutlib
# git archive --format=tar --prefix=Cutlib-$VER_CUT/ $VER_CUT | gzip > Cutlib-$VER_CUT.tar.gz
# popd
# mv $BASEDIR/Cutlib/Cutlib-$VER_CUT.tar.gz . 


pushd $BASEDIR/Polylib
git archive --format=tar --prefix=Polylib-$VER_PL/ $VER_PL | gzip > Polylib-$VER_PL.tar.gz
popd
mv $BASEDIR/Polylib/Polylib-$VER_PL.tar.gz . 


pushd $BASEDIR/PMlib
git archive --format=tar --prefix=PMlib-$VER_PM/ $VER_PM | gzip > PMlib-$VER_PM.tar.gz
popd
mv $BASEDIR/PMlib/PMlib-$VER_PM.tar.gz . 


pushd $BASEDIR/TextParser
git archive --format=tar --prefix=TextParser-$VER_TP/ $VER_TP | gzip > TextParser-$VER_TP.tar.gz
popd
mv $BASEDIR/TextParser/TextParser-$VER_TP.tar.gz . 


pushd $BASEDIR/FFVC
git archive --format=tar --prefix=FFVC-$VER_FFV/ $VER_FFV | gzip > FFVC-$VER_FFV.tar.gz
popd
mv $BASEDIR/FFVC/FFVC-$VER_FFV.tar.gz . 



