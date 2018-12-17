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
my_file = './olaFlow.log'
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

#outFile = open('./Time.txt','w')
#outFile.writelines(["%s\n" % item  for item in time])
	#-------------------------------------------
	

	#-------------------------------------------
	#Get Position

	# what to look in each line
look_for='Courant Number mean:'
	# variable to store position value
CoMax= []
CoMean= []
	# fill position
with open(my_file) as file_to_read:
	for line in file_to_read:
	 if look_for in line and line.startswith('Courant'):
		a=line.split()		
		CoMax.append(a[5].replace('',""))
		CoMean.append(a[3].replace('',""))

look_for='Interface Courant Number mean:'
	# variable to store position value
iCoMax= []
iCoMean= []
	# fill position
with open(my_file) as file_to_read:
	for line in file_to_read:
	 if look_for in line :
		a=line.split()		
		iCoMax.append(a[6].replace('',""))
		iCoMean.append(a[4].replace('',""))

print len(time)
print len(CoMax[1:])
print len(CoMean[1:])
print len(iCoMax)
print len(iCoMean)
	

#plt.plot(time,z,'r',label='Overset')
plt.plot(time,CoMax[1:],time,CoMean[1:],time,iCoMax,time,iCoMean)
plt.legend(['CoMax','CoMean','iCoMax','iCoMean'])
plt.xlabel('time')
plt.ylabel('Co')

plt.show();
