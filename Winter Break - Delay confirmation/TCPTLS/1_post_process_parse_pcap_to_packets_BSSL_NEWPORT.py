import datetime
import os
import pyshark
import re
import sys
import time

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

def header():
	line = 'Timestamp,'
	line += 'Timestamp (Seconds),'
	line += 'Algorithm,'
	line += 'Num Samples,'
	line += 'Experiment Type,'
	line += 'Type Value,'
	line += 'Packet Num,'
	line += 'Is Handshake Packet,'
	line += 'Num Connections,'
	line += 'Num Successful Connections,'
	line += 'Total Bytes,'
	line += 'QUIC Bytes,'
	line += 'Layers,'
	line += 'Long Packet Type,'
	line += 'Frame,'
	line += 'Frame Type,'
	line += 'Long/Short,'

	#for field in quic_fields:
	#	line += field.replace('_', ' ').capitalize() + ','

	return line

def log(packet, fileName, file, is_handshake_packet):
	global connectionCount

	packetNum = int(packet.number)
	if packetNum % 1000 == 0:
		print(f'Processing packet {packetNum}')

	# Example file name: pending_TCPDUMP_dilithium2_numSamples_1000_loss_15%_krPKqIdXJd
	file_algorithm = ''
	file_numSamples = ''
	file_experimentType = ''
	file_experimentVal = ''
	match = re.match(r'(?:pending_)?TCPDUMP_([^_]+)_numSamples_([^_]+)_([^_]+)_([^_]+)', fileName)
	if match is not None:
		file_algorithm = match.group(1)
		file_numSamples = match.group(2)
		file_experimentType = match.group(3)
		file_experimentVal = match.group(4)
	else:
		print(f'File doesn\'t match path: {fileName}')

	successfulConnectionNum = ''

	timestamp = packet.sniff_time
	timestamp_seconds = (timestamp - datetime.datetime(1970, 1, 1)).total_seconds()

	totalBytes = packet.length
	tlsBytes = ''
	long_short = ''


	layers = ''
	longPacketType = ''
	longPacketTypes = ['Initial', 'Retry', 'Handshake', '0-RTT', '']
	frame = ''
	frameType = ''
	frameTypes = ['PADDING', 'PING', 'ACK', 'RESET_STREAM', 'STOP_SENDING', 'CRYPTO', 'NEW_TOKEN', 'STREAM', 'MAX_DATA', 'MAX_STREAM_DATA', 'MAX_STREAMS (BIDI)', 'MAX_STREAMS (UNI)', 'DATA_BLOCKED', 'STREAM_DATA_BLOCKED', 'STREAMS_BLOCKED (BIDI)', 'STREAMS_BLOCKED (UNI)', 'NEW_CONNECTION_ID', 'RETIRE_CONNECTION_ID', 'PATH_CHALLENGE', 'PATH_RESPONSE', 'CONNECTION_CLOSE (Transport)', 'CONNECTION_CLOSE (Application)', 'HANDSHAKE_DONE', 'DATAGRAM', 'ACK_FREQUENCY', 'TIME_STAMP', '']
	for layer in packet:
		layers += layer.layer_name.upper() + ' '
		if layer.layer_name == 'tcp':
			successfulConnectionNum = str(connectionCount) #(layer.get_field('connection_number') or '') + ' '
			
			#print(layer)
			#print(dir(layer))
			#print()
			#print(layer._all_fields)
			#print()
			
			#tlsBytes += layer.get_field('packet_length') + ' '
			#longPacketType += longPacketTypes[int(layer.get_field('long_packet_type') or 4)] + ' '
			_frame = layer.get_field('tcp.flags.str') #layer.get_field('frame') or ''
			#if _frame.endswith('Server Hello'): _frame = 'TLS Server Hello'
			#if _frame.endswith('Client Hello'): _frame = 'TLS Client Hello'
			frame += _frame + ' '
			frameType += frameTypes[int(layer.get_field('frame_type') or 26)] + ' '
			#if longPacketTypes[int(layer.get_field('long_packet_type') or 4)] == '':
			#	long_short += 'short '
			#else:
			#	long_short += 'long '

	line = f'{timestamp},{timestamp_seconds},{file_algorithm},{file_numSamples},{file_experimentType},{file_experimentVal},{packetNum},{is_handshake_packet},{connectionCount},{successfulConnectionNum.strip()},{totalBytes},{tlsBytes.strip()},{layers.strip()},{longPacketType.strip()},{frame.strip()},{frameType.strip()},{long_short.strip()}'
	
	file.write(line + '\n')



