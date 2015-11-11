# Calcualtes heatwaves according to Pezza's definition
# Pezza et al. (2012). Severe heatwaves in Southern Australia

import numpy as np

# Loads text files with maximun and minimum temperature, 
# and monthly percentiles (90th) 

TxtFileTmax = np.loadtxt('kerang.acorn.sat.maxT.080023.daily.txt')
TxtFileTmin = np.loadtxt('kerang.acorn.sat.minT.080023.daily.txt')
TxtFilePctl90 = np.loadtxt('kerang.pct90.1960-2011.txt')

# Defines length of files

ShapeTmaxTmin = TxtFileTmax.shape
n = (ShapeTmaxTmin[0])

ShapePctl90 = TxtFilePctl90.shape
m = (ShapePctl90[0])

# Creates arrays to fill-in variables data

Year = np.zeros((n), dtype=int)
Month = np.zeros((n), dtype=int)
Day = np.zeros((n), dtype=int)
Tmax = np.zeros((n), dtype=float)
Tmin = np.zeros((n), dtype=float)
MonthPctl90 = np.zeros((m), dtype=int)
TmaxPctl90 = np.zeros((m), dtype=float)
TminPctl90 = np.zeros((m), dtype=float)
Heatwaves = np.zeros((n,5), dtype=int)

# Fills-in data in arrays

for i in xrange(n):

    Year[i] = TxtFileTmax[i,0]
    Month[i] = TxtFileTmax[i,1]
    Day[i] = TxtFileTmax[i,2]
    Tmax[i] = TxtFileTmax[i,3]
    Tmin[i] = TxtFileTmin[i,3]

for i in xrange(m):

    MonthPctl90[i] = TxtFilePctl90[i,0]
    TmaxPctl90[i] = TxtFilePctl90[i,1]
    TminPctl90[i] = TxtFilePctl90[i,2]


for i in xrange(n):
    for j in xrange(m):
        
        Heatwaves[i,0] = Year[i]  
        Heatwaves[i,1] = Month[i]
        Heatwaves[i,2] = Day[i]
       
        if Month[i] == MonthPctl90[j] and Tmax[i] >= TmaxPctl90[j]:
        
            Heatwaves[i,3] = 1                  

        if Month[i] == MonthPctl90[j] and Tmin[i] >= TminPctl90[j]:

            Heatwaves[i,4] = 1

print Heatwaves

# Writes result into a textfile

np.savetxt('kerang.heatwaves.pezza.1960-2011.txt', Heatwaves, fmt='%s')


