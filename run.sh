export time=$(date +"%d:%m:%Y_%T")
export i=0
while read line
do
	export name=($(basename $3 .csv)'_'$i'_'$2'_'$time)  
	hexdump -e '2/8 "%16x " "\n"' -n $((16 * $2)) /dev/random > rng_files/$name.txt
	./$1 $line rng_files/$name.txt > results/$name.txt
	python first_try.py results/$name.txt pictures/$name.png

	export i=$(($i+1))
done < $3
