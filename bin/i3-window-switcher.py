#!/usr/bin/python3
import setproctitle
import signal
import i3ipc

################################################################################


class RecentClients(object):
    curr = None  # last current window
    prev = None  # previous window

    def __init__(self, workspace):
        # save workspace index
        self.workspace = workspace


setproctitle.setproctitle('i3-window-switcher')
switcher_containers = dict()

################################################################################


def get_switcher_item(i3):
    w_tree = i3.get_tree()
    focused = w_tree.find_focused()
    workspace_n = focused.workspace().num

    s_container = switcher_containers.get(workspace_n)
    if s_container.curr is None:
        s_container.curr = focused.id

    return s_container, focused, w_tree


def switch_to_recent(i3):
    s_container, focused, w_tree = get_switcher_item(i3=i3)

    if s_container.prev is not None:
        result = i3.command(
            '[con_id="%s"] focus' % s_container.prev
        )
        # force switch
        if result[0].get('success') is not True:
            i3.command('focus right')

    else:
        # empty history
        i3.command('focus right')


################################################################################

i3_conn_commands = i3ipc.Connection()


def receiveSignal(signalNumber, frame):
    switch_to_recent(i3=i3_conn_commands)


signal.signal(signal.SIGUSR1, receiveSignal)

################################################################################


def on_window_focus(i3, e):
    s_container, focused, w_tree = get_switcher_item(i3=i3)
    window_id = focused.id

    # check prev window workspace
    if s_container.prev:
        w_prev = w_tree.find_by_id(s_container.prev)
        if w_prev is not None and w_prev.workspace().num != s_container.workspace:
            # reset prev client
            s_container.prev = None

    # swap last_curr and recent
    if s_container.curr != window_id:
        s_container.prev = s_container.curr
        s_container.curr = window_id


# init switcher containers
for i in range(1, 10):
    switcher_containers[i] = RecentClients(workspace=i)

# subscribe "window::focus"
i3_conn_events = i3ipc.Connection()
i3_conn_events.on("window::focus", on_window_focus)

try:
    i3_conn_events.main()
except KeyboardInterrupt:
    exit()
