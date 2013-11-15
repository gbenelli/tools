#!/bin/tcsh

cmsenv

set CMSSW_BASE = `echo $CMSSW_BASE`
set VER     = `echo $CMSSW_VERSION`
set SOURCE  = $CMSSW_BASE/src
set SCRIPTS = $CMSSW_BASE/src/Documentation/ReferenceManualScripts/doxygen/python
set DATA    = $CMSSW_BASE/src/Documentation/ReferenceManualScripts/doxygen/data
set DOC     = $CMSSW_BASE/doc

if (-e $DOC) then
    rm -Rf $DOC
endif

mkdir $DOC
mkdir $DOC/html
cp -rf $DATA/iframes/ $DOC/html

sed -e 's|@CMSSW_IN@|'$SOURCE'|g' -e 's|@CMSSW_OUT@|'$DOC'|g' -e 's|@DOXY_PATH@|'$DATA'|g' $DATA/configfile > $DATA/configfile.conf

time doxygen $DATA/configfile.conf

rm $DATA/configfile.conf

time python $SCRIPTS/MainPageGenerator.py $DATA $DOC/html/ index.html $VER
echo
time python $SCRIPTS/Splitter.py $DOC/html/ annotated.html annotatedList_
echo
time python $SCRIPTS/ConfigFiles.py $DOC/html/ configfiles.html
echo
time python $SCRIPTS/Splitter.py $DOC/html/ namespaces.html namespaceList_
echo
time python $SCRIPTS/PackageSplitter.py $DOC/html/ pages.html packageDocumentation_
