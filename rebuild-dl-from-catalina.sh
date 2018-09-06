#!/bin/bash

if [ $# -lt 1 ];
then 
	echo "Usage: $0 catalina.out [placeholder]"
else
	IFS=$'\n'
	CATALINA=$1
	PLACEHOLDER='placeholder.jpg'
	
	if [ $# -eq 2 ];
	then 
		PLACEHOLDER=$2
	fi

	cat $CATALINA | grep "Caused by: java.io.FileNotFoundException: " | sed 's/^Caused by: java.io.FileNotFoundException: //g' | sed 's/ (.*)$//g' > /tmp/catalina-filepath.txt

	numFiles=`cat /tmp/catalina-filepath.txt | wc -l`
	currFile=1
	
	for i in `cat /tmp/catalina-filepath.txt`; 
	do
		echo -ne 'Copying file' $currFile 'of ' $numFiles '...\r'
		mkdir -p `dirname $i`
		cp placeholder.jpg $i
		((currFile++))
	done

	
	rm -f /tmp/catalina-filepath.txt

	echo $PLACEHOLDER $CATALINA 
	echo "Done!"
fi
