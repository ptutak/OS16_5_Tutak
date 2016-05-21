#!/bin/bash

make
echo ""
echo "Komunikacja poprzez programy w C:"
echo ""
./kolejka-send
wiadomosc=`./kolejka-receive`

echo ${wiadomosc}
if [[ "${wiadomosc}" != "wyraz niepoprawny" ]]; then

	wynik=`echo ${wiadomosc} | cut -d":" -f2 | aspell list -l pl`

	if [[ "${wynik}" == "" ]]; then
		echo "słowo poprawne w języku polskim"
	else
		echo "słowo niepoprawne w języku polskim"
	fi
fi
echo ""
echo "Komunikacja poprzez skrypt i ipcmd:"
echo ""
git clone https://github.com/nathanweeks/ipcmd.git ./ipcmd-download

cd ./ipcmd-download/
make
cd ..

klucz=`./ipcmd-download/bin/ipcmd ftok ./kolejka-send 90`
msgid=`./ipcmd-download/bin/ipcmd msgget -Q ${klucz} -e -m 0600`

echo ""
echo "Podaj wyraz:"
read wyraz

./ipcmd-download/bin/ipcmd msgsnd -q ${msgid} -t 255 -n ${wyraz}

wyraz_wynik=`./ipcmd-download/bin/ipcmd msgrcv -q ${msgid} -t 255 -n`

ipcrm -q ${msgid}
znak=`printf "%d" "'${wyraz_wynik:0:1}"`
if ([[ ${znak} -ge 65 ]] && [[ ${znak} -le 90 ]]) || ([[ ${znak} -ge 97 ]] && [[ ${znak} -le 122 ]]); then
	bool=1
	for x in `seq 1 $((${#wyraz_wynik}-1))`
	do
		znak=`printf "%d" "'${wyraz_wynik:${x}:1}"`
		
		if [[ ${znak} -lt 0 ]] || [[ ${znak} -gt 127 ]]; then
			bool=0
		fi
	done
	if [[ ${bool} == 1 ]]; then
		echo "wyraz poprawny:${wyraz_wynik}"
		
		wynik=`echo "${wyraz_wynik}" | aspell list -l pl`
		
		if [[ "${wynik}" == "" ]]; then
			echo "słowo poprawne w języku polskim"
		else
			echo "słowo niepoprawne w języku polskim"
		fi

	else
		echo "wyraz niepoprawny"
	fi
else
	echo "wyraz niepoprawny"
fi
echo ""
