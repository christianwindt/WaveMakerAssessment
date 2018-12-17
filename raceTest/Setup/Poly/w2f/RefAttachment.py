import numpy as np
import matplotlib.pyplot as plt
import os


#----------------------------------------------
#Get Parameters



#bashCommand = 'mkdir ./Results'
#os.system(bashCommand)


#----------------------------------------------------
	#Get Time.py

	# path to the file to read from
my_file = './waveFoam.log'
#overInterDyMFoam'
	# what to look in each line
look_for = 'Time ='
	# variable to store time value
time = []

	# fill time 
with open(my_file) as file_to_read:
	for line in file_to_read:
	  if look_for in line and line.startswith('Time'):
		a=line.split('Time = ') 
		time.append(a[1].strip())

outFile = open('./Time.txt','w')
outFile.writelines(["%s\n" % item  for item in time])
	#-------------------------------------------
	

	#-------------------------------------------
	#Get Position

	# what to look in each line
look_for='Courant Number'
	# variable to store position value
Co= []

	# fill position
with open(my_file) as file_to_read:
	for line in file_to_read:
	 if look_for in line and line.startswith('Courant Number'):
		a=line.split()		
		Co.append(a[3].replace('',""))

CoMax= []

	# fill position
with open(my_file) as file_to_read:
	for line in file_to_read:
	 if look_for in line and line.startswith('Courant Number'):
		a=line.split()		
		CoMax.append(a[5].replace('',""))

look_for='Interface Courant Number'
	# variable to store position value
iCo= []

	# fill position
with open(my_file) as file_to_read:
	for line in file_to_read:
	 if look_for in line and line.startswith('Interface Courant Number'):
		a=line.split()		
		iCo.append(a[4].replace('',""))
		
iCoMax = []

	# fill position
with open(my_file) as file_to_read:
	for line in file_to_read:
	 if look_for in line and line.startswith('Interface Courant Number'):
		a=line.split()		
		iCoMax.append(a[6].replace('',""))
#----------------------------------------------------
	#Get Position

print len(Co[1:])
print len(CoMax[1:])
print len(iCo)
print len(iCoMax)
print len(time)	

plt.plot(time,Co[1:],time,CoMax[1:],time,iCo,time,iCoMax)
plt.legend(['Co','CoMax','iCo','iCoMax'])
plt.xlabel('time')
plt.ylabel('Co')

plt.show();
