#!/bin/bash

#Set last time step as start

. ~/OpenFOAM/OpenFOAM-4.x/etc/bashrc

#reconstructPar -latestTime  > reconstruct.log
./CleanAll.sh
rm -r 0
cp -r zeroprep 0
rm -r postProcessing
cp  Wavemaker.dat constant/Wavemaker.dat
#Reset runtime
endTime=$(tail -n 2 Wavemaker.dat | cut -f 1 -d " " | head -n 1 | tr -d "(")
sed -i "/^endTime/ c\endTime $endTime\;" system/controlDict

#decomposePar -force >preproc.log
#for i in ./processor[0-9]; do cp constant/Wavemaker.dat $i/constant/ ;done
#mpirun -np 1 renumberMesh -parallel -overwrite >>preproc.log
#mpirun -np 4 interFoamUsrc -parallel>log
interFoamUsrc > log
#cp postProcessing/waveprobes/0/alpha.water PalProbes.mat
#sed -i s/"#"/"%"/g PalProbes.mat

#cp postProcessing/interfaceHeight1/0/height.dat OFProbes.mat
#sed -i s/"#"/"%"/g OFProbes.mat
