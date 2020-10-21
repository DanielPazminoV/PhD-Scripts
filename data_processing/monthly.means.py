# Calcualtes monthly means form daily values

import xray

dset = xray.open_dataset('kerang.tmin.1960-2011.nc')
monavg = dset.resample('1MS', dim='time', how='mean')
monavg.to_netcdf('kerang.tmin.monavg.1960-2011.netCDF4.nc')
