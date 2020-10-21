# Searches for days in which Nairn's heatwave definition matches for each day
# Nairn et al. (2009). Definning and predicting Excessive Heat events, a National System

import numpy as np

# Loads text files with Excess Heat Factor (EHF) Values

TxtFileMel = np.loadtxt('melbourne.heatwaves.nairn.1960-2011.txt')
TxtFileMil = np.loadtxt('mildura.heatwaves.nairn.1960-2011.txt')
TxtFileNill = np.loadtxt('nill.heatwaves.nairn.1960-2011.txt')
TxtFileSale = np.loadtxt('sale.heatwaves.nairn.1960-2011.txt')

# Defines length of files

ShapeRows = TxtFileMel.shape
n = (ShapeRows[0])

ShapeColumns = TxtFileMel.shape
p = (ShapeColumns[1])

# Selects days in which Nairn's heatwave definitition is 
# positive in each station simultaneously

HwsVic = np.zeros((n,p), dtype=int)

for i in range(n):        
    HwsVic[i,0] = TxtFileMel[i,0]
    HwsVic[i,1] = TxtFileMel[i,1]
    HwsVic[i,2] = TxtFileMel[i,2]

    if TxtFileMel[i,3] and TxtFileMil[i,3] and TxtFileNill[i,3] and TxtFileSale[i,3] > 0:              
        HwsVic[i,3] = 1

# Writes result into a textfile

np.savetxt('victorian.heatwaves.nairn.1960-2011_all.txt', HwsVic, fmt='%s')

# Creates a matrix of Positive EHF values with dates

PosEHFMel = np.zeros((n,p), dtype=float)
PosEHFMil = np.zeros((n,p), dtype=float)
PosEHFNill = np.zeros((n,p), dtype=float)
PosEHFSale = np.zeros((n,p), dtype=float)

for i in range(n):

    PosEHFMel[i,0] = TxtFileMel[i,0]
    PosEHFMil[i,0] = TxtFileMil[i,0]
    PosEHFNill[i,0] = TxtFileNill[i,0]
    PosEHFSale[i,0] = TxtFileSale[i,0]        
    PosEHFMel[i,1] = TxtFileMel[i,1]
    PosEHFMil[i,1] = TxtFileMil[i,1]
    PosEHFNill[i,1] = TxtFileNill[i,1]
    PosEHFSale[i,1] = TxtFileSale[i,1]
    PosEHFMel[i,2] = TxtFileMel[i,2]
    PosEHFMil[i,2] = TxtFileMil[i,2]
    PosEHFNill[i,2] = TxtFileNill[i,2]
    PosEHFSale[i,2] = TxtFileSale[i,2]

    if TxtFileMel[i,3] > 0:
        PosEHFMel[i,3] = TxtFileMel[i,3]
    if TxtFileMil[i,3] > 0:
        PosEHFMil[i,3] = TxtFileMil[i,3]
    if TxtFileNill[i,3] > 0:
        PosEHFNill[i,3] = TxtFileNill[i,3]
    if TxtFileSale[i,3] > 0:
        PosEHFSale[i,3] = TxtFileSale[i,3]

    if TxtFileMel[i,3] <= 0:    
        PosEHFMel[i,3] = 0
    if TxtFileMil[i,3] <= 0:       
        PosEHFMil[i,3] = 0
    if TxtFileNill[i,3] <= 0:
        PosEHFNill[i,3] = 0
    if TxtFileSale[i,3] <= 0:
        PosEHFSale[i,3] = 0
 
np.savetxt('PosEHFMel.heatwaves.nairn.1960-2011_all.txt', PosEHFMel, fmt='%s')
np.savetxt('PosEHFMil.heatwaves.nairn.1960-2011_all.txt', PosEHFMil, fmt='%s')
np.savetxt('PosEHFNill.heatwaves.nairn.1960-2011_all.txt', PosEHFNill, fmt='%s')
np.savetxt('PosEHFSale.heatwaves.nairn.1960-2011_all.txt', PosEHFSale, fmt='%s') 
# Create lists with positive EHF Values (no dates)

PosEHFMelVal = []
PosEHFMilVal = []
PosEHFNillVal = []
PosEHFSaleVal = []

for i in xrange(n):

    if PosEHFMel[i,3] > 0:
        PosEHFMelVal.append(PosEHFMel[i,3])
    if PosEHFMil[i,3] > 0:
        PosEHFMilVal.append(PosEHFMil[i,3])
    if PosEHFNill[i,3] > 0:
        PosEHFNillVal.append(PosEHFNill[i,3])
    if PosEHFSale[i,3] > 0:
        PosEHFSaleVal.append(PosEHFSale[i,3])

PosEHFMelVal = np.asarray(PosEHFMelVal)
PosEHFMilVal = np.asarray(PosEHFMilVal)
PosEHFNillVal = np.asarray(PosEHFNillVal)
PosEHFSaleVal = np.asarray(PosEHFSaleVal)


# Calculates 55th percentile of positive EHF for each station

PctlMel55 = np.zeros((1), dtype=float)  
PctlMil55 = np.zeros((1), dtype=float)
PctlNill55 = np.zeros((1), dtype=float)
PctlSale55 = np.zeros((1), dtype=float)

PctlMel55 = np.percentile(PosEHFMelVal, 55)
PctlMil55 = np.percentile(PosEHFMelVal, 55)
PctlNill55 = np.percentile(PosEHFMelVal, 55)
PctlSale55 = np.percentile(PosEHFMelVal, 55)

HwsVic55 = np.zeros((n,p), dtype=int)
PosEHFMel55 = np.zeros((n,p), dtype=int)
PosEHFMil55 = np.zeros((n,p), dtype=int)
PosEHFNill55 = np.zeros((n,p), dtype=int)
PosEHFSale55 = np.zeros((n,p), dtype=int)


for i in range(n):

    PosEHFMel55[i,0] = TxtFileMel[i,0]
    PosEHFMil55[i,0] = TxtFileMil[i,0]
    PosEHFNill55[i,0] = TxtFileNill[i,0]
    PosEHFSale55[i,0] = TxtFileSale[i,0]
    PosEHFMel55[i,1] = TxtFileMel[i,1]
    PosEHFMil55[i,1] = TxtFileMil[i,1]
    PosEHFNill55[i,1] = TxtFileNill[i,1]
    PosEHFSale55[i,1] = TxtFileSale[i,1]
    PosEHFMel55[i,2] = TxtFileMel[i,2]
    PosEHFMil55[i,2] = TxtFileMil[i,2]
    PosEHFNill55[i,2] = TxtFileNill[i,2]
    PosEHFSale55[i,2] = TxtFileSale[i,2]

    if PosEHFMel[i,3] > PctlMel55:
        PosEHFMel55[i,3] = 1
    if PosEHFMil[i,3] > PctlMil55:
        PosEHFMil55[i,3] = 1
    if PosEHFNill[i,3] > PctlNill55:
        PosEHFNill55[i,3] = 1
    if PosEHFSale[i,3] > PctlSale55:
        PosEHFSale55[i,3] = 1

for i in range(n):
    HwsVic55[i,0] = TxtFileMel[i,0]
    HwsVic55[i,1] = TxtFileMel[i,1]
    HwsVic55[i,2] = TxtFileMel[i,2]

    if PosEHFMel55[i,3] + PosEHFMil55[i,3] + PosEHFNill55[i,3] + PosEHFSale55[i,3] == 4:         
        HwsVic55[i,3] = 1

print HwsVic55

np.savetxt('victorian.heatwaves.nairn.1960-2011_55th.txt', HwsVic55, fmt='%s') 
