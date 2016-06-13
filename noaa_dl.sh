#!/bin/bash
###############################################################################
#                                                                             #
# NOAA Downloader                                                             #
# This script downloads textual forecasts from the NOAA website, as indicated #
# in the file "listing".  The format for the file is FRIENDLYNAME\t NOAANAME  #
#                                                                             #
# ie:                                                                         #
# BUFFALO	nyz010.txt                                                        #
#                                                                             #
# This downloads the nyz010.txt file (If newer than currently downloaded),    #
# moves it to the "data" directory using the friendly name provided.          #
#                                                                             #
# This script is licensed under the GPL vr3 or later.                         #
#                                                                             #
###############################################################################

server="ftp://tgftp.nws.noaa.gov"
path="data/forecasts/zone/ny"

listing=listing

echo "Downloading NOAA forecasts..."

while read -r line
do
		  name=`echo $line | awk '{print $1}'`
		  file=`echo $line | awk '{print $2}'`
		  echo "Downloading $name..."
		  wget -N -o /dev/null $server/$path/$file
		  cp $file ./data/$name.txt > /dev/null 2>&1

done < "$listing"
