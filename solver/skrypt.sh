#!/bin/bash


gcc -pthread ./watki.c -o ./watki.out
gcc ./worker.c -o ./worker
gcc ./solver.c -o ./solver


rdzenie_fizyczne=`cat /proc/cpuinfo | grep cores | grep -o [0-9] | head -1`
rdzenie_logiczne=`cat /proc/cpuinfo | grep siblings | grep -o [0-9] | head -1`

liczba_zmiennych=$((${rdzenie_fizyczne}*2))

for x in `seq 1 ${liczba_zmiennych}` ; do
param[${x}]=$((${RANDOM}%4))
done

echo ""

if [ -n "${1}" ]; then
echo "Przyjmuje za zmienne: 1 2 3 4 0 1 2 3 4..."
for x in `seq 1 ${liczba_zmiennych}` ; do
		param[${x}]=$((${x}%5))
done
fi

echo "Uruchamiam program watkowy dla ${rdzenie_fizyczne} rdzeni fizycznych (${rdzenie_fizyczne} par parametrów)"


T=`date +%s%N`
tmp=`./watki.out ${param[@]}` 
T1=$((`date +%s%N`-${T}))
echo -e "Wyniki dla programu watkowego:\n${tmp}" 

wynik_watki=`echo ${tmp} | grep -o [0-9]* | sort`

echo "Uruchamiam program procesowy dla ${rdzenie_fizyczne} rdzeni fizycznych"

T=`date +%s%N`
tmp=`./solver ${param[@]}`
T2=$((`date +%s%N`-${T}))
echo -e "Wyniki dla programu procesowego:\n${tmp}"

echo ""

wynik_procesy=`echo ${tmp} | grep -o [0-9]* | sort`

echo "Czas dla programu watkowego(nanosekundy):   ${T1}"
echo "Czas dla programu procesowego(nanosekundy): ${T2}"

if [ "${wynik_watki}" = "${wynik_procesy}" ]; then
echo "Wyniki zwrocone przez programy sa takie same"
else
echo "Wyniki programów są rozne!!!"
fi

if [ ${T1} -gt ${T2} ]; then
	echo "Program procesowy wykonal sie szybciej"
elif [ ${T2} -gt ${T1} ]; then
	echo "Program watkowy wykonal sie szybciej"
else
	echo "Programy wykonaly sie rownie szybko"
fi

echo ""

liczba_zmiennych=$((${rdzenie_logiczne}*2))

for x in `seq 1 ${liczba_zmiennych}` ; do
param[${x}]=$((${RANDOM}%4))
done

if [ -n "${1}" ]; then
echo "Przyjmuje za zmienne: 1 2 3 4 0 1 2 3 4 ..."
for x in `seq 1 ${liczba_zmiennych}` ; do
		param[${x}]=$((${x}%5))
done
fi


echo "Uruchamiam program watkowy dla ${rdzenie_logiczne} rdzeni logicznych (${rdzenie_logiczne} par parametrów)"


T=`date +%s%N`
tmp=`./watki.out ${param[@]}` 
T1=$((`date +%s%N`-${T}))

echo -e "Wyniki dla programu watkowego:\n${tmp}"

wynik_watki=`echo ${tmp} | grep -o [0-9]* | sort`

echo "Uruchamiam program procesowy dla ${rdzenie_logiczne} rdzeni logicznych"

T=`date +%s%N`
tmp=`./solver ${param[@]}`
T2=$((`date +%s%N`-${T}))

echo -e "Wyniki dla programu procesowego:\n${tmp}"
echo ""

wynik_procesy=`echo ${tmp} | grep -o [0-9]* | sort`

echo "Czas dla programu watkowego(nanosekundy):   ${T1}"
echo "Czas dla programu procesowego(nanosekundy): ${T2}"

if [ "${wynik_watki}" = "${wynik_procesy}" ]; then
echo "Wyniki zwrocone przez programy sa takie same"
else
echo "Wyniki programów są rozne!!!"
fi

if [ ${T1} -gt ${T2} ]; then
	echo "Program procesowy wykonal sie szybciej"
elif [ ${T2} -gt ${T1} ]; then
	echo "Program watkowy wykonal sie szybciej"
else
	echo "Programy wykonaly sie rownie szybko"
fi
echo ""

