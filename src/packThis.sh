#!/bin/bash

# TODO: add checking for that
echo "Remember to run this script from root folder"
echo "Packing to " $1

echo "Creating folder structure"
mkdir -p $1

echo "Copy necessary files"
rsync -rP --exclude=".*" --exclude="demo/samples/*" --exclude="inst/data_sets/*" --exclude="cmake/*" --exclude="build/*" --exclude="doc/*" --exclude="libs/*" --exclude="tests/*" --exclude="..Rcheck/*" --include="*.cpp" --include="*.h" --include="*.hpp" --include="*.Rd" --include="*.c" --include="*.R" --include="*/" --exclude="*" . $1

# Copy datasets
mkdir $1/data
cp data/cec.mouse1.spherical.RData $1/data
cp data/cec.tset.RData $1/data
cp data/cec.ellipsegauss.RData $1/data
cp data/svm.transduction.RData $1/data
cp data/svm_breast_cancer_dataset.RData $1/data


# Some individual files
cp DESCRIPTION $1
cp LICENSE $1
cp NAMESPACE $1
cp demo/00Index $1/demo
cp src/Makevars $1/src
cp inst/include/svmlight/Makefile $1/inst/include/svmlight/
cp inst/include/svmlight/LICENSE.txt $1/inst/include/svmlight/

# TODO: this is scary, but rsync refuses to stop copying hidden files
# NOTE: be super, super scared of modyfing next line, and don't add -f by no means
# we all remember Steam bug, lol
rm -r $1/..Rcheck
rm -r $1/.git
rm -r $1/.idea

