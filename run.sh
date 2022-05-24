parent_dir=$(dirname $0)
rng_files_dir=$parent_dir/rng_files
results_dir=$parent_dir/results
pictures_dir=$parent_dir/pictures

mkdir -p $rng_files_dir $results_dir $pictures_dir

imitation_exe=$1
draw_python=$2
sigma=$3
number_of_randoms=$4
test_file=$5

time=$(date +"%d:%m:%Y_%H:%M:%S")
i=0
while read line
do
    if [ -z "${line}" ]; then
        exit 0
    fi;
	temp_name=$(basename $test_file .csv)'_'$i'_'$time
	dd if=/dev/random of=$rng_files_dir/$temp_name.raw \
        bs=14 count=$number_of_randoms status='none'
	err_output=$($imitation_exe $rng_files_dir/$temp_name.raw $sigma $line 2>&1 > $results_dir/$temp_name.txt)
	flow_count=$(echo -n $err_output | tr -d \n) 
	true_name=$(basename $test_file .csv)'_'$i'_'$flow_count'_'$time
	mv $results_dir/$temp_name.txt $results_dir/$true_name.txt
	python3 $draw_python \
        $results_dir/$true_name.txt $pictures_dir/$true_name.png
	export i=$(($i+1))
	echo $true_name
done < $test_file
