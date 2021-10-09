import os 
import socket

def getIP():
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(('8.8.8.8', 1))
	return s.getsockname()[0]

bssl_dir = os.path.expanduser('~/oqs/boringssl/build/tool/bssl')
key_crt_dir = f'~/oqs/boringssl/certs/rsa/key_crt.pem'
key_srv_dir = f'~/oqs/boringssl/certs/rsa/key_srv.pem'

print(f'Key CRT Directory: {key_crt_dir}')
print(f'Key SRV Directory: {key_srv_dir}')

server_ip = getIP()
print()
print(f'Server IP: {server_ip}')
print()

myCmd = f'{bssl_dir} server -loop -cert {key_crt_dir} -key {key_srv_dir} -accept 44330'
os.system(myCmd)
