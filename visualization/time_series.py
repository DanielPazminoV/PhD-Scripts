# Plots simultaneously bar accnd time series values

import numpy as np
import matplotlib.pyplot as plt

# Extracts values for each variable (in columns)

HW_SOI = np.loadtxt("HW_1961_2011.txt", dtype=int)

ShapeTxtFile = np.shape(HW_SOI)
n = ShapeTxtFile[0]

Seasons = np.zeros((n), dtype=int)
HW = np.zeros((n), dtype=int)
SOI = np.zeros((n), dtype=int)

for i in range(n):

    Seasons[i] = HW_SOI[i,0]
    HW[i] = HW_SOI[i,1]
    SOI[i] = HW_SOI[i,2]

# Generates polynominal fits 

CoefFitHW = np.polyfit(range(n),HW,6)
CoefFitSOI = np.polyfit(range(n),SOI,6)

PolyHW = np.poly1d(CoefFitHW)
PolySOI = np.poly1d(CoefFitSOI)

ypHW = np.polyval(PolyHW,range(n))
ypSOI = np.polyval(PolySOI,range(n))
 
# Plots figure

fig, ax1 = plt.subplots()
fig.suptitle('Heatwave Events in Victoria 1961-2011' ,fontsize=20, fontweight='bold')
ax2 = ax1.twinx()
bar = ax1.bar(Seasons, HW, color='r',label='Heatwave events (HW)')
l1 = ax1.plot(Seasons,ypHW,'k', lw=3,label='HW 6th-degree polyfit (red bars)')
l2 = ax2.plot(Seasons, SOI, 'b-', lw=3, label='Southern Oscillation Index (SOI)')
l3 = ax2.plot(Seasons,ypSOI,'k--', lw=3, label='SOI 6th-degree polyfit (blue line)')
ax1.set_xlabel('Seasons',fontsize=20, fontweight='bold')
ax1.set_xlim([1961, 2011])
plt.xticks(np.arange(1965,2015,5))
ax1.tick_params(labelsize=15)
ax1.set_ylim([0, 3.5])
ax1.set_ylabel('Heatwave Events (HW)',fontsize=16, fontweight='bold')
ax2.set_ylabel('Southern Oscillation Index (SOI)',fontsize=16, fontweight='bold')
ax2.set_ylim([-40, 30])
ax2.tick_params(labelsize=15)
lns = l1 + l3
labels = [l.get_label() for l in lns]
ax2.legend(lns, labels, loc='upper left')
plt.savefig('HW.eps', format='eps', dpi=600)



