Swedish Translation of Alfresco
===============================

This language pack is backed by a crowdin project: https://crowdin.com/project/alfresco

Please sign up there if you are interrested in contributing with translations.

This github project builds stable versions of the language pack.

Redpill Linpro manages these builds and publishes stable versions on our public maven repository https://maven.redpill-linpro.com/nexus/index.html#nexus-search;quick~alfresco-swedish.

Usage
-----
If you want to just download the translation and use it in your alfresco installation you can download the two jar files (one for the repository and one for share) from https://maven.redpill-linpro.com/nexus/index.html#nexus-search;quick~alfresco-swedish. Put these jars in your tomcat/shared/lib/ folder and restart Alfresco.

If you are building an amp using the Alfresco Maven SDK and want to include these jars, just add the following dependencies to your pom(s).

Repository translations:
```
<dependency>
  <groupId>org.redpill-linpro.alfresco.translations</groupId>
  <artifactId>alfresco-swedish-repo</artifactId>
  <version>6.2.5/version>
</dependency>
```

Share translations:
```
<dependency>
  <groupId>org.redpill-linpro.alfresco.translations</groupId>
  <artifactId>alfresco-swedish-share</artifactId>
  <version>6.2.5</version>
</dependency>
```


Building
--------
If you want to build the language pack yourself using the latest translations from Crowdin, please follow these instructions:

(Prerequisite is Linux OS + maven)

1. Clone this repository
2. Download built source files from Crowdin with the ./download-sources.sh script
3. Run ./update-sources.sh
4. mvn clean install

After the above steps has been done you will find the jar files containing the translation in the target folders of each submodule and in your local maven repository.
