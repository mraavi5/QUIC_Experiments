import atexit
import os
import re
import sys

# List the files with a regular expression
def listFiles(regex, subdirs = False):
	if subdirs:
		files = []
		for (dirpath, dirnames, filenames) in os.walk('.'):
			for file in filenames:
				path = os.path.join(dirpath, file)
				if path[:2] == '.\\': path = path[2:]
				if bool(re.match(regex, path)):
					files.append(path)
		return files
	else:
		return [file for file in os.listdir(os.curdir) if os.path.isfile(file) and bool(re.match(regex, file))]

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

# Draws the header
def header(message, width):
	print(color('black', 'white', ' ' * width))
	print(color('black', 'white', message.center(width)))
	print(color('black', 'white', ' ' * width))
	print()

# Code runs when the application ends
def on_close():
	print()
	header('Goodbye', width)

# Prints out the files
def print_files_regex(files, regex, width):
	print(color('green', 'black'), end='')
	for file in files:
		groups = []
		for match in re.finditer(regex, file):
			start, end = match.span()
			file = f'{file[:start]}{color("white", "green")}{file[start:end]}{color("green", "black")}{file[end:]}'
			for group in match.groups():
				groups.append(group)
		print(f' {file} {color()}has groups{color("green", "black")} {groups}')

	print(color())
	print(f' Files selected: { color("green", "black", len(files)) }')

# Prints out the files
def print_files_replacement(files, regex, replacement, width):
	print(color('green', 'black'), end='')
	for file in files:
		after = re.sub(regex, replacement, file)
		print(f' "{file}" {color()}renamed to{color("green", "black")} "{after}"')

	print(color())
	print(f' Files selected: { color("green", "black", len(files)) }')

# Main function
if __name__ == '__main__':
	atexit.register(on_close)

	width = os.get_terminal_size().columns
	height = os.get_terminal_size().lines

	os.system('cls')
	header('File Renamer Regex', width)
	subdirs = input('\n Search subdirectories? (y/n) ')
	while subdirs not in ['y', 'n']:
		subdirs = input('\n Search subdirectories? (y/n) ')
	subdirs = subdirs == 'y'
	for file in listFiles('.', subdirs):
		print(file.center(width))

	regex = ''
	while(regex == ''):
		regex = input('\n Enter a regular expression (parentheses for capturing groups): ' + color('blue', 'black'))
		print(color(), end='') # Reset the color
	print()
	old_regex = regex

	while(True):
		try:
			files = listFiles(regex, subdirs)
			print_files_regex(files, regex, width)
			print(f'\n Press {color("blue", "black", "ENTER")} to proceed')
		except Exception as e:
			print(color('red', 'black', f' {str(e).capitalize()}\n'))

		old_regex = regex
		regex = input(' Enter a regular expression (parentheses for capturing groups): ' + color('blue', 'black'))
		print(color()) # Reset the color
		if regex == '': break

	regex = old_regex

	header('Replace file names with', width)

	replacement = input('\n Enter a replacement (capturing groups can be accessed with \\1, \\2, \\3, ...): ' + color('blue', 'black'))
	old_replacement = replacement
	while(True):
		try:
			files = listFiles(regex, subdirs)
			print_files_replacement(files, regex, replacement, width)
			print(f'\n Press {color("blue", "black", "ENTER")} to proceed')
		except Exception as e:
			print(color('red', 'black', f' {str(e).capitalize()}\n'))

		old_replacement = replacement
		replacement = input(' Enter a replacement (capturing groups can be accessed with \\1, \\2, \\3, ...): ' + color('blue', 'black'))
		print(color()) # Reset the color
		if replacement == '': break

	replacement = old_replacement

	header('Review file modifications', width)

	files = listFiles(regex, subdirs)
	for file in files:
		after = re.sub(regex, replacement, file)
		print(f' "{color("red", "black", file)}" will be renamed to "{color("yellow", "black", after)}"')

	print()
	confirm = ''
	while confirm.strip().lower() not in ['y', 'n', 'yes', 'no']:
		confirm = input(' Proceed? (y/n) ' + color('blue', 'black')).strip().lower()
		print(color(), end='')

	if confirm != 'y' and confirm != 'yes':
		print(' No modifications were applied.')
		sys.exit()

	print()
	header('Renaming files...', width)

	for file in files:
		after = re.sub(regex, replacement, file)
		print(f' Renaming "{color("red", "black", file)}" to "{color("yellow", "black", after)}" ...')
		try:
			os.rename(file, after)
		except Exception as e:
			print(f'\t{color("white", "red", f" {str(e).capitalize()}")}\n')

	print('\n File renaming has completed.')