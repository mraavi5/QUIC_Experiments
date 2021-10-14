import os
import re
import csv
import time

is_windows = os.name == 'nt'

urls_to_sample = ['facebook.com','youtube.com','google.com','twitter.com','wordpress.com','gmail.com','tripadvisor.com','yahoo.com','apple.com','glassdoor.com']

def init_test(numSamples, urls):
	cmd = 'tracert /w 1000 /h 30' if is_windows else 'traceroute -w1 -m30'
	#cmd = 'traceroute -w1 -m30'
	for i in range(numSamples):
		for url in urls:
			success = False
			while not success:
				t1 = time.time()
				os.system(f'{cmd} {url} > temp_traceroute_data.txt')
				t2 = time.time()
				time_taken = t2 - t1
				success = process_file(url, time_taken)
				if not success:
					print(f'Sample {i + 1}, URL = {url}: AN ERROR OCCURED (waiting 10 seconds then retrying the sample)')
					time.sleep(10)

			print(f'Sample {i + 1}, URL = {url}, seconds = {time_taken}')

def _match_has_number(match):
	if match is None: return False
	if match.strip() == '*': return False
	return True

# Return True for success, and False for failure (redo the sample)
def process_file(destination_url, time_taken):
	ip_latencies_dictionary = {}
	file = open('temp_traceroute_data.txt', 'r')
	lines = file.readlines()
	file.close()
	num_hops = 0

	avg_latency_list = []
	for line in lines:
		if line.startswith('*'): continue


		if is_windows:
			match = re.match(r'\s*([0-9]+|\s)\s+([^\s]+(?: ms)? +[^\s]+(?: ms)? +[^\s]+(?: ms)? +)\s+([^\s]+)(?:\s+\[([^\s]+)\])?', line)
			group_hopnum = 1
			group_latencies = 2
			group_url = 3
			group_ip = 4
		else:
			match = re.match(r'\s*([0-9]+|\s)\s+([^\s]+)\s+\(([^\s]+)\)(.+)', line)
			group_hopnum = 1
			group_url = 2
			group_ip = 3
			group_latencies = 4
		if match is None: continue
		
		if match.group(group_hopnum) == ' ': hop_number = 0
		else: hop_number = int(match.group(group_hopnum))

		url = match.group(group_url)
		ip = match.group(group_ip)
		# Fill in any empty value
		if ip is None and url is not None: ip = url
		elif url is None and ip is not None: url = ip

		everything_else = match.group(group_latencies).strip()
		
		if ip in ip_latencies_dictionary: continue # Only look at the first hop

		latencies = re.match(r'(?:([0-9\.]+ ms|\*)) *(?:([0-9\.]+ ms|\*))? *(?:([0-9\.]+ ms|\*))?', everything_else)
		if match is None: continue # No latency given
		avg_latency = 0
		avg_latency_sum = 0
		avg_latency_count = 0

		num = latencies.group(1)
		if _match_has_number(num):
			if num.endswith(' ms'): num = num[:-3]
			avg_latency_sum += float(num)
			avg_latency_count += 1

		num = latencies.group(2)
		if _match_has_number(num):
			if num.endswith(' ms'): num = num[:-3]
			avg_latency_sum += float(num)
			avg_latency_count += 1

		num = latencies.group(3)
		if _match_has_number(num):
			if num.endswith(' ms'): num = num[:-3]
			avg_latency_sum += float(num)
			avg_latency_count += 1

		if avg_latency_count == 0: continue
		avg_latency = avg_latency_sum / avg_latency_count

		ip_latencies_dictionary[ip] = avg_latency
		avg_latency_list.append(f'{url} ({ip}),{avg_latency}')
		
		num_hops = max(num_hops, hop_number)

	if num_hops == 0: return False # Signal to the parent function that we want to redo this sample

	log_sample(destination_url, num_hops, time_taken, avg_latency_list)
	return True

def log_header():
	line = ''
	line += 'Destination URL,'
	line += 'Sample Time Duration (s),'
	line += 'Number of Hops,'

	for i in range(1, 31):
		line += f'Address {i},'
		line += f'Latency (s),'
		
	output_file.write(line + '\n')
	#output_file.flush()


def log_sample(destination_url, num_hops, time_taken, avg_latency_list):
	avg_latency_str = ','.join(avg_latency_list)

	line = ''
	line += str(destination_url) + ','
	line += str(time_taken) + ','
	line += str(num_hops) + ','
	line += str(avg_latency_str) + ','
	output_file.write(line + '\n')

samples = int(input('Enter the number of samples: '))

print()
print(f'URLs to sample: {urls_to_sample}')
print(f'Number of samples per URL: {samples}')
print()
print('Starting...')
print()

file_exists = os.path.isfile('automate_traceroute_log.csv')
output_file = open('automate_traceroute_log.csv', 'a')

if not file_exists: log_header()
init_test(samples, urls_to_sample)

os.remove('temp_traceroute_data.txt')

print('Successfully automated experiment.')