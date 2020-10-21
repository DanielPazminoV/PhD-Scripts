# Calculates heatwaves using Nairn's methodology
# Nairn et al. (2009). Defining and predicting Excessive Heat events, a National System


import numpy as np

# Defines runing mean functions:

def moving_average_3(x, N=3):
    return np.convolve(x, np.ones((N,))/N)[(N-1):]

def moving_average_30(x, N=30):
    return np.convolve(x, np.ones((N,))/N)[(N-1):]


# Loads text files with maximun and minimum temperature 

TxtFileTmax = np.loadtxt('melbourne.acorn.sat.maxT.086071.daily.txt')
TxtFileTmin = np.loadtxt('melbourne.acorn.sat.minT.086071.daily.txt')

# Defines length of files

ShapeTmaxTmin = TxtFileTmax.shape
n = (ShapeTmaxTmin[0])

#Creates arrays to fill-in variables data

Year = np.zeros((n), dtype=int)
Month = np.zeros((n), dtype=int)
Day = np.zeros((n), dtype=int)
Tmax = np.zeros((n), dtype=float)
Tmin = np.zeros((n), dtype=float)
ADT = np.zeros((n), dtype=float)

# Fills-in data in arrays

for i in xrange(n):

    Year[i] = TxtFileTmax[i,0]
    Month[i] = TxtFileTmax[i,1]
    Day[i] = TxtFileTmax[i,2]
    Tmax[i] = TxtFileTmax[i,3]
    Tmin[i] = TxtFileTmin[i,3]

# Calcualtes average daily temperature (ADT)
# ADT is equal to the average of daily maximun (Tmax) 
# and minimum temperature (Tmin)

for i in xrange(n):
    ADT[i] = (Tmax[i]+Tmin[i])/2
 
# Calculates Excess Heat 
# Climatological Excess Heat Index (EHIsig)

EHIsig = np.zeros((n,4), dtype=float)
movavgadt_3 = moving_average_3(ADT)

for i in xrange(n):
    EHIsig[i,0]=Year[i]
    EHIsig[i,1]=Month[i]
    EHIsig[i,2]=Day[i]

# 95th percentile calcualte in excel, across all ADT days for the period 1960-2011 according to Nairn's methodology

Pctl95 = 22.2

for i in xrange(n):
    EHIsig[i,3] =  movavgadt_3[i] - Pctl95  

#print EHIsig

# Calcualtes Heat Stress 
# Excess Heat Index (EHIaccl)

movavgadt_30 = moving_average_30(ADT)

EHIaccl = np.zeros((n,4), dtype=float) 

for i in xrange(n):
    EHIaccl[i,0]=Year[i]
    EHIaccl[i,1]=Month[i]
    EHIaccl[i,2]=Day[i]

for i in xrange(0,n-30):

    EHIaccl[i,3]=movavgadt_3[i+30]-movavgadt_30[i]

#print EHIaccl

# Calculates Excess Heat Factor (EHF)
# First and last 30 values of caluclations are not valid (running mean)

EHF = np.zeros((n,4), dtype=float)

for i in xrange(n):
    EHF[i,0]=Year[i]
    EHF[i,1]=Month[i]
    EHF[i,2]=Day[i]
    EHF[i,3]=abs(EHIaccl[i,3])*EHIsig[i,3]

# Selects values only form 1960-2011 
s = range(n-1096,n)
t = range(18262)

EHF = np.delete(EHF, (s), axis=0)
EHF = np.delete(EHF, (t), axis=0)

# Writes result into a textfile

np.savetxt('melbourne.heatwaves.nairn.1960-2011.txt', EHF, fmt='%s')

print EHF
