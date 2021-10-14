import csv
import os
import re
import sys
import time

handshakeCutoff = 100 #1000 #None
print(f'Handshake counter cutoff number: ', handshakeCutoff)

# numSamples = 10
# print(f'Using {numSamples} samples')
#time.sleep(8)


# Select the droprate sequence
#droprates = [0, 5, 10, 20, 40] # Default
droprates = [0, 5, 10, 15, 20, 25, 30, 35, 40] # Default


# if '_delay_' in inputFileName:
# 	droprates = [0, 60, 100, 400, 1000]
# 	print('Needs fix for delay')
# 	sys.exit()


#quic_fields = ['', 'connection_number', 'packet_length', 'header_form', 'fixed_bit', 'long_packet_type', 'long_reserved', 'packet_number_length', 'version', 'dcil', 'dcid', 'scil', 'scid', 'token_length', 'length', 'packet_number', 'payload', 'frame', 'frame_type', 'crypto_offset', 'crypto_length', 'crypto_crypto_data', 'tls_handshake', 'tls_handshake_type', 'tls_handshake_length', 'tls_handshake_version', 'tls_handshake_random', 'tls_handshake_session_id_length', 'tls_handshake_cipher_suites_length', 'tls_handshake_ciphersuites', 'tls_handshake_ciphersuite', 'tls_handshake_comp_methods_length', 'tls_handshake_comp_methods', 'tls_handshake_comp_method', 'tls_handshake_extensions_length', 'tls_handshake_extension_type', 'tls_handshake_extension_len', 'tls_handshake_extensions_server_name_list_len', 'tls_handshake_extensions_server_name_type', 'tls_handshake_extensions_server_name_len', 'tls_handshake_extensions_server_name', 'tls_handshake_extensions_supported_groups_length', 'tls_handshake_extensions_supported_groups', 'tls_handshake_extensions_supported_group', 'tls_handshake_extensions_alpn_len', 'tls_handshake_extensions_alpn_list', 'tls_handshake_extensions_alpn_str_len', 'tls_handshake_extensions_alpn_str', 'tls_handshake_sig_hash_alg_len', 'tls_handshake_sig_hash_algs', 'tls_handshake_sig_hash_alg', 'tls_handshake_sig_hash_hash', 'tls_handshake_sig_hash_sig', 'tls_handshake_extensions_key_share_client_length', 'tls_handshake_extensions_key_share_group', 'tls_handshake_extensions_key_share_key_exchange_length', 'tls_handshake_extensions_key_share_key_exchange', 'tls_extension_psk_ke_modes_length', 'tls_extension_psk_ke_mode', 'tls_handshake_extensions_supported_versions_len', 'tls_handshake_extensions_supported_version', 'tls_parameter_type', 'tls_parameter_length', 'tls_parameter_value', 'tls_parameter_max_idle_timeout', 'tls_parameter_initial_max_data', 'tls_parameter_initial_max_stream_data_bidi_local', 'tls_parameter_initial_max_stream_data_uni', 'tls_parameter_initial_max_streams_bidi', 'tls_parameter_initial_max_streams_uni', 'tls_parameter_active_connection_id_limit', 'tls_parameter_min_ack_delay', 'tls_parameter_enable_time_stamp_v2', 'tls_parameter_loss_bits', 'tls_parameter_initial_source_connection_id', 'tls_handshake_extensions_padding_data', 'padding_length']


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

def header():
	line = 'Start timestamp (s),'
	line += 'End timestamp (s),'
	line += 'Handshake number,'
	line += 'Handshake duration (ms),'
	
	line += 'Algorithm,'
	line += 'Num Samples,'
	line += 'Experiment Type,'
	line += 'Type Value,'
	#line += 'Droprate (%),'
	
	line += 'Number of handshake packets,'
	line += 'Number of payload packets,'
	line += 'Number of handshake bytes,'
	line += 'Number of payload bytes,'
	line += 'Number of long headers,'
	line += 'Number of short headers,'
	line += 'Bytes for long headers,'
	line += 'Bytes for short headers,'
	#line = 'Timestamp,'
	#line += 'Timestamp (Seconds),'
	#line += 'Packet Num,'
	#line += 'Num Connections,'
	#line += 'Num Successful Connections,'
	#line += 'Total Bytes,'
	#line += 'QUIC Bytes,'
	#line += 'Layers,'
	#line += 'Long Packet Type,'
	#line += 'Frame,'
	#line += 'Frame Type,'
	return line

