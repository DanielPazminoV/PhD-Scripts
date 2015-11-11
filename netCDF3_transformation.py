#Script to transform  netCDF4 files to netCDF3
import pdb
import cdms2
import cdtime
import MV2
import numpy as np

# Creates a netCDF3 file

cdms2.setNetcdfShuffleFlag(0)
cdms2.setNetcdfDeflateFlag(0)
cdms2.setNetcdfDeflateLevelFlag(0)

# Opens netCDF4 file

InFile = cdms2.open('kerang.tmin.monavg.1960-2011.netCDF4.nc')
Tmin = InFile['Tmin']
OutFile = cdms2.open('kerang.tmin.monavg.1960-2011.nc', 'w')
OutTmin = cdms2.createVariable(Tmin)
OutFile.write(OutTmin)

OutFile.close()
