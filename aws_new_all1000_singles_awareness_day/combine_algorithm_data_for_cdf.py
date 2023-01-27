import csv
import numpy as np
import os
import re
import sys

# Return the +- value after a set of data
def percentile(data, p=95):
	a = 1.0 * np.array(data)
	return np.percentile(a, p)

def removePercentile(dataStr, p = 99):
	data = []
	for numStr in dataStr:
		try:
			data.append(float(numStr))
		except:
			pass
	ps = [percentile(data, p), percentile(data, 100 - p)]
	upper = max(ps)
	lower = min(ps)
	print(lower, upper)
	newData = []
	for num in data:
		if num > lower and num < upper:
			newData.append(num)
	return newData

def listFiles(directory = os.curdir, regex = r'.*'):
	files = []
	for file in os.listdir(directory):
		if os.path.isfile(os.path.join(directory, file)) and bool(re.match(regex, file)):
			files.append(file)
	return files

def listDirs(directory = os.curdir, regex = r'.*'):
	dirs = []
	for obj in os.listdir(directory):
		if os.path.isdir(os.path.join(directory, obj)) and bool(re.match(regex, obj)):
			dirs.append(obj)
	return dirs

locations = ['California', 'Mumbai', 'Paris', 'Sao_Paulo', 'Seoul', 'Sydney']
directories = ['quic', 'tcptls']
algorithms = ['RSA', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024']

for directory in directories:
	subdirs = listDirs(os.path.join(os.curdir, directory, ''), '')
	for subdir in subdirs:
		location = ''
		for _location in locations:
			if subdir.lower().startswith(_location.lower().replace('_', '')):
				location = _location
				break
		assert location != '', 'Cannot find location for directory ' + subdir + ' (wrong directory name)'

		outputFileName = 'Combined_Algorithms_' + directory.upper() + '_' + location + '.csv'
		print('Processing', outputFileName)
		with open(outputFileName, 'w') as outputFile:
			header = ''
			for algorithm in algorithms:
				header += algorithm + ','
			outputFile.write(header + '\n')
			fullDirectory = os.path.join(directory, subdir)
			files = listFiles(fullDirectory)

			data = {}
			for algorithm in algorithms:
				data[algorithm] = []

			for fileName in files:
				if not fileName.endswith('_parsed_handshake.csv'): continue
				algorithm = ''
				for _algorithm in algorithms:
					if _algorithm.replace(' ', '').lower() in fileName.lower():
						algorithm = _algorithm
				assert algorithm != '', 'Cannot find algorithm for file ' + fileName + ' (wrong file name)'
				fullFilePath = os.path.join(fullDirectory, fileName)
				with open(fullFilePath, 'r') as file:
					reader = csv.reader(file)
					for row in reader:
						handshakeDuration = row[3]
						data[algorithm].append(handshakeDuration)
					data[algorithm] = removePercentile(data[algorithm])

			lineNumber = 0
			EOF = False
			while not EOF:
				line = ''
				EOF = True
				for algorithm in algorithms:
					if lineNumber < len(data[algorithm]):
						number = data[algorithm][lineNumber]
						EOF = False
					else:
						number = ''
					line += str(number) + ','
				outputFile.write(line + '\n')
				lineNumber += 1

print('Done!')