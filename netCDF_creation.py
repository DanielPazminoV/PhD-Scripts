# Script to transform  netCDF4 files to netCDF3
import pdb
import cdms2
import cdtime
import MV2
import numpy as np
#import pdb (python debugger)


# Creates a netCDF3 file

cdms2.setNetcdfShuffleFlag(0)
cdms2.setNetcdfDeflateFlag(0)
cdms2.setNetcdfDeflateLevelFlag(0)

# Reads-in text file skipping header and last  lines

# Loads text file and defines length of file

Txtfile = np.loadtxt('kerang.acorn.sat.minT.080023.daily.txt')
#print Txtfile

ShapeTxt = Txtfile.shape
n = (ShapeTxt[0])
#print n

# Creates arrays to fill-in variables data

Year = np.zeros((n), dtype=int)
Month = np.zeros((n), dtype=int)
Day = np.zeros((n), dtype=int)
Tmin = np.zeros((n), dtype=float)

# Fills-in data in arrays

for i in xrange(n):

    Year[i] = Txtfile[i,0]
    Month[i] = Txtfile[i,1]
    Day[i] = Txtfile[i,2]
    Tmin[i] = Txtfile[i,3]

# Creates time axis

TimeStart = "days since 1910-01-01 00:00:00"

TimeValues = []

for i in xrange(n):
    ct = cdtime.comptime(Year[i], Month[i], Day[i])
    rt = ct.torel(TimeStart).value
    TimeValues.append(rt)

time = cdms2.createAxis(TimeValues)
time.id = 'time'
time.standard_name = 'time'
time.units = TimeStart
time.calendar = 'standard'
time.axis = 'T'

#print time

# Creates a netCDF file with values attached to time axis

OutVar = cdms2.open('kerang.tmin.fill.value.nc', 'w')

OutTmin = cdms2.createVariable(Tmin.squeeze(), id="Tmin", axes=(time,), fill_value='NaN')
OutVar.write(OutTmin)

OutVar.close()
