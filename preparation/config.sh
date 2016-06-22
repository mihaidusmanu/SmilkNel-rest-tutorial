#!/bin/bash
# ram used 
XMX="-Xmx14g"
LOG=INFO
##LOG=DEBUG
LOGAT=1000
UTF8="-Dfile.encoding=utf8"
JAR_FOLDER=jars
  
#project name, do not change
PROJECT_NAME=dexter-core
#LOG=DEBUG
# log frequency
LOGAT=1000
# command line package, do not change
CLI=it.cnr.isti.hpc.dexter.cli
# error code
E_BADARGS=65

#UTF8="-Dfile.encoding=utf8"

path=$(pwd)
# java command
JSON_WIKI_VERSION="1.0.0"
JSON_WIKI_JAVA="java $XMX -Dlogat=$LOGAT -Dlog=$LOG -cp $path/$JAR_FOLDER/json-wikipedia-$JSON_WIKI_VERSION-jar-with-dependencies.jar"
 
# data directory
DATA_DIR=$DIR

# temporary file containing the labels and the redirects
TITLE_FILE=$DATA_DIR/title-redirect-id.tsv
# directory use for storing temporary files during files 
DEXTER_TMP_DIR=$DATA_DIR/tmp
# spot file, contains the edges of the wikipedia graph, each line represent an edge
# <spot> <tab> <source entity> <tab> <target entity>
SPOT=$SPOT_FOLDER/spot-src-target.tsv
# contains the the document frequency for each spot, 
# how many documents contains the spot as anchor text or raw text
SPOT_DOC_FREQ=$SPOT_FOLDER/spots-doc-freq.tsv
# contains the metadata for each spot:
# the candidate entities for the spot, the document frequency
SPOT_FILE=$SPOT_FOLDER/spots.tsv.gz
# contains the perfect hashes for the spots
SPOT_HASHES=$SPOT_FOLDER/spot-hashes.tsv.gz
# plain incoming node file
IN_EDGES=$GRAPH_DIR/incoming-edges.tsv.gz
# plain outcoming node file
OUT_EDGES=$GRAPH_DIR/outcoming-edges.tsv.gz
#temporary files used by the scripts
TMP=$DEXTER_TMP_DIR/tmp
TTMP=$DEXTER_TMP_DIR/tmp1
TTTMP=$DEXTER_TMP_DIR/tmp2 

mkdir -p "$DEXTER_TMP_DIR"

# Process Wiki
DEXTER_VERSION="2.1.0"
#project name, do not change
PROJECT_NAME=dexter-core-smilk
# command line package, do not change
CLI=it.cnr.isti.hpc.dexter.cli
DEXTER_JAVA="java  $XMX -Dlogat=$LOGAT -Dlog=$LOG -cp $path/$JAR_FOLDER/$PROJECT_NAME-$DEXTER_VERSION-jar-with-dependencies.jar "

export TMPDIR=$DEXTER_TMP_DIR
export SPOT=$SPOT
export SPOT_DOC_FREQ=$SPOT_DOC_FREQ

export LC_ALL=C
