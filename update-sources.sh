#!/bin/bash
# Download each project from CrowdIn, and package is a JAR
# Includes the TinyMCE localization

l="sv"

rm -rf ./work/alf-i18n_${l}
mkdir -p ./work/alf-i18n_${l}

cd ./work/alf-i18n_${l}

curl 'http://www.tinymce.com/i18n3x/index.php?ctrl=export&act=zip' -H 'Content-Type: application/x-www-form-urlencoded' --data 'la%5B%5D=sv&la_export=js&pr_id=7&submitted=Download' > tinymce.zip

curl -L http://crowdin.net/download/project/alfresco/sv-SE.zip > alfresco.zip

unzip tinymce.zip 
unzip alfresco.zip

for f in `find alfresco -type f`; do
  mv $f ${f%.properties}_${l}.properties;
done;

for f in `find share -type f`; do
  mv $f ${f%.properties}_${l}.properties;
done;

for f in `find rm -type f`; do
  mv $f ${f%.properties}_${l}.properties;
done;

#Repository translations:
mkdir -p repo/META-INF
touch repo/META-INF/MANIFEST.MF
cp -rf alfresco repo/
cp -rf rm/repo/config/alfresco/* repo/alfresco/

#Share translations:
#mkdir -p share/alfresco
#cp -rf share/* share/alfresco/
cp -rf rm/share/config/alfresco/* share/alfresco/
#TinyMCE
mkdir -p share/META-INF/modules/editors/tiny_mce
mv tinymce_language_pack/* share/META-INF/modules/editors/tiny_mce/

#Copy in the aikau sources to the correct place to support 5.0.1 and later
#mkdir -p share/META-INF/js/aikau/1.0.8.2
#cp -rf share/META-INF/js/alfresco share/META-INF/js/aikau/1.0.8.2/

cd share
A_DIR="aikau/all/"
SHARE=$(pwd)
cd META-INF/js

DIRS=$(find alfresco/ -type d -name 'i18n' )
for DIR in $DIRS; do
	mkdir -p $A_DIR/$DIR
	cp $DIR/* $A_DIR/$DIR
done
	
cd aikau
ln -s all 1.0.8.1
ln -s all 1.0.8.2
cd ..
cd ..

# Fix bug with rm.properties where swedish characters are not automatically encoded
#native2ascii share/alfresco/messages/rm_sv.properties share/alfresco/messages/rm_sv.properties
rm -r alfresco rm
#Create jar
cd repo
rm -r ../../../repo/src/main/resources/alfresco
cp -r alfresco ../../../repo/src/main/resources/
zip -r alfresco-${l}.jar META-INF alfresco
mv alfresco-${l}.jar ../
cd ..
cd share
rm -r ../../../share/src/main/resources/alfresco
rm -r ../../../share/src/main/resources/META-INF
cp -r alfresco ../../../share/src/main/resources/
cp -r META-INF ../../../share/src/main/resources/
zip -r share-${l}.jar META-INF alfresco
mv share-${l}.jar ../
cd ..


