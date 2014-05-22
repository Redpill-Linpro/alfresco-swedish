#!/bin/bash
# Download each project from CrowdIn, and package is a JAR
# Includes the TinyMCE localization

#if [ -z "$CROWDIN_USER_KEY" ]; then
#    echo "Environment variable CROWDIN_USER_KEY must be set to your personal Crowdin api key to run this script. Set it with \"export CROWDIN_USER_KEY=yourkey\" "
#    exit 1
#fi 

l="sv_SE"

rm -rf ./work/alf-i18n_${l}
mkdir -p ./work/alf-i18n_${l}

cd ./work/alf-i18n_${l}

curl -L http://www.tinymce.com/i18n/download.php?download=${l} > tinymce.zip

curl -L http://crowdin.net/download/project/alfresco/sv-SE.zip > alfresco.zip

unzip tinymce.zip 
unzip alfresco.zip

for f in `find alfresco -type f`; do
  mv $f ${f%.properties}_${l}.properties;
done;

for f in `find share -type f`; do
  mv $f ${f%.properties}_${l}.properties;
done;

#Repository translations:
mkdir -p repo/META-INF
touch repo/META-INF/MANIFEST.MF
cp -rf alfresco repo/
cp -rf rm/repo/config/alfresco/* repo/alfresco/
rm -r alfresco rm


#Share translations:
mkdir -p share/alfresco
cp -rf share/* share/alfresco/
cp -rf rm/share/config/alfresco/* share/alfresco/
#TinyMCE
mkdir -p share/META-INF/modules/editors/tiny_mce
mv langs share/META-INF/modules/editors/tiny_mce/

#Create jar
zip -r alfresco-${l}.jar repo/META-INF repo/alfresco
zip -r share-${l}.jar share/META-INF share/alfresco


  
