# Calcualtes percentiles

import xray
pctl90 = 33.2 # calculted with excel
pctl90.to_netcdf('kerang.tmax.pctl90.1910-2014.netCDF4.nc')
 
#import numpy as np
#import cdms2
#import numpy.ma as ma

# Creates a netCDF3 file

#cdms2.setNetcdfShuffleFlag(0)
#cdms2.setNetcdfDeflateFlag(0)
#cdms2.setNetcdfDeflateLevelFlag(0)

# Calcualtes percentiles using masked array

#InFile = cdms2.open('kerang.tmax.1910-2014.nc')
#Tmax = InFile['Tmax'] 
#Tmax = np.ma.asarray(Tmax)
#pctl90 = np.nanpercentile(Tmax.filled(np.nan), (10, 90))
#OutFile = cdms2.open('kerang.tmax.pctl90.1910-2014.nc', 'w')
#Outpctl90 = cdms2.createVariable(pctl90)
#OutFile.write(Outpctl90)

#OutFile.close()
