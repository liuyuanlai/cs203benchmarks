#!/bin/bash
echo "=============================" > anagram.txt
echo "Part1" >> anagram.txt
declare -a part1flag=('-fetch:ifqsize'  '-decode:width'  '-issue:width'  '-commit:width');
declare -a part1para=(1 2 4 8);
for flag in "${part1flag[@]}"
do
	for para in "${part1para[@]}"
	do
		echo $flag $para >> anagram.txt
		../sim-wattch-1.02e/sim-outorder $flag $para anagram.alpha <anagram.in 2>anagram_result.txt
		awk 'NR==211' anagram_result.txt >> anagram.txt
		awk 'NR==313' anagram_result.txt >> anagram.txt
	done
	echo "~~~~~~~~~~~~~~~~" >>anagram.txt
done
echo "=============================" >> anagram.txt
echo "Part2" >> anagram.txt
declare -a part2para=('nottaken' 'taken' 'bimod' '2lev');
for para in "${part2para[@]}"
do
	echo $para >> anagram.txt
	../sim-wattch-1.02e/sim-outorder -bpred $para anagram.alpha <anagram.in 2>anagram_result.txt
	awk 'NR==211' anagram_result.txt >> anagram.txt
	awk 'NR==244' anagram_result.txt >> anagram.txt
done
echo "=============================" >> anagram.txt
echo "Part3" >> anagram.txt
declare -a part3para=(32 64 128 256);
for para in "${part3para[@]}"
do
	echo "Cache Blcok Size:" $para >> anagram.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:$para:4:l anagram.alpha <anagram.in 2>anagram_result.txt
	awk 'NR==211' anagram_result.txt >> anagram.txt
	awk 'NR==274' anagram_result.txt >> anagram.txt
	awk 'NR==278' anagram_result.txt >> anagram.txt
done
echo "~~~~~~~~~~~~~~~~" >>anagram.txt
declare -a part3para=('f' 'l' 'r');
for para in "${part3para[@]}"
do
	echo "Cache Replacement Policy:" $para >> anagram.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:64:4:$para anagram.alpha <anagram.in 2>anagram_result.txt
	awk 'NR==211' anagram_result.txt >> anagram.txt
	awk 'NR==274' anagram_result.txt >> anagram.txt
	awk 'NR==278' anagram_result.txt >> anagram.txt
	awk 'NR==279' anagram_result.txt >> anagram.txt
done
echo "~~~~~~~~~~~~~~~~" >>anagram.txt
declare -a part3para=(1 4 8 128);
for para in "${part3para[@]}"
do
	echo "Cache Associativity:" $para >> anagram.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:64:$para:l anagram.alpha <anagram.in 2>anagram_result.txt
	awk 'NR==211' anagram_result.txt >> anagram.txt
	awk 'NR==264' anagram_result.txt >> anagram.txt
	awk 'NR==274' anagram_result.txt >> anagram.txt
	awk 'NR==278' anagram_result.txt >> anagram.txt
	awk 'NR==321' anagram_result.txt >> anagram.txt
done
exit 0
