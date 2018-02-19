#!/usr/bin/env python
import pandas
import io
import subprocess
from matplotlib.pyplot import figure,show
from scipy.interpolate import interp1d
# %% brightness from XHP50 datasheet
B = [.2, .4, .6, .8, 1, 1.2]
I = [.1, .25,.4, .55, .7, .85]
f = interp1d(I,B,'cubic')
# %% run sim
ret = subprocess.check_output(['gnucap','-b','ledDrop.net'], universal_newlines=True)
dat = pandas.read_csv(io.StringIO(ret),header=10,delimiter='\s+').squeeze()

ind = ['i(D1)','i(D6)','i(D12)']
names = ['D1','D6','D12']
Iled = dat[ind]
bi = f(Iled)

ax = figure(1).gca()
ax.stem(dat.index.values,dat.values)

ax = figure(2).gca()
ax.set_title('LED brightness')
ax.set_ylabel('brightness (normalized)')
ax.stem(names,bi)

show()