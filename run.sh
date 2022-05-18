parent_dir=$(dirname $1)
rng_files_dir=$parent_dir/rng_files
results_dir=$parent_dir/results
pictures_dir=$parent_dir/pictures

mkdir -p $rng_files_dir $results_dir $pictures_dir

time=$(date +"%d:%m:%Y_%H:%M:%S")
i=0
while read line
do
	temp_name=$(basename $4 .csv)'_'$i'_'$time
	dd if=/dev/random of=$rng_files_dir/$temp_name.raw bs=14 count=$3 status='none'
	err_output=$($1 $rng_files_dir/$temp_name.raw $line 2>&1 > $results_dir/$temp_name.txt)
	flow_count=$(echo -n $err_output | tr -d \n) 
	true_name=$(basename $4 .csv)'_'$i'_'$flow_count'_'$time
	mv $results_dir/$temp_name.txt $results_dir/$true_name.txt
	python3 $2 $results_dir/$true_name.txt $pictures_dir/$true_name.png
	export i=$(($i+1))
    echo $true_name
done < $4
