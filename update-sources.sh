#!/bin/bash
# Download each project from CrowdIn, and package is a JAR
# Includes the TinyMCE localization

l="sv"
echo "Resetting working directories"
rm -rf ./work/alf-i18n_${l}
mkdir -p ./work/alf-i18n_${l}
cd ./work/alf-i18n_${l}

echo "Downloading TinyMCE"
curl 'http://www.tinymce.com/i18n3x/index.php?ctrl=export&act=zip' -H 'Content-Type: application/x-www-form-urlencoded' --data 'la%5B%5D=sv&la_export=js&pr_id=7&submitted=Download' > tinymce.zip

echo "Downloading Alfresco translations from Crowdin"
curl -L http://crowdin.net/download/project/alfresco/sv-SE.zip > alfresco.zip

echo "Unzipping TinyMCE translations"
unzip tinymce.zip 
echo "Unzipping Alfresco translations"
unzip alfresco.zip

echo "Renaming translated files to have country postfix"
for f in `find alfresco -type f`; do
  mv $f ${f%.properties}_${l}.properties;
done;

for f in `find share -type f`; do
  mv $f ${f%.properties}_${l}.properties;
done;

for f in `find rm -type f`; do
  mv $f ${f%.properties}_${l}.properties;
done;

echo "Rearranging repository translations"
#Repository translations:
mkdir -p repo/META-INF
touch repo/META-INF/MANIFEST.MF
cp -rf alfresco repo/
cp -rf rm/repo/config/alfresco/* repo/alfresco/

echo "Rearranging share translations"
#Share translations:
#mkdir -p share/alfresco
#cp -rf share/* share/alfresco/
cp -rf rm/share/config/alfresco/* share/alfresco/

echo "Rearranging TinyMCE translations"
#TinyMCE
mkdir -p share/META-INF/modules/editors/tiny_mce
mv tinymce_language_pack/* share/META-INF/modules/editors/tiny_mce/

echo "Rearranging Aikau translations"
cd share
A_DIR="aikau/all/"
SHARE=$(pwd)
cd META-INF/js

DIRS=$(find alfresco/ -type d -name 'i18n' )
for DIR in $DIRS; do
	mkdir -p $A_DIR/$DIR
	cp $DIR/* $A_DIR/$DIR
done

echo "Linking Aikau versions"
cd aikau
ln -s all 1.0.8.1
ln -s all 1.0.8.2
ln -s all 1.0.25.2 # EE 5.0.2.5
ln -s all 1.0.52 # EE 5.0.3
cd ../../../../

echo "Moving repository translations into maven sources tree"
echo "Current folder: $PWD"
rm -r alfresco rm
#Create jar
cd repo
#first move rm stuff
rm -r ../../../repo-rm/src/main/resources/alfresco
mkdir -p ../../../repo-rm/src/main/resources/alfresco/module
mv alfresco/module/org_alfresco_module_rm ../../../repo-rm/src/main/resources/alfresco/module/
rm -r ../../../repo/src/main/resources/alfresco
cp -r alfresco ../../../repo/src/main/resources/
#zip -r alfresco-${l}.jar META-INF alfresco
#mv alfresco-${l}.jar ../

echo "Moving Share translations into maven sources tree"
echo "Current folder: $PWD"
cd ..
cd share
#First move rm stuff
rm -r ../../../share-rm/src/main/resources/alfresco
rm -r ../../../share-rm/src/main/resources/META-INF
mkdir -p ../../../share-rm/src/main/resources/alfresco/messages
mkdir -p ../../../share-rm/src/main/resources/alfresco/site-webscripts/org/alfresco
mv alfresco/dod5015 ../../../share-rm/src/main/resources/alfresco/
mv alfresco/messages/rm_sv.properties ../../../share-rm/src/main/resources/alfresco/messages/
mv alfresco/site-webscripts/org/alfresco/rm ../../../share-rm/src/main/resources/alfresco/site-webscripts/org/alfresco/
rm -r ../../../share/src/main/resources/alfresco
rm -r ../../../share/src/main/resources/META-INF
cp -r alfresco ../../../share/src/main/resources/
cp -r META-INF ../../../share/src/main/resources/
#zip -r share-${l}.jar META-INF alfresco
#mv share-${l}.jar ../
cd ..


