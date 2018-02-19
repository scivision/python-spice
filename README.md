# Python - SPICE interface and plotting

GNUcap / NGspice voltage multiplier sim.

Used for my Ph.D. qualifying exam, and a follow-on to my 
[harmonic radar tag improvements](https://www.scivision.co/harmonic-radar).


NOTE: Consider using 
[PySpice](https://pyspice.fabrice-salvaire.fr)
instead of this approach.

## Prereqs

    apt install gnucap ngspice

## Usage
Simulate no-driver LED problems due to wire voltage drop, using `ledDrop.net` and StringIO to avoid output file mess.

    python ledDrop.py



### Other programs
These programs run from GNU Octave or Matlab.

* `runDub.m` run and plot basic voltage doubler current input and voltage output vs. time
* `runDubTry.m` plot spectrum
* `runDubMult.m` multi-stage voltage multiplier: voltage, current, impedance
* `runMos.m` using MOS simulation