directory = selectDir('.*Logs.*', True)

csvFiles = listFiles(r'.*\_parsed.csv', directory)

for inputFileName in csvFiles:

	#inputFileName = selectFile(r'.*\_parsed.csv', False)
	#if inputFileName == '':
	#	sys.exit()
	print('\n\nOPENING', inputFileName)

	print('Droprate sequence order: ' + str(droprates))
	#modifyConnectionSequence = input('Would you like to modify this? ').lower() in ['y', 'yes']
	#if modifyConnectionSequence:
	#	dropratesStr = input('Enter a new connection sequence (separated by spaces): ').split()
	#	droprates = [int(x) for x in dropratesStr]
	#	print('Droprate sequence order: ' + str(droprates))
	#print()

	fileName = os.path.join(directory, os.path.basename(inputFileName[:-4] + '_handshake.csv'))

	outputFile = open(fileName, 'w', newline='')
	readerFile = open(inputFileName, 'r')
	reader = csv.reader(x.replace('\0', '') for x in readerFile)

	temp_header = next(reader)

	outputFile.write(header() + '\n')

	time_start = {}
	time_end = {}
	handshake_length = {}
	payload_length = {}
	handshake_bytes = {}
	payload_bytes = {}
	handshake_long_headers = {}
	handshake_short_headers = {}
	handshake_long_headers_bytes = {}
	handshake_short_headers_bytes = {}
	#sample_num = -1

	# experimental_setup_droprate = []
	# # Copying the experiment_droprate_client.py experimental setup
	# for droprate in droprates:
	# 	samples = numSamples
	# 	while samples > 0:
	# 		experimental_setup_droprate.append(droprate)
	# 		samples -=1
	# Used to track the Wireshark connection counter, and compare it to the experimental_setup_droprate
	#timeline_of_samples = [] # "At this experiment height, wireshark is at connection N"
	successful_connection_max_value = -1
	exp_variables_at_successful_connection = []
	num_skipped_overlapping_packets = 0

	for packet in reader:
		if packet[9] == '': continue

		file_algorithm = packet[2]
		file_numSamples = packet[3]
		file_experimentType = packet[4]
		file_experimentVal = packet[5]

		is_handshake_packet = packet[7].strip().upper() == 'TRUE'
		sample_num = int(packet[8])

		num_successful_connections = int(packet[9])

		# Keep track of the maximum
		if num_successful_connections > successful_connection_max_value:
			if num_successful_connections % 100 == 0:
				print(f'Processing handshake {num_successful_connections}')

			successful_connection_max_value = num_successful_connections
			# if sample_num >= len(experimental_setup_droprate):
			# 	# If for some reason there are more samples (overfilled), assume it is part of the last accepted sample
			# 	current_droprate_at_this_time = experimental_setup_droprate[-1]
			# else:
			# 	#current_droprate_at_this_time = experimental_setup_droprate[sample_num]
			# 	if num_successful_connections >= len(experimental_setup_droprate):
			# 		# If the index is too big, assume it is the last droprate
			# 		current_droprate_at_this_time = experimental_setup_droprate[-1]
			# 	else:
			# 		current_droprate_at_this_time = experimental_setup_droprate[num_successful_connections]
			# Keep the exp_variables_at_successful_connection array size up to date
			# while len(exp_variables_at_successful_connection) <= num_successful_connections:
			# 	exp_variables_at_successful_connection.append(current_droprate_at_this_time)
			exp_variables_at_successful_connection.append([file_algorithm, file_numSamples, file_experimentType, file_experimentVal])


		# Logging section, if entry doesn't exist, create it, otherwise update it
		if num_successful_connections not in handshake_length: # Bug
			# First time, initialize entry in dictionary
			handshake_length[num_successful_connections] = 0
			payload_length[num_successful_connections] = 0
			handshake_bytes[num_successful_connections] = 0
			payload_bytes[num_successful_connections] = 0
			handshake_long_headers[num_successful_connections] = 0
			handshake_short_headers[num_successful_connections] = 0
			handshake_long_headers_bytes[num_successful_connections] = 0
			handshake_short_headers_bytes[num_successful_connections] = 0
			time_start[num_successful_connections] = float(packet[1])


		# If we find a packet from the previous experiment, skip
		# if len(exp_variables_at_successful_connection) > num_successful_connections and exp_variables_at_successful_connection[num_successful_connections] < current_droprate_at_this_time:
		# 	num_skipped_overlapping_packets += 1
		# 	continue

		if is_handshake_packet:
			time_end[num_successful_connections] = float(packet[1])
			handshake_length[num_successful_connections] += 1
			handshake_bytes[num_successful_connections] += int(packet[10])

		else:
			payload_length[num_successful_connections] += 1
			payload_bytes[num_successful_connections] += int(packet[10])

		# Count number of long and short headers
		long_short_list = packet[16].split(' ')
		quic_bytes = packet[11].split(' ')
		for i in range(len(long_short_list)):
			if long_short_list[i] == 'long':
				handshake_long_headers[num_successful_connections] += 1
				handshake_long_headers_bytes[num_successful_connections] += int(quic_bytes[i])
			elif long_short_list[i] == 'short':
				handshake_short_headers[num_successful_connections] += 1
				handshake_short_headers_bytes[num_successful_connections] += int(quic_bytes[i])

	for i in range(0, successful_connection_max_value):
		if handshakeCutoff is not None and i >= handshakeCutoff:
			print('HANDSHAKE CUTOFF REACHED, BREAKING')
			break
		try:
			line = ''
			line += f'{time_start[i]},'
			line += f'{time_end[i]},'
			line += f'{i},'
			line += f'{(time_end[i] - time_start[i]) * 1000},'
			line += f'{exp_variables_at_successful_connection[i][0]},' # Algorithm
			line += f'{exp_variables_at_successful_connection[i][1]},' # Num Samples
			line += f'{exp_variables_at_successful_connection[i][2]},' # Experiment Type
			line += f'{exp_variables_at_successful_connection[i][3]},' # Type Value
			line += f'{handshake_length[i]},'
			line += f'{payload_length[i]},'
			line += f'{handshake_bytes[i]},'
			line += f'{payload_bytes[i]},'
			line += f'{handshake_long_headers[i]},'
			line += f'{handshake_short_headers[i]},'
			line += f'{handshake_long_headers_bytes[i]},'
			line += f'{handshake_short_headers_bytes[i]},'

			outputFile.write(line + '\n')
		except:
			print(f'Handshake {i} does not exist!')
			continue

	if num_skipped_overlapping_packets != 0:
		print(color('red', 'black', '!' * 100))
		print('Number of skipped overlapping packets across experiments:', num_skipped_overlapping_packets)
		print(color('red', 'black', '!' * 100))
	#readerFile.seek(0) # Reset it back to the beginning
	# for packet in reader:
	# 	timestamp = packet[0]
	# 	timestamp_seconds = packet[1]
	# x	packet_num = packet[2]
	# x	is_handshake_packet = packet[3]
	# x	num_connections = packet[4]
	# x	num_successful_connections = packet[5]
	# x	total_bytes = packet[6]
	# x	quic_bytes = packet[7]
	# x	layers = packet[8]
	# x	long_packet_type = packet[9]
	# x	frame = packet[10]
	# x	frame_type = packet[11]
	# x	long_short_headers = packet[12]

	#file = open(fileName, 'w+')
	#file.write(header() + '\n')

	print()
	print(f'Saved to "{fileName}".')
	outputFile.close()

print('\n\nPROCESSED FILES:\n', '\n '.join(csvFiles))
print('Goodbye.')
sys.exit()
