#!/bin/bash

if [ ! -f "work/sv-SE.zip" ]
  then
    echo "Error: Source file does not exist: work/sv-SE.zip"
    exit 0
fi

echo "Extracting language packs"

rm -rf ./work/alfresco-sv-SE
rm -rf ./work/repo-rm-sv-SE
rm -rf ./work/share-rm-sv-SE
rm -rf ./work/share-sv-SE
rm -rf ./work/sv-SE
unzip ./work/sv-SE.zip -d ./work/sv-SE


echo "Clearing out old checked in language packs"

rm -rf ./repo/src/main/resources/*
rm -rf ./repo-rm/src/main/resources/*
rm -rf ./share/src/main/resources/*
rm -rf ./share-rm/src/main/resources/*

echo "Updating all source files"

#Alfresco
cp -rf ./work/sv-SE/5.2/alfresco ./repo/src/main/resources/
cp -rf ./work/sv-SE/5.2/google-docs/repo/alfresco/* ./repo/src/main/resources/alfresco/
#Share
cp -rf ./work/sv-SE/5.2/share/alfresco ./share/src/main/resources/
cp -rf ./work/sv-SE/5.2/google-docs/share/alfresco/* ./share/src/main/resources/alfresco/
mkdir ./share/src/main/resources/META-INF
cp -rf ./work/sv-SE/5.2/share/META-INF/js ./share/src/main/resources/META-INF/
#Aikau
mkdir -p ./share/src/main/resources/alfresco/site-webscripts/org/alfresco/aikau/webscript/libs
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/webscript-libs/ ./share/src/main/resources/alfresco/site-webscripts/org/alfresco/aikau/webscript/libs/
mkdir ./share/src/main/resources/META-INF/js/aikau
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.101.3/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.101.3/
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.101.12/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.101.12/
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.101.13/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.101.13/
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.101.16/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.101.16/
# 1.0.101.19 - 5.2.6
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.101.19/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.101.19/
#1.0.101.21 - 6.2.2
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.101.21/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.101.21/
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.102/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.102/
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.104/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.104/
# 1.0.114 - 7.1.1
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.114/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.114/
# 1.0.119  7.2.0
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.119/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.119/
# 1.0.120  7.2.0
mkdir ./share/src/main/resources/META-INF/js/aikau/1.0.120/
cp -rf ./work/sv-SE/5.2/aikau/src/main/resources/alfresco ./share/src/main/resources/META-INF/js/aikau/1.0.120/



#RM
cp -rf ./work/sv-SE/5.2/rm/repo/config/alfresco ./repo-rm/src/main/resources/
cp -rf ./work/sv-SE/5.2/rm/share/config/alfresco ./share-rm/src/main/resources/
mkdir ./share-rm/src/main/resources/META-INF
cp -rf ./work/sv-SE/5.2/rm/share/source/web/js ./share-rm/src/main/resources/META-INF/

echo "Extracting TinyMCE"
rm -rf ./work/tinymce_sv-SE
unzip ./work/tinymce_sv-SE.zip -d ./work/tinymce_sv-SE

echo "Updating source files with TinyMCE translation"
mkdir -p ./share/src/main/resources/META-INF/modules/editors/tinymce/langs
cp -rf ./work/tinymce_sv-SE/langs/sv_SE.js ./share/src/main/resources/META-INF/modules/editors/tinymce/langs/
cp -rf ./work/tinymce_sv-SE/langs/sv_SE.js ./share/src/main/resources/META-INF/modules/editors/tinymce/langs/sv.js

echo "Making manual injections"
#Missing translations for workflow tasks: https://issues.alfresco.com/jira/browse/ALF-21841
#begin
cat ./repo-manual-additions/src/main/resources/alfresco/workflow/workflow-messages_sv.properties >> ./repo/src/main/resources/alfresco/workflow/workflow-messages_sv.properties
#end
