#!/usr/bin/python3
import i3ipc
import sys

action = sys.argv[1]
actions_info = {
    'left': -1,
    'right': 1
}

sway_conn = i3ipc.Connection()
workspace_list = sway_conn.get_workspaces()

for workspace in workspace_list:
    if workspace.get('focused') is True:
        curr_w = workspace.get('num')
        next_w = int(curr_w) + actions_info.get(action, 0)
        
        if 0 < next_w < 10:
            sway_conn.command("workspace %s" % next_w)
            
        break
