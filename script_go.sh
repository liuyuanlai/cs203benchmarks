#!/bin/bash
echo "=============================" > go.txt
echo "Part1" >> go.txt
declare -a part1flag=('-fetch:ifqsize'  '-decode:width'  '-issue:width'  '-commit:width');
declare -a part1para=(1 2 4 8);
for flag in "${part1flag[@]}"
do
	for para in "${part1para[@]}"
	do
		echo $flag $para >> go.txt
		../sim-wattch-1.02e/sim-outorder $flag $para go.alpha 50 9 2stone9.in 2> go_result.txt
		#../sim-wattch-1.02e/sim-outorder $flag $para compress95.alpha <compress95.in 2>go_result.txt
		awk 'NR==211' go_result.txt >> go.txt
	done
	echo "~~~~~~~~~~~~~~~~" >>go.txt
done
echo "=============================" >> go.txt
echo "Part2" >> go.txt
declare -a part2para=('nottaken' 'taken' 'bimod' '2lev');
for para in "${part2para[@]}"
do
	echo $para >> go.txt
	../sim-wattch-1.02e/sim-outorder -bpred $para go.alpha 50 9 2stone9.in 2> go_result.txt
	#../sim-wattch-1.02e/sim-outorder -bpred $para compress95.alpha <compress95.in 2>go_result.txt
	awk 'NR==211' go_result.txt >> go.txt
	awk 'NR==244' go_result.txt >> go.txt
done
echo "=============================" >> go.txt
echo "Part3" >> go.txt
declare -a part3para=(32 64 128 256);
for para in "${part3para[@]}"
do
	echo "Cache Blcok Size:" $para >> go.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:$para:4:l go.alpha 50 9 2stone9.in 2> go_result.txt
	#../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:$para:4:l compress95.alpha <compress95.in 2>go_result.txt
	awk 'NR==211' go_result.txt >> go.txt
	awk 'NR==274' go_result.txt >> go.txt
	awk 'NR==278' go_result.txt >> go.txt
done
echo "~~~~~~~~~~~~~~~~" >>go.txt
declare -a part3para=('f' 'l' 'r');
for para in "${part3para[@]}"
do
	echo "Cache Replacement Policy:" $para >> go.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:64:4:$para go.alpha 50 9 2stone9.in 2> go_result.txt
	#../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:64:4:$para compress95.alpha <compress95.in 2>go_result.txt
	awk 'NR==211' go_result.txt >> go.txt
	awk 'NR==274' go_result.txt >> go.txt
	awk 'NR==278' go_result.txt >> go.txt
	awk 'NR==279' go_result.txt >> go.txt
done
echo "~~~~~~~~~~~~~~~~" >>go.txt
declare -a part3para=(1 4 8 128);
for para in "${part3para[@]}"
do
	echo "Cache Associativity:" $para >> go.txt
	../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:64:$para:l go.alpha 50 9 2stone9.in 2> go_result.txt
	#../sim-wattch-1.02e/sim-outorder -cache:dl2 ul2:128:32:$para:l compress95.alpha <compress95.in 2>go_result.txt
	awk 'NR==211' go_result.txt >> go.txt
	awk 'NR==264' go_result.txt >> go.txt
	awk 'NR==274' go_result.txt >> go.txt
	awk 'NR==278' go_result.txt >> go.txt
done
exit 0
