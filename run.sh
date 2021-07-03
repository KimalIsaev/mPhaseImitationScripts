time=$(date +"%d:%m:%Y_%H:%M:%S")
i=0
while read line
do
	temp_name=$(basename $3 .csv)'_'$i'_'$time
	dd if=/dev/random of=rng_files/$temp_name.raw bs=14 count=$2
	err_output=$($1 rng_files/$temp_name.raw $line 2>&1 > results/$temp_name.txt)
	flow_count=$(echo -n $err_output | tr -d \n) 
	true_name=$(basename $3 .csv)'_'$i'_'$flow_count'_'$time
	mv results/$temp_name.txt results/$true_name.txt
	python3 draw.py results/$true_name.txt pictures/$true_name.png
	export i=$(($i+1))
done < $3
