import csv
import numpy as np
import os
import re
import scipy.stats
import sys
import time

useCutoff = input('Use the second-cutoff filtered data (y/n)? ').lower() in ['y', 'yes']
if not useCutoff: use95percentile = input('Use the 95 percentile filtered data (y/n)? ').lower() in ['y', 'yes']

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

# Change the color of text in the terminal
# Leaving the forground or background blank will reset the color to its default
# Providing a message will return the colored message (reset to default afterwards)
# If it's not working for you, be sure to call os.system('cls') before modifying colors
# Usage:
# - print(color('black', 'white', 'Inverted') + ' Regular')
# - print(color('black', 'white') + 'Inverted' + color() + ' Regular')
def color(foreground = '', background = '', message = ''):
	fg = {
		'red': '1;31',
		'green': '1;32',
		'yellow': '1;33',
		'blue': '1;34',
		'purple': '1;35',
		'cyan': '1;36',
		'white': '1;37',
		'black': '0;30',
		'gray': '1;30'
	}
	bg = {
		'red': ';41m',
		'green': ';42m',
		'yellow': ';43m',
		'blue': ';44m',
		'purple': ';45m',
		'cyan': ';46m',
		'white': ';47m',
		'black': ';48m'
	}
	if foreground not in fg or background not in bg: return '\033[0m' # Reset
	color = f'\033[0m\033[{ fg[foreground.lower()] }{ bg[background.lower()] }'

	if message == '': return color
	else: return f'{ color }{ str(message) }\033[0m'

# Return the +- value after a set of data
def mean_confidence_interval(data, confidence=0.95):
	a = 1.0 * np.array(data)
	n = len(a)
	m, se = np.mean(a), scipy.stats.sem(a)
	h = se * scipy.stats.t.ppf((1 + confidence) / 2., n-1)
	return h


directory = selectDir('.*Logs.*', True)

if useCutoff:
	csvFiles = listFiles(r'.*\_parsed_handshake_withcpu_removeover[0-9]+s.csv', directory)
	if len(csvFiles) == 0:
		csvFiles = listFiles(r'.*\_parsed_handshake_removeover[0-9]+s.csv', directory)
	outputFilePath = os.path.join(directory, 'COMPUTED_AVERAGES_S_CUTOFF.csv')
elif use95percentile:
	csvFiles = listFiles(r'.*\_parsed_handshake_withcpu_remove95percentile.csv', directory)
	if len(csvFiles) == 0:
		csvFiles = listFiles(r'.*\_parsed_handshake_remove95percentile.csv', directory)
	outputFilePath = os.path.join(directory, 'COMPUTED_AVERAGES_95.csv')
else:
	csvFiles = listFiles(r'.*\_parsed_handshake_withcpu.csv', directory)
	if len(csvFiles) == 0:
		csvFiles = listFiles(r'.*\_parsed_handshake.csv', directory)
	outputFilePath = os.path.join(directory, 'COMPUTED_AVERAGES.csv')

outputFile = open(outputFilePath, 'w', newline='')
outputWriter = csv.writer(outputFile)
outputFileHasHeader = False

for inputFileName in csvFiles:
	print(f'Processing "{inputFileName}"...')

	readerFile = open(inputFileName, 'r')
	reader = csv.reader(x.replace('\0', '') for x in readerFile)

	temp_header = next(reader)
	columnSums = [0] * len(temp_header)
	columnArray = []
	columnCI = [0] * len(temp_header)

	for i in range(len(temp_header)):
		columnArray.append([])


	if not outputFileHasHeader:
		output_header = ['FILE NAME']

		for i in range(len(temp_header)):
			output_header.append(f'{temp_header[i]} (AVERAGED)')
			output_header.append(f'(?? CI) {temp_header[i]}')

		outputWriter.writerow(output_header)
		outputFileHasHeader = True

	rowCounter = 0

	for row in reader:
		for i in range(len(row)):
			cell = row[i]
			try:
				cell = float(cell)
			except: pass

			if type(cell) is str:
				if columnSums[i] == 0:
					columnSums[i] = str(cell)
					columnCI[i] = ''
				continue

			columnSums[i] += cell
			columnArray[i].append(cell)
		rowCounter += 1
	# columnArray is now full

	for i in range(len(columnSums)):
		col_arr = columnArray.pop(0)
		if type(columnSums[i]) is str: continue

		if rowCounter != 0:
			columnSums[i] = float(columnSums[i]) / float(rowCounter)
		else:
			columnSums[i] = ''
		columnCI[i] = mean_confidence_interval(col_arr)

	finalRow = [inputFileName]

	while len(columnSums) > 0:
		finalRow.append(columnSums.pop(0))
		ci = columnCI.pop(0)
		finalRow.append(ci)

	outputWriter.writerow(finalRow)

	readerFile.close()

print(f'\nAverage column outputs saved to "{outputFilePath}".')
print('Goodbye.')
sys.exit()
