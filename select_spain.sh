#!/bin/ksh

# Latitud 35, 43
# Longitud 0, 3 E - 0 , 9 W

if [ -e "results.txt" ]; then
	rm -rf results.txt
	touch results.txt
else
	touch results.txt
fi
filepath=
file=
nordwest=
nordeast=
for filepath in */*; do
	file=$(basename "$filepath") 
	nordwest=$(echo $file | grep -v "S" | grep -v "E")
	if [[ ! -z $nordwest ]]; then
		typeset -i lat=$(echo $nordwest | sed -e "s/.*N//g" -e "s/W.*//g")
		typeset -i long=$(echo $nordwest | sed -e "s/.*W//g" -e "s/\..*//g")
		if [[ $lat -ge 35 && $lat -le 43 && $long -ge 0 && $long -le 9 ]]; then
			if [[ "$filepath" == SRTM3* ]] then
				mv $filepath "/home/riccardo/.wine/drive_c/Radio_Mobile/Geodata/srtm3/"
			else
				mv $filepath "/home/riccardo/.wine/drive_c/Radio_Mobile/Geodata/Landcover/"
			fi
		fi
	fi
	nordeast=$(echo $file | grep -v "S" | grep -v "W")
	if [[ ! -z $nordeast ]]; then
		typeset -i lat=$(echo $nordeast | sed -e "s/.*N//g" -e "s/E.*//g")
		typeset -i long=$(echo $nordeast | sed -e "s/.*E//g" -e "s/\..*//g")
		if [[ $lat -ge 35 && $lat -le 43 && $long -ge 0 && $long -le 3 ]]; then
			if [[ "$filepath" == SRTM3* ]] then
				mv $filepath "/home/riccardo/.wine/drive_c/Radio_Mobile/Geodata/srtm3/"
			else
				mv $filepath "/home/riccardo/.wine/drive_c/Radio_Mobile/Geodata/Landcover/"
			fi
		fi
	fi
 done

#| sed -e "s/.*\/N//g" -e "s/E.*//g" 

#if [[ $lat -ge 35 && $lat -le 43 && $long -ge 3 && $long -le 9 ]]; then

