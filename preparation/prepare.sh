#!/bin/bash
source $(pwd)/config.sh

usage ()
{
  echo "prepare.sh"
  echo "usage: ./prepare.sh en en.data  or ./prepare.sh fr fr.data "
  echo "Creates a Wikipedia repository which can be fed into SMILK Named Entity Linking tools."
}

if [ "$#" -ne 2 ]
then
  usage
  exit
fi

BASE_DIR=$(pwd)
WDIR="$2"
LANGUAGE=`echo $1 | sed "s/_.*//g"`

echo "Language: $LANGUAGE"
echo "Working directory: $WDIR"

xmlconfige=dexter-conf.xml

#mkdir -p "$WDIR"
export DIR=$WDIR
# spot folder
SPOT_FOLDER=$WDIR/spot
mkdir -p "$SPOT_FOLDER"
# graph data folder 
GRAPH_DIR=$WDIR/graph
mkdir -p "$GRAPH_DIR"
# mapdb data folder 
MAPDB_DIR=$WDIR/mapdb
mkdir -p "$MAPDB_DIR"

# update dexter-config.xml based on current arguments
xmlstarlet ed -L -u "config/models/default" -v $LANGUAGE  $xmlconfige
xmlstarlet ed -L -u "config/models/model[name='$LANGUAGE']/path" -v $BASE_DIR/$WDIR  $xmlconfige
 
source $(pwd)/wiki2json.sh
source $(pwd)/extract.sh

echo "Done!"
