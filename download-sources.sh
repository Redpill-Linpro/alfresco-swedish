#!/bin/bash
rm work/*.jar
echo "Downloading alfresco-sv-SE.jar"
curl -o work/alfresco-sv-SE.jar http://alf-trans.ossportal.org/files/alfresco-sv-SE.jar
echo "Downloading share-sv-SE.jar"
curl -o work/share-sv-SE.jar http://alf-trans.ossportal.org/files/share-sv-SE.jar
echo "Downloading repo-rm-sv-SE.jar"
curl -o work/repo-rm-sv-SE.jar http://alf-trans.ossportal.org/files/repo-rm-sv-SE.jar
echo "Downloading share-rm-sv-SE.jar"
curl -o work/share-rm-sv-SE.jar http://alf-trans.ossportal.org/files/share-rm-sv-SE.jar



