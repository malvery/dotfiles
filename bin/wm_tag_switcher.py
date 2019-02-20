#!/usr/bin/python3
import subprocess
import sys

argv = sys.argv[1:]
if argv:
    if argv[0] == 'prev':
        prev_direction = True
    elif argv[0] == 'next':
        prev_direction = False
    else:
        sys.exit(1)
else:
    sys.exit(1)

# get current desktop
result = subprocess.check_output(['wmctrl', '-d']).decode('utf-8')
result = result.split('\n')[:-1]

current_desktop = None
for item in result:
    if '*' in item:
        item = item.split(' ')
        current_desktop = int(item[0])

# get desktops list with clients
result = subprocess.check_output(['wmctrl', '-l']).decode('utf-8')
result = result.split('\n')[:-1]

desktop_list = list()
for item in result:
    item = item.split(' ')
    desktop_list.append(int(item[2]))

# choose next / prev desktop
desktop_list.sort()
if prev_direction:
    desktop_list.reverse()

new_desktop = None
for tag in desktop_list:
    if (tag > current_desktop and prev_direction is False) or (tag < current_desktop and prev_direction):
        new_desktop = tag
        break

if new_desktop is not None:
    subprocess.check_output(['wmctrl', '-s', str(new_desktop)])

