# Searches for days in which Pezza's heatwave definition matches for each day
# Pezza et al. (2012). Severe heatwaves in Southern Australia

import numpy as np

# Loads text files with maximun and minimum temperature, 
# and monthly percentiles (90th)

TxtFileMel = np.loadtxt('melbourne.heatwaves.pezza.1960-2011.txt')
TxtFileMil = np.loadtxt('mildura.heatwaves.pezza.1960-2011.txt')
TxtFileNill = np.loadtxt('nill.heatwaves.pezza.1960-2011.txt')
TxtFileSale = np.loadtxt('sale.heatwaves.pezza.1960-2011.txt')

# Defines length of files

ShapeRowsMelMil = TxtFileMel.shape
n = (ShapeRowsMelMil[0])

ShapeRowsNill = TxtFileNill.shape
m = (ShapeRowsNill[0])

ShapeRowsSale = TxtFileSale.shape
o = (ShapeRowsSale[0])

ShapeColumns = TxtFileMel.shape
p = (ShapeColumns[1])

# Creates a matrix with values exclusively from 1960-2011

HwsMel = np.zeros((n,p), dtype=int)
HwsMil = np.zeros((n,p), dtype=int)
HwsNill = np.zeros((m,p), dtype=int)
HwsSale = np.zeros((o,p), dtype=int)

for i in range(18262,n):
    for j in range(p):
        HwsMel[i,j]=TxtFileMel[i,j]
        HwsMil[i,j]=TxtFileMil[i,j]

ZeroRowsM = range(0,18262)
HwsMel = np.delete(HwsMel,ZeroRowsM,0)
HwsMil = np.delete(HwsMil,ZeroRowsM,0)

for i in range(18110,m):
    for j in range(p):
        HwsNill[i,j]=TxtFileNill[i,j]

ZeroRowsN = range(0,18110)
HwsNill = np.delete(HwsNill,ZeroRowsN,0)

for i in range(5265,o):
    for j in range(p):
        HwsSale[i,j]=TxtFileSale[i,j]

ZeroRowsS = range(0,5265)
HwsSale = np.delete(HwsSale,ZeroRowsS,0)


# Selects days in which Pezza's heatwave definitition is 
# positive in each station simultaneously

ShapeRows1960_2011 = HwsMel.shape
q = (ShapeRows1960_2011[0])

HwsVic = np.zeros((q,p), dtype=int) 
    
for i in range(q):
    for j in range(p):

        HwsVic[i,0] = HwsMel[i,0]
        HwsVic[i,1] = HwsMel[i,1]
	HwsVic[i,2] = HwsMel[i,2]

        if HwsMel[i,3] and HwsMil[i,3] and HwsNill[i,3] and HwsSale[i,3] == 1:              HwsVic[i,3] = 1

        if HwsMel[i,4] and HwsMil[i,4] and HwsNill[i,4] and HwsSale[i,4] == 1:
	    HwsVic[i,4] = 1

print HwsVic

# Writes result into a textfile

np.savetxt('victorian.heatwaves.pezza.1960-2011.txt', HwsVic, fmt='%s')
 



