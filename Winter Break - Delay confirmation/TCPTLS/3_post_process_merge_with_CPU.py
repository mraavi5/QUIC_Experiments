import csv
import os
import re
import sys
import time


# Given a regular expression, list the files that match it, and ask for user input
def selectFile(regex, subdirs = False):
	files = []
	if subdirs:
		for (dirpath, dirnames, filenames) in os.walk('.'):
			for file in filenames:
				path = os.path.join(dirpath, file)
				if path[:2] == '.\\': path = path[2:]
				if bool(re.match(regex, path)):
					files.append(path)
	else:
		for file in os.listdir(os.curdir):
			if os.path.isfile(file) and bool(re.match(regex, file)):
				files.append(file)
	
	print()
	if len(files) == 0:
		print(f'No files were found that match "{regex}"')
		print()
		return ''

	print('List of files:')
	for i, file in enumerate(files):
		print(f'  File {i + 1}  -  {file}')
	print()

	selection = None
	while selection is None:
		try:
			i = int(input(f'Please select a file (1 to {len(files)}): '))
		except KeyboardInterrupt:
			sys.exit()
		except:
			pass
		if i > 0 and i <= len(files):
			selection = files[i - 1]
	print()
	return selection


# Given a regular expression, list the directories that match it, and ask for user input
def selectDir(regex, subdirs = False):
	dirs = []
	if subdirs:
		for (dirpath, dirnames, filenames) in os.walk('.'):
			if dirpath[:2] == '.\\': dirpath = dirpath[2:]
			if bool(re.match(regex, dirpath)):
				dirs.append(dirpath)
	else:
		for obj in os.listdir(os.curdir):
			if os.path.isdir(obj) and bool(re.match(regex, obj)):
				dirs.append(obj)

	print()
	if len(dirs) == 0:
		print(f'No directories were found that match "{regex}"')
		print()
		return ''

	print('List of directories:')
	for i, directory in enumerate(dirs):
		print(f'  Directory {i + 1}  -  {directory}')
	print()

	selection = None
	while selection is None:
		try:
			i = int(input(f'Please select a directory (1 to {len(dirs)}): '))
		except KeyboardInterrupt:
			sys.exit()
		except:
			pass
		if i > 0 and i <= len(dirs):
			selection = dirs[i - 1]
	print()
	return selection

# List the files with a regular expression
def listFiles(regex, directory = ''):
	path = os.path.join(os.curdir, directory)
	return [os.path.join(path, file) for file in os.listdir(path) if os.path.isfile(os.path.join(path, file)) and bool(re.match(regex, file))]


directory = selectDir('.*Logs.*', True)

csvFiles = listFiles(r'.*_parsed_handshake.csv', directory)

for inputFileName in csvFiles:

	# match = re.match(r'TCPDUMP_([^_]+(?:_aes)?(?:_drop)?)_parsed_handshake.csv', os.path.basename(inputFileName))
	# if match is None:
	# 	print('ERROR:', 'File name\"', inputFileName, '\" does not have a valid algorithm name, please ensure that the algorithm name does not contain an underscore, as this will mess up the regular expression.')
	# 	continue
	# algorithm = match.group(1).upper()
	
	# match = re.match(r'TCPDUMP_([^_]+(?:_aes)?(?:_drop)?)_parsed_handshake.csv', os.path.basename(inputFileName))
	# if match is None:
	# 	print('ERROR:', 'Unable to find CPU file name for file \"', inputFileName, '\"')
	# 	continue

	# cpuFileName = 'LOGGED_CPU_' + match.group(1) + '.csv'
	
	cpuFileName = os.path.join(directory, 'LOGGED_CPU.csv')
	if not os.path.exists(cpuFileName):
		print('ERROR:', 'Unable to find CPU file \"', cpuFileName, '\"')
		continue

	#inputFileName = selectFile(r'.*\_parsed.csv', False)
	#if inputFileName == '':
	#	sys.exit()
	print('\nOPENING', inputFileName)
	print('OPENING', cpuFileName, '\n')

	#directory = 'finalPostProcessed'
	fileName = os.path.join(directory, os.path.basename(inputFileName[:-4] + '_withcpu.csv'))
	outputFile = open(fileName, 'w', newline='')

	readerFile = open(inputFileName, 'r')
	reader = csv.reader(x.replace('\0', '') for x in readerFile)
	readerHeader = next(reader)

	cpuReaderFile = open(cpuFileName, 'r')
	cpuReader = csv.reader(x.replace('\0', '') for x in cpuReaderFile)
	cpuReaderHeader = next(cpuReader)
	cpuData = []
	print('Reading CPU data...')
	for cpuSample in cpuReader:
		timestamp = cpuSample[1]
		cpu = cpuSample[2]
		mem = cpuSample[5]
		disk = cpuSample[9]
		cpuData.append([timestamp, cpu, mem, disk])


	newHeader = readerHeader
	newHeader.append('CPU utilization')
	newHeader.append('Memory bytes')
	newHeader.append('Disk bytes')
	outputFile.write(','.join(newHeader) + ',\n')

	cpuDataIndex = 0

	for handshake in reader:
		startTime = float(handshake[0])
		endTime = float(handshake[1])
		handshakeNum = int(handshake[2])

		if handshakeNum % 100 == 0:
			print(fileName, 'Handshake', handshakeNum)

		newRow = handshake

		cpuSum = 0
		cpuNum = 0
		memStart = 0
		memEnd = 0
		diskStart = 0
		diskEnd = 0

		foundStart = False
		for i in range(cpuDataIndex, len(cpuData)):
			cpuSample = cpuData[i]
			timestamp = float(cpuSample[0])
			if timestamp >= startTime:
				if foundStart == False:
					foundStart = True
					memStart = float(cpuSample[2])
					diskStart = float(cpuSample[3])
					cpuDataIndex = 0 # i - 1 # Next time, start at where the last one started
					cpuSum += float(cpuSample[1])
					cpuNum += 1
					memEnd = float(cpuSample[2])
					diskEnd = float(cpuSample[3])

				if foundStart and timestamp <= endTime:
					cpuSum += float(cpuSample[1])
					cpuNum += 1
					memEnd = float(cpuSample[2])
					diskEnd = float(cpuSample[3])

				elif foundStart and timestamp > endTime: # End of sequence reached
					break
					
		if cpuNum == 0: cpuNum = 1 # Avoid divide by zero
		newRow.append(cpuSum / cpuNum)
		#print(cpuSum, cpuNum, cpuSum / cpuNum)
		newRow.append(max(0, memEnd - memStart))
		newRow.append(max(0, diskEnd - diskStart))

		outputFile.write(','.join(map(str,newRow)) + ',\n')




