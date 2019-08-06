#!/usr/bin/python3
import setproctitle
import subprocess
import signal
import i3ipc

PROCESS_NAME = 'i3ipc-switch-desktop'

# SIGNTERM another processes
pid_list = subprocess.check_output([
    '/bin/bash', '-c' ,'pidof %s || true' % PROCESS_NAME
]).decode('utf-8')
pid_list = pid_list.replace('\n', '').split(' ')

for pid in pid_list:
    if pid:
        subprocess.call(['kill', pid])

# set current process name
setproctitle.setproctitle(PROCESS_NAME)

ipc_conn = i3ipc.Connection()


def switch_workspace(direction):
    workspace_list = ipc_conn.get_workspaces()
    for workspace in workspace_list:
        if workspace.get('focused') is True:
            curr_w = workspace.get('num')
            next_w = int(curr_w) + direction

            if 0 < next_w < 10:
                ipc_conn.command("workspace %s" % next_w)

            break


def go_to_next(signalNumber, frame):
    switch_workspace(1)


def go_to_prev(signalNumber, frame):
    switch_workspace(-1)


signal.signal(signal.SIGUSR1, go_to_next)
signal.signal(signal.SIGUSR2, go_to_prev)

try:
    ipc_conn.main()
except KeyboardInterrupt:
    exit()
