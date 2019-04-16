#!/usr/bin/python3
import setproctitle
import signal
import i3ipc
import time

setproctitle.setproctitle('i3-window-switcher')

########################################################################################################################


class WorkspaceClients(object):
    current = None
    recent = None


switcher_clients = dict()
i3_conn_commands = i3ipc.Connection()


def receiveSignal(signalNumber, frame):
    print('Received:', signalNumber)

    print('\nrecent_client')
    focused = i3_conn_commands.get_tree().find_focused()
    workspace_n = focused.workspace().num
    workspace = switcher_clients.get(workspace_n)

    if workspace is None:
        switcher_clients[workspace_n] = WorkspaceClients()
        switcher_clients[workspace_n].current = focused.id
        i3_conn_commands.command('focus right')

    elif workspace.recent is not None:
        print('[con_id="%s"] focus' % workspace.recent)
        result = i3_conn_commands.command('[con_id="%s"] focus' % workspace.recent)
        if result[0].get('success') != True:
            i3_conn_commands.command('focus right')

    else:
        print('empty workspace history')
        i3_conn_commands.command('focus right')

    return


signal.signal(signal.SIGUSR1, receiveSignal)


def on_window_focus(i3, e):
    focused = i3.get_tree().find_focused()
    workspace_n = focused.workspace().num
    workspace = switcher_clients.get(workspace_n)

    if not workspace:
        workspace = WorkspaceClients()
        switcher_clients[workspace_n] = workspace

    # current_focus = focused.window_class
    window_id = focused.id
    if workspace.current is None:
        workspace.current = window_id

    if workspace.current != window_id:
        workspace.recent = workspace.current
        workspace.current = window_id

    print(workspace_n, workspace.current, workspace.recent)


i3_conn_events = i3ipc.Connection()
i3_conn_events.on("window::focus", on_window_focus)
try:
    i3_conn_events.main()
except KeyboardInterrupt:
    exit()
