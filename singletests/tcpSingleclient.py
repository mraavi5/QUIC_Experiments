import os
import socket
import time

def getIP():
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(('8.8.8.8', 1))
	return s.getsockname()[0]

def sendCommandsToTerminateClient():
    os.system("bash -c \"sleep 0.1 ; xte 'str AAAAAAAAAA' 'key Return' 'keydown Control_L' 'key C' 'keyup Control_L'\" &")

bssl_dir = os.path.expanduser('~/oqs/boringssl/build/tool/bssl')
cert_dir = os.path.expanduser('~/oqs/boringssl/certs/dilithium5/key_CA.pem')
#cert_dir = os.path.expanduser('~/oqs/boringssl/QUIC-project/broken_rsa/key_CA.pem')

print(f'Certificate Directory: {cert_dir}')
n = 1

client_ip = getIP()
print(f'Client IP: {client_ip}')
print(f'Number of samples: ', n)
serverIP = input('Please enter the server IP: ')

#With verification
#myCmd=f'{bssl_dir} client -connect {serverIP}:44330 -root-certs {cert_dir}'

#Without verification
myCmd=f'{bssl_dir} client -connect {serverIP}:44330'


while n>0:

    #print('Sending A, CTRL+C...')
    #sendCommandsToTerminateClient()

    os.system(myCmd)
    n -= 1
