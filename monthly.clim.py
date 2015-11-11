# Calcualtes monthly climatology

import xray

dset = xray.open_dataset('kerang.tmin.1960-2011.nc')
Tmin = dset[['Tmin']]
monclim = Tmin.groupby('time.month').mean('time') 
monclim[['Tmin']]
monclim.to_netcdf('kerang.tmin.monclim.1960-2011.netCDF4.nc')

