#!/bin/bash
#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "Need tag version! Ex: 0.9.2"
    exit 0
fi

VERSION=$1
PROJECT="MercadoPagoTracker"
PODSPEC_FILE="$PROJECT.podspec"

if [ "$#" -eq 2 ]
  then
  	PROJECT=$2

fi

echo "=========================================="
echo "    Creating POD Project : $PROJECT  "
echo "=========================================="

echo "======================================================"
echo " 1) Update podspec file with spec version $VERSION"
echo "======================================================"

awk '/s.version.*/{if (M==""){sub("s.version.*","s.version          = \"'$VERSION'\"");M=1}}{print}' $PODSPEC_FILE > $PODSPEC_FILE.temp
STATUS=$?
if [ $STATUS -ne 0 ]
	then
		rm $PODSPEC_FILE.temp
		echo "Cannot update spec version in podspect file."
		exit 0
fi

cp $PODSPEC_FILE.temp $PODSPEC_FILE
rm $PODSPEC_FILE.temp


echo "=========================================="
echo "2) Validate .podspec --allow-warnings"
echo "=========================================="

pod lib lint --allow-warnings
STATUS=$?
if [ $STATUS -ne 0 ]
	then
		echo "Error ocurred. Validate podspec."
		exit 0
fi


echo "=========================================="
echo "3) Create tag for version $VERSION from development branch"
echo "=========================================="

git checkout master
git tag $VERSION
git push origin $VERSION
PUSH_STATUS=$?
if [ $PUSH_STATUS -ne 0 ]
	then
		echo "Error ocurred pushing tag."
		exit 0
fi


echo "=========================================="
echo "4) Push podspec into trunk/Specs"
echo "=========================================="
pod trunk push $PODSPEC_FILE --allow-warnings

echo "=========================================="
echo "		Pod created from tag $VERSION. 		"
echo " 			Versions available in 			"
echo "https://github.com/CocoaPods/Specs/tree/master/Specs/$PROJECT"
echo "=========================================="
