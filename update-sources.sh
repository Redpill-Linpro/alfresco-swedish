#!/bin/bash
# Download each project from CrowdIn, and package is a JAR
# Includes the TinyMCE localization

l="sv"

rm -rf ./work/alf-i18n_${l}
mkdir -p ./work/alf-i18n_${l}

cd ./work/alf-i18n_${l}

curl -L http://www.tinymce.com/i18n/download.php?download=sv_SE > tinymce.zip

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
mv langs share/META-INF/modules/editors/tiny_mce/

# Fix bug with rm.properties where swedish characters are not automatically encoded
native2ascii share/alfresco/messages/rm_sv.properties share/alfresco/messages/rm_sv.properties
rm -r alfresco rm
#Create jar
cd repo
zip -r alfresco-${l}.jar META-INF alfresco
mv alfresco-${l}.jar ../
cd ..
cd share
zip -r share-${l}.jar META-INF alfresco
mv share-${l}.jar ../
cd ..


