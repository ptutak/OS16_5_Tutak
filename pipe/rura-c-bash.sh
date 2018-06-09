#!/bin/bash

il_hash=20
./rurac >plik-rura-c

il_linii=`cat ./plik-rura-c | wc -l`
il_linii_numer=`cat ./plik-rura-c | grep -e "^[0-9]\{8\}$" | wc -l`

echo "wykres dla programu:"
echo "# - oznacza ${il_hash} linii 'numerycznych'"
echo ""

proc=`echo "scale=2;${il_linii_numer} * 100 / ${il_linii}" | bc`
if [[ `echo "${proc}" | head -c 1` == "." ]]; then
	proc="0${proc}"
elif [[ `echo "${proc}" | head -c 1` == "0" ]]; then
	proc="${proc}.00"
fi
echo -n -e "plikc\t: ${il_linii_numer}\t${proc}%\t|"

il_znakow=$((${il_linii_numer}/${il_hash}))

while (( ${il_znakow} > 0 ))
do
	echo -n "#"
	il_znakow=$((${il_znakow}-1))
done
echo -e "\n"
