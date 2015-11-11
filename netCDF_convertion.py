# Script to transform  netCDF4 files to netCDF3

import cdms2
import pupynere as py
 
#if hasattr(cdms2, 'setNetcdfDeflateFlag'):
cdms2.setNetcdfShuffleFlag(0)
cdms2.setNetcdfDeflateFlag(0)
cdms2.setNetcdfDeflateLevelFlag(0)

xml_file = 'uwnd.1000.2011-2012.18.xml'


fin = cdms2.open(xml_file)
var = fin('uwnd', level=(1000), squeeze=1)
#var = fin('hgt', level=(500), latitude=(10,15), longitude=(10,15), squeeze=1)
#n = var.shape[0]
#var = var.reshape((n, 91, 180))
fin.close()

#var = var.getValue(0)

print var.shape
print var.max()
print var.min()

#fout = cdms2.openDataset('air.1911-2012.nc', mode='w')
#fout = py.netcdf_file('air.1911-2011.nc','w')
fout = cdms2.open('uwnd.1000.2011-2012.18.nc', 'w')

#fout.createDimension('lon', 180)
#fout.createDimension('lat', 91)
#fout.createDimension('time', n)

#lon = fout.createVariable('lon','f4',('lon',))
#lat = fout.createVariable('lat','f4',('lat',))
#time = fout.createVariable('time','f4',('time',))
#air = fout.createVariable('air','f4',('time','lat','lon',))

#lon[:] = range(180)
#lat[:] = range(91)
#time[:] = range(n)
#air[:,:,:] = var

#lat.units = 'degrees_north'
#lon.units = 'degrees_east'
#time.units = 'days since 1911-01-01'
#air.units = 'degK'


#var = cdms2.MV2.array(outdata[index])
#import numpy
#var = var.astype(numpy.float32)
fout.write(var, id='uwnd')

