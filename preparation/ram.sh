#!/bin/bash
mkdir -p "$SPOT_FOLDER/ram"
$DEXTER_JAVA it.cnr.isti.hpc.dexter.cli.spot.ram.GenerateSpotsMinimalPerfectHashCLI  -output $SPOT_HASHES

echo "Uncompressing spot file $SPOT_FILE"
zcat ${SPOT_FILE/.gz/} > $TTMP

echo "Uncompressing hash file $SPOT_HASHES"
gunzip $SPOT_HASHES

SPOT_HASHES=${SPOT_HASHES/.gz/} 

echo "Paste the spot file with the hashes"
paste $SPOT_HASHES  $TTMP > $TMP
echo "Sorting the file by hash (output in $TTMP)"
sort -nk1 $TMP > $TTMP
cut -f 2,3,4,5,6 $TTMP > $TMP
echo "Index spot file and generate offsets"
$DEXTER_JAVA it.cnr.isti.hpc.dexter.cli.spot.ram.IndexSpotFileAndGenerateOffsetsCLI -input $TMP
echo "Index offsets using eliasfano"
$DEXTER_JAVA it.cnr.isti.hpc.dexter.cli.spot.ram.IndexOffsetsUsingEliasFanoCLI

#echo "Delete tmp files"
#rm $TMP $TTMP 
#rm $SPOT_HASHES
