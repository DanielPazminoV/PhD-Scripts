#!/bin/csh 

setenv PATH  .:/home/keay/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games

# Path for NCL
# At this stage the system version should be compatiable with the OpenDAP version KK 23/10/2013
setenv NCARG_ROOT /usr/local

# OpenDAP version of ncl
alias ncl612 /work/keay/ncl612.dir/bin/ncl


set y = 1871
#set y = 2010

set hr = "06"


set var = air

# e.g. http://www.esrl.noaa.gov/psd/thredds/dodsC/Datasets/20thC_ReanV2/monolevel/prmsl.1871.nc
# Set url to the path excluding the filename
set url = "http://www.esrl.noaa.gov/psd/thredds/dodsC/Datasets/20thC_ReanV2/pressure/"

if ($hr == "00") then
  set tstep = 0
else if ($hr == "06") then
  set tstep = 1
else if ($hr == "12") then
  set tstep = 2
else if ($hr == "18") then
  set tstep = 3
endif

echo "y:" $y
echo "var:" $var
echo "hr:" $hr
echo "tstep:" $tstep
echo "url:" $url

# The NCL script will output $var.$y.$hr.nc
# Note: Fof text variables use: var=\"$var\"
ncl612  get_opendap.ncl y=$y hr=\"$hr\" tstep=$tstep var=\"$var\" url=\"$url\"

# Could convert to hPa in this way - may need -b 32 or -b 64 option; junk.nc is unpacked  - in this case, about 2x larger.
#cdo -b 32 mulc,0.01 prmsl.1871.nc junk.nc
exit
