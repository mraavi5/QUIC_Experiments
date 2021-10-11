import os
import re
import socket
import time
import sys
import paramiko
import threading
import atexit
from getpass import getpass

# sudo apt-get install python3-paramiko


global ssh_obj
global closingApplication

numSamples = 1000
droprates = [0] #[0, 0, 0, 0, 0]

print('Number of samples', numSamples)

if not os.path.exists('fullyAutomatedBasicLogs'):
	os.makedirs('fullyAutomatedBasicLogs')

# Send a command to the linux terminal
def terminal(cmd):
	#print(cmd)
	return os.popen(cmd).read()

def call_ssh(cmd):
	#print('Calling ', cmd)
	ssh_stdin, ssh_stdout, ssh_stderr = ssh_obj.exec_command(cmd)
	outlines = ssh_stdout.readlines()
	response = ''.join(outlines)
	#print('Ending ', cmd)
	return response

def clear_filters():
	terminal(f'sudo tc qdisc del dev {interface} root netem > /dev/null 2>&1')

def network_delimeter(server_ip):
	terminal(f'nc -vz {server_ip} 4434 >/dev/null 2>/dev/null')


threads = []

# Run a fuction in parallel to other code
class Task(threading.Thread):
	def __init__(self, name, function, *args):
		assert isinstance(name, str), 'Argument "name" is not a string'
		assert callable(function), 'Argument "function" is not callable'
		threading.Thread.__init__(self)
		self._stop_event = threading.Event()

		self.setName(name)
		self.function = function
		self.args = args

	def run(self):
		self.function(*self.args)
		self._stop_event.set()

	def stop(self):
		self._stop_event.set()

	def stopped(self):
		return self._stop_event.is_set()

# Creates a new thread and starts it
def create_task(name, function, *args):
	if len(threads) >= 200:
		# Remove the first 10 threads if it exceeds 200, to balance it out
		for i in range(10):
			threads[i].stop()
			del threads[i]
	task = Task(name, function, *args)
	threads.append(task)
	task.start()
	return task

# This function is ran when the script is stopped
def on_close():
	global closingApplication
	closingApplication = True
	print('Stopping active threads')

	stop_server_SSH(server_ip)
	for thread in threads:
		thread.stop()
	stopTcpdump()
	
	print()
	print('Goodbye.')

atexit.register(on_close) # Make on_close() run when the script terminates


def getTcpdumpProcessID():
	output = terminal('ps -A | grep tcpdump')
	output = output.strip().split(' ')
	if len(output) == 0 or output[0] == '': return None
	pid = int(output[0])
	return pid

def stopTcpdump():
	pid = getTcpdumpProcessID()
	if pid != None:
		print('Stopping TCPDUMP...')
		call_ssh(f'sudo pkill -f tcpdump')
	

def startTcpdump(interface, algorithm):
	stopTcpdump()
	myCmd = f'python3 experiment_basic_run_tcpdump.py {interface} {algorithm} {numSamples}'
	print(myCmd)
	create_task('tcpdump', terminal, myCmd)


def startCPUlogger():
	print('Starting CPU logger...')
	myCmd = f'python3 experiment_log_cpu.py'
	print(myCmd)
	create_task('cpu logger', terminal, myCmd)


def getServerProcessID(server_ip):
	output = call_ssh('ps -A | grep bssl')
	output = output.strip().split(' ')
	if len(output) == 0 or output[0] == '': return None
	pid = int(output[0])
	return pid

def stop_server_SSH(server_ip):
	pid = getServerProcessID(server_ip)
	while pid != None:
		print('Stopping server...')
		call_ssh(f'pkill -f bssl')
		pid = getServerProcessID(server_ip)
		if pid != None:
			time.sleep(1)

def restart_server_SSH(algorithm, server_ip):
	stop_server_SSH(server_ip)
	print('Starting server...')
	output = call_ssh(f'python3 ~/oqs/boringssl/QUIC-project/plan_b/experiment_basic_server.py {algorithm} </dev/null &>/dev/null &')
	print()
	print('Server started! Waiting 5 seconds to be certain...')
	time.sleep(5)

def get_IP():
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(('8.8.8.8', 1))
	return s.getsockname()[0]

# Return an array of networking interfaces
def get_interfaces():
	raw = terminal('ip link show')
	interfaces = re.findall(r'[0-9]+: ([^:]+): ', raw)
	interfaces.remove('lo')

	interface = ''
	if len(interfaces) == 0:
		print(terminal('ifconfig'))
		print()
		print('No networking interfaces were found.')
		sys.exit()

	elif len(interfaces) == 1:
		interface = interfaces[0]

	else:
		for i in range(0, len(interfaces)):
			print(f'{i + 1} : {interfaces[i]}')
		selection = -1
		while selection < 1 or selection > len(interfaces):
			try:
				selection = int(input(f'Please select an interface (1 to {len(interfaces)}): '))
			except: pass
		interface = interfaces[selection - 1]
		print()
	return interface

boringssl_dir = os.path.expanduser('~/oqs/boringssl')
cert = os.path.expanduser('~/oqs/boringssl/QUIC-project')

client_ip = get_IP()
print(f'Client IP: {client_ip}')
server_ip = input('Please enter the server IP (\'\' for 10.0.2.8): ')
if server_ip == '': server_ip = '10.0.2.8'

ssh_port = 22
ssh_username = input('Enter server username (\'\' for ubuntu2): ')
if ssh_username == '': ssh_username = 'ubuntu2'

ssh_password = getpass('Enter server password (\'\' for ' '): ')
if ssh_password == '': ssh_password = ' '

print('Server username:', ssh_username)
print('Server password:', ssh_password)
print()

interface = get_interfaces()

print('Connecting to SSH...')
ssh_obj = paramiko.SSHClient()
ssh_obj.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh_obj.connect(server_ip, ssh_port, ssh_username, ssh_password)
ssh_stdin, ssh_stdout, ssh_stderr = ssh_obj.exec_command("sudo -s")
ssh_stdin.write(f'{ssh_password}\n')
ssh_stdin.flush()


#startCPUlogger()

algorithms = ['rsa', 'dilithium2', 'dilithium3', 'dilithium5', 'falcon512', 'falcon1024'] #, 'rsa3072_dilithium2', 'rsa3072_dilithium3', 'rsa3072_falcon512', 'p256_dilithium2', 'p256_dilithium3', 'p256_dilithium4', 'p256_falcon512']

stop_server_SSH(server_ip)
stopTcpdump()

numLoops = 0
closingApplication = False
#while not closingApplication: # Only look once
try:
	for algorithm in algorithms:
		print(f'Using algorithm: "{algorithm}"')
		startTcpdump(interface, algorithm)
		time.sleep(1)

		myCmd=f'{boringssl_dir}/build/tool/./bssl client -connect {server_ip}:44330 &'
		
		#print('Starting...')

		clear_filters()
		network_delimeter(server_ip)
		network_delimeter(server_ip)
		network_delimeter(server_ip)
		restart_server_SSH(algorithm, server_ip)

		for droprate in droprates:
			#print(f'Testing delay: {droprate}')
			samples = numSamples
			while samples > 0:

				clear_filters()
				network_delimeter(server_ip)

				os.system(myCmd)

				terminal("sudo xte 'str AAAAAAAA' 'key Return'")
				time.sleep(1)
				samples -=1
			#print('Waiting 3 minutes before starting next droprate test...')
			#time.sleep(120)
		#time.sleep(120)
		stopTcpdump()
	
	numLoops += 1
	print('Number of times through each algorithm:', numLoops)
except KeyboardInterrupt():
	sys.exit()


print()
print('Experiment completed.')