directory = selectDir('.*Logs.*', True)

pcapFiles = listFiles(r'.*\.pcap', directory)

for pcapName in pcapFiles:
	#pcapName = selectFile(r'.*\.pcap', False)
	#if pcapName == '':
	#	sys.exit()

	print('\n\nOPENING', pcapName)
	fileName = pcapName[:-5] + '_parsed.csv'

	outputFile = open(fileName, 'w', newline='')

	file = open(fileName, 'w+')
	file.write(header() + '\n')

	pcap = pyshark.FileCapture(pcapName)

	running = True
	count = 0
	connectionCount = 0
	newConnectionCountReady = False # Force a TLS in between each ACK RST, to prevent duplicate ACK RSTs
	countNumChangeCipherSpecsInHandshake = 0 # Max: 2
	while running:
		try:
			packet = pcap[count]

			first_tcp_layer_index = -1
			for i, layer in enumerate(packet.layers):
				if layer._layer_name == 'tcp':
					first_tcp_layer_index = i
					break
			first_tls_layer_index = -1
			for i, layer in enumerate(packet.layers):
				if layer._layer_name == 'tls':
					first_tls_layer_index = i
					break


			#if packet.highest_layer == 'TCP' or packet.highest_layer == 'TLS':
			if first_tls_layer_index != -1:
				newConnectionCountReady = True

			if newConnectionCountReady and packet.layers[first_tcp_layer_index].flags == '0x00000014': # ACK RST
				connectionCount += 1
				countNumChangeCipherSpecsInHandshake = 0 # Reset the count
				newConnectionCountReady = False
			else:
				# Port 4434 was programmed to be only for delimiters
				if packet.layers[first_tcp_layer_index].srcport == '4434' or packet.layers[first_tcp_layer_index].dstport == '4434':
					#print('Delimiter')
					pass
				else:
					is_handshake_packet = (countNumChangeCipherSpecsInHandshake < 2)
					log(packet, os.path.basename(pcapName), file, is_handshake_packet)

			# Anything AFTER the second cipher spec will not be part of the payload
			hasChangeCipherSpec = packet.layers[first_tls_layer_index].get_field('change_cipher_spec') is not None
			if hasChangeCipherSpec:
				countNumChangeCipherSpecsInHandshake += 1

		except (StopIteration, KeyError): # End of file
			running = False
			break
		except: # Corrupt packet? Skip
			print('ERROR OCCURED, SKIPPING')
			count += 1
			continue
		# except Exception as e: # Corrupt packet? Skip
		# 	print('ERROR OCCURED, SKIPPING')
		# 	print(type(e))
		# 	print(e.args)
		# 	print(e)
		# 	count += 1
		# 	continue
		count += 1
		
		#if count >= 106:
		#	print()
		#	print()
		#	print('Goodbye!')
		#	sys.exit()

	print()
	print(f'Saved to "{fileName}".')

	file.close()

print('\n\nPROCESSED FILES:', '\n '.join(pcapFiles))
print('Goodbye.')
sys.exit()

# import pyshark

# pcap_data = pyshark.FileCapture('WIRESHARK_LOG.pcap')

# for packet in pcap_data:
# 	print(f'Index: {packet.number}')
# 	print(f'Timestamp: {packet.sniff_time}')
# 	print(f'Bytes: {packet.length}')
# 	print(f'Layers: {packet.layers}')

# 	#for layer in packet:
# 	#	if layer.layer_name == 'quic':