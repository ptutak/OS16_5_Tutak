#!/bin/bash


il_hash=20

l_sek=20

for x in {1..20}; do
	timeout ${l_sek}s parec -r>plik${x}
done

echo ""
echo "wykres dla basha:"
echo "# - oznacza ${il_hash} linii 'numerycznych'"
echo ""
for x in {1..20}; do

	il_linii=`cat plik${x} | tr -d -c [:alnum:] | fold --width=8 | wc -l`
	il_linii_numer=`cat plik${x} | tr -d -c [:alnum:] | fold --width=8 | grep -e "^[0-9]\{8\}$" | wc -l`
	proc=`echo "scale=2;${il_linii_numer} * 100 / ${il_linii}" | bc`

	if [[ `echo "${proc}" | head -c 1` == "." ]]; then
		proc="0${proc}"
	elif [[ `echo "${proc}" | head -c 1` == "0" ]]; then
		proc="${proc}.00"
	fi

	echo -n -e "plik${x}\t: ${il_linii_numer}\t${proc}%\t|"

	il_znakow=$((${il_linii_numer}/${il_hash}))
	
	while (( ${il_znakow} > 0 ))
	do
		echo -n "#"
		il_znakow=$((${il_znakow}-1))
	done
	
	echo ""
done
echo ""
