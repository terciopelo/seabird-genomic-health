#Subset ROH lengths into a new document
awk '{print$2}' roh_sorted_indiv.txt > roh_lengths.txt

#Isolate segments that are 100-300 KB in size
cat roh_lengths.txt | awk '{if($1>100)print$1}' | awk '{if($1<=300)print$1}' | sort > 100-300.txt

#Determine the number of segments that are 100-300 KB in size
wc -l 100-300.txt | awk '{print $1/35}'

#Calculate the total length of all segments 100-300 KB in size (N=35)
awk '{s+=$1} END {print s/35}' 100-300.txt

#Isolate segments that are 300-500 KB in size
cat roh_lengths.txt | awk '{if($1>300)print$1}' | awk '{if($1<=500)print$1}' | sort > 300-500.txt

#Determine the number of segments that are 300-500 KB in size
wc -l 300-500.txt | awk '{print $1/35}'

#Calculate the total length of all segments 300-500 KB in size (N=35)
awk '{s+=$1} END {print s/35}' 300-500.txt

#Isolate segments that are 500-1000 KB in size
cat roh_lengths.txt | awk '{if($1>500)print$1}' | awk '{if($1<=1000)print$1}' | sort > 500-1000.txt

#Calculate the total length of all segments 500-1000 KB in size (N=35)
awk '{s+=$1} END {print s/35}' 500-1000.txt

#Determine the number of segments that are 500-1000 KB in size
wc -l 500-1000.txt | awk '{print $1/35}'

#Isolate segments that are 500-1000 KB in size
cat roh_lengths.txt | awk '{if($1>1000)print$1}' | sort > 1000+.txt

#Determine the number of segments that are 1000+ KB in size
wc -l 1000+.txt | awk '{print $1/35}'

#Calculate the total length of all segments 1000+ KB in size (N=35)
awk '{s+=$1} END {print s/35}' 1000+.txt
