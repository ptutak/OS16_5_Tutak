#!/bin/bash

make

git clone https://github.com/nathanweeks/ipcmd.git ./ipcmd-download

cd ./ipcmd-download/
make
cd ..

echo "komunikacja poprzez programy:"

./kolejka-send
wiadomosc=`./kolejka-receive`

echo ${wiadomosc}
if [[ "${wiadomosc}" != "wyraz niepoprawny" ]]; then

	wynik=`echo ${wiadomosc} | cut -d":" -f2 | aspell list -l pl`

	if [[ "${wynik}" = "" ]]; then
		echo "słowo poprawne w języku polskim"
	else
		echo "słowo niepoprawne w języku polskim"
	fi
fi

