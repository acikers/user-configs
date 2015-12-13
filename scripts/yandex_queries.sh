#!/bin/bash
FILENAME=yaq

curl -g "http://livequeries-front.corba.yandex.net/queries/?ll1=0,0&ll2=99.99,99.99&limit=1000" -o ${FILENAME}.xml 2>/dev/null

xml sel -T -t -m '//query/@text' -v '.' -n yaq.xml | sort | uniq -i > ${FILENAME}.new.txt

sort -m ${FILENAME}.new.txt ${FILENAME}.txt -o ${FILENAME}.txt
[ ! -f ${FILENAME}.txt ] && touch ${FILENAME}.txt
uniq -i ${FILENAME}.txt > ${FILENAME}.tmp.txt
mv ${FILENAME}.tmp.txt ${FILENAME}.txt
