#!/usr/bin/python3

import os
import sys
import socket

algorithm = 'dilithium2'
algorithms = ['rsa', 'dilithium2', 'dilithium3', 'dilithium5', 'falcon512', 'falcon1024'] #, 'rsa3072_dilithium2', 'rsa3072_dilithium3', 'rsa3072_falcon512', 'p256_dilithium2', 'p256_dilithium3', 'p256_dilithium4', 'p256_falcon512']
if len(sys.argv) > 1:
	algorithm = sys.argv[1]
	
if algorithm not in algorithms:
	print(f'ARGUMENT "{algorithm}" NOT VALID ALGORITHM')
	sys.exit()

print('Using algorithm: "' + algorithm + '"')

def getIP():
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(('8.8.8.8', 1))
	return s.getsockname()[0]

server_ip = getIP()
print()
print(f'Server IP: {server_ip}')
print()

#algorithm = ''
#print('Pick an algorithm:')
#for i, v in enumerate(algorithms):
#	print(f'{i + 1}\t\t{v}')
#selection = int(input(f'Pick your algorithm to use (1 to {len(algorithms)}): '))
#if selection > 0 and selection <= len(algorithms):
#	algorithm = algorithms[selection - 1]
#else:
#	print('Invalid input.')
#	sys.exit()

print('USING ALGORITHM: ' + algorithm)

bssl_dir = os.path.expanduser('~/oqs/boringssl/build/tool/bssl')
key_crt_dir = f'~/oqs/boringssl/QUIC-project/{algorithm}/key_crt.pem'
key_srv_dir = f'~/oqs/boringssl/QUIC-project/{algorithm}/key_srv.pem'

myCmd = f'{bssl_dir} server -loop -cert {key_crt_dir} -key {key_srv_dir} -accept 44330'

os.system(myCmd)