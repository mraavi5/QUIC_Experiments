#!/usr/bin/python3

import datetime
import os
import time
import sys
import random
import string

def genNonce():
	length = 10
	return ''.join(random.choice(string.ascii_letters) for x in range(length))

algorithms = ['rsa', 'dilithium2', 'dilithium3', 'dilithium5', 'falcon512', 'falcon1024'] #, 'rsa3072_dilithium2', 'rsa3072_dilithium3', 'rsa3072_falcon512', 'p256_dilithium2', 'p256_dilithium3', 'p256_dilithium4', 'p256_falcon512']

if len(sys.argv) >= 4:
	interface = sys.argv[1]
	algorithm = sys.argv[2]
	numSamples = sys.argv[3]
else:
	print('Not enough parameters given')
	print('Parameters are [interface, algorithm, numSamples]')
	sys.exit()

if algorithm not in algorithms:
	print(f'Unsupported algorithm: "{algorithm}"')

print('Starting PCAP Logger...')

# Send commands to the Linux terminal
def terminal(cmd):
	return os.popen(cmd).read()

nonce = genNonce()

terminal(f'sudo tcpdump -i {interface} -w fullyAutomatedBasicLogs/pending_TCPDUMP_{algorithm}_numSamples_{numSamples}_drop_{nonce}.pcap \'port 4433 or port 4434 or port 44330\'')

os.rename(f'fullyAutomatedBasicLogs/pending_TCPDUMP_{algorithm}_numSamples_{numSamples}_drop_{nonce}.pcap', f'fullyAutomatedBasicLogs/TCPDUMP_{algorithm}_numSamples_{numSamples}_drop_{nonce}.pcap')

#terminal('sudo tcpdump -i any -w newLogs/WIRESHARK_dilithium5-aes_0RTT.pcap \'port 44330\'')
#terminal('tshark -i any -d tcp.port==44330,http -w Logs/WIRESHARK_LOG')