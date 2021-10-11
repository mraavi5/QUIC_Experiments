import os
import socket

def getIP():
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(('8.8.8.8', 1))
	return s.getsockname()[0]

lsquic_dir = os.path.expanduser('~/oqs/lsquic')
cert_dir = os.path.expanduser('~/oqs/lsquic/certs/rsa')

print(f'Certificate Directory: {cert_dir}')
n = 1

client_ip = getIP()
print(f'Client IP: {client_ip}')
print(f'Number of samples: ', n)
serverIP = input('Please enter the server IP: ')

#myCmd = f'{lsquic_dir}/build/bin/./http_client -L debug -C {cert_dir} -H www.example.com -s {serverIP}:4433 -p /'
myCmd = f'{lsquic_dir}/build/bin/./http_client -C {cert_dir} -H www.example.com -s {serverIP}:4433 -p /'

print(f'myCmd = {myCmd}')

while n>0:
    os.system(myCmd)
    n -= 1