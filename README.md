# SmilkNel-REST service

The following guide is guaranteed to work using:  
- Java 1.8  
- Apache Tomcat 8.0.27

# Preparation Phase

If you have access to massivity (or to Viseo's FTP) this step is not mandatory. You can directly get the repository from `/data/dexter-smilk/` (or the equivalent).

For this phase you'll need a copy of `dexter-core-smilk-2.1.0-jar-with-dependencies.jar` (this file should be available on massivity - in `/data/dexter-smilk/`; if this isn't the case anymore or you don't have access, you can contact Viseo). You'll need to place this file in `preparation/jars/`. The repository for dexter-smilk can be found [here](https://github.com/nooralahzadeh/dexter-smilk). The scripts available here are only slightly modified versions of [Farah](https://github.com/nooralahzadeh)'s original files.

In order to create a repository, you'll have to execute:  
`./prepare.sh {lang} {folder}` where `lang` is the language you want to create the repository for and `folder/` is the folder where you want to have the repository.  
Example: `./prepare.sh en en.data` or `./prepare.sh fr fr.data`

This script will download a Wikipedia dump and create the repository. This will take a few hours for French and a few *days* for English so be sure to run it in a separate screen. The English model is around 50 GB (70 GB with the xml / json dumps); the French one is smaller (around 20 GB in total).

# Running the Web Service

For this phase you'll need:  
- the SmilkNel-rest repository ([available online](https://github.com/nooralahzadeh/SmilkNel-rest))  
- a copy of `dexter-core-smilk-2.1.0-jar-with-dependencies.jar`

Firstly, you'll need to install the afore-mentioned jar to you local repository. Change the directory to the SmilkNel-rest repository and execute the following command:  
`mvn install:install-file -Dfile=dexter-core-smilk-2.1.0-jar-with-dependencies.jar -DgroupId=it.cnr.isti.hpc -DartifactId=dexter-core-smilk -Dpackaging=jar -Dversion=2.1.0-jar-with-dependencies`.

Now, you'll want to modify the paths to the repository in `src/main/webapp/WEB-INF/dexter-conf.xml`. The FTP access isn't working at the moment. A correct model configuration should look like:  
```xml
<model>
  <name>en</name>
  <path>/data/dexter-smilk/en.data</path>
  <sparqlendpoint>http://dbpedia.org/sparql</sparqlendpoint>
  <access>local</access>
</model>
```

In order to create the `.war`, you can execute: `mvn package`. You'll find `SmilkNel-rest.war` in the `target/` folder. All it's left to do is to copy the `.war` in the `webapps/` folder of Tomcat and you should be good to go.


To start the Web Service you can simply execute the `./startup.sh` from the `bin` folder of Tomcat. The log is available at `logs/catalina.out` (you can followed it "interactively" by using `tail -f` for instace).

# Using the Web Service

The Web Service should be available at: `http://localhost:8080/smilkNel-rest/webresources/annotate`  
- To annotate French text:  
  * `/fr?spotter=NE&tool=<[renco,openNLP]>&method=<[pagerank,linear]>` - based on named entity recognition and you can select “renco” or “openNLP” as tool for spotting and “pagerank” or “linear” for linking method.  
  * `/fr?spotter=wiki&method=<[pagerank,linear]>` - based on wiki-dictionary spotting and you can select “pagerank” or “linear” for linking method.  
- To annotate English text:  
  * `/en?spotter=NE&tool=stanford&method=<[pagerank,linear]>` - based on named entity recognition and you can select “pagerank” or “linear” for linking method.  
  * `/en?spotter=wiki&method=<[pagerank,linear]>` - based on wiki-dictionary spotting and you can select “pagerank” or “linear” for linking method.

Here is a working example of a POST request for this Web Service in Python (using [Requests](http://docs.python-requests.org/en/master/)):  
```python
import requests
url = "http://localhost:8080/smilkNel-rest/webresources/annotate/en?spotter=wiki&method=linear"
text = "A guy at Best Bey told me that Samsung Gear Fit 2 will count your floors too!"

r = request.post(url, data = text)
#print(r)
```  
After executing this, you'll find in the logs the spotted named entities and their associated Wikipedia ids.
