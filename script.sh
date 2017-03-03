#!/bin/bash
echo "=============================" > CPI.txt
echo "Part1" >> CPI.txt
declare -a part1flag=('-fetch:ifqsize'  '-decode:width'  '-issue:width'  '-commit:width');
declare -a part1para=(1 2 4 8);
for flag in "${part1flag[@]}"
do
	for para in "${part1para[@]}"
	do
		echo $flag $para >> CPI.txt
		../sim-wattch-1.02e/sim-outorder $flag $para compress95.alpha <compress95.in 2>compress95.txt
		awk 'NR==211' compress95.txt >> CPI.txt
		awk 'NR==313' compress95.txt >> CPI.txt
	done
	echo "~~~~~~~~~~~~~~~~" >>CPI.txt
done
echo "=============================" >> CPI.txt
echo "Part2" >> CPI.txt
declare -a part2para=('nottaken' 'taken' 'bimod' '2lev');
for para in "${part2para[@]}"
do
	echo $para >> CPI.txt
	../sim-wattch-1.02e/sim-outorder -bpred $para compress95.alpha <compress95.in 2>compress95.txt
	awk 'NR==211' compress95.txt >> CPI.txt
	awk 'NR==244' compress95.txt >> CPI.txt
done
echo "=============================" >> CPI.txt
echo "Part3" >> CPI.txt
declare -a part3para=(32 64 128 256);
for para in "${part3para[@]}"
do
	echo "Cache Blcok Size:" $para >> CPI.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:$para:4:l compress95.alpha <compress95.in 2>compress95.txt
	awk 'NR==211' compress95.txt >> CPI.txt
	awk 'NR==274' compress95.txt >> CPI.txt
	awk 'NR==278' compress95.txt >> CPI.txt
done
echo "~~~~~~~~~~~~~~~~" >>CPI.txt
declare -a part3para=('f' 'l' 'r');
for para in "${part3para[@]}"
do
	echo "Cache Replacement Policy:" $para >> CPI.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:64:4:$para compress95.alpha <compress95.in 2>compress95.txt
	awk 'NR==211' compress95.txt >> CPI.txt
	awk 'NR==274' compress95.txt >> CPI.txt
	awk 'NR==278' compress95.txt >> CPI.txt
	awk 'NR==279' compress95.txt >> CPI.txt
done
echo "~~~~~~~~~~~~~~~~" >>CPI.txt
declare -a part3para=(1 4 8 128);
for para in "${part3para[@]}"
do
	echo "Cache Associativity:" $para >> CPI.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:32:$para:l compress95.alpha <compress95.in 2>compress95.txt
	awk 'NR==211' compress95.txt >> CPI.txt
	awk 'NR==264' compress95.txt >> CPI.txt
	awk 'NR==274' compress95.txt >> CPI.txt
	awk 'NR==278' compress95.txt >> CPI.txt
done
exit 0
