#!/bin/bash

# Creates required repository out of a wikipedia dump
source $(pwd)/config.sh

path=$(pwd)
echo "Downloading Wikipedia Dump"
wget "http://dumps.wikimedia.org/${LANGUAGE}wiki/latest/${LANGUAGE}wiki-latest-pages-articles.xml.bz2"
WIKI_XML_DUMP="$path/${LANGUAGE}wiki-latest-pages-articles.xml.bz2"
WIKI_JSON_DUMP="$path/${LANGUAGE}wiki-dump.json.gz"

# Generate the json dump from a wikipedia dump
$JSON_WIKI_JAVA "it.cnr.isti.hpc.wikipedia.cli.MediawikiToJsonCLI" "-input" $WIKI_XML_DUMP "-output" $WIKI_JSON_DUMP "-lang" $LANGUAGE
#rm $WIKI_XML_DUMP
export  WIKI_JSON=$WIKI_JSON_DUMP
