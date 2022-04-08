#!/usr/bin/python3
import setproctitle
import signal
import time
import os
import gi
gi.require_version("Wnck", "3.0")  # noqa: E261
from gi.repository import GLib, Wnck


PROCESS_NAME = "x11-tags-helper"
PID_CURR = os.getpid()
PID_PATH = "%s/%s.pid" % (os.getenv("XDG_RUNTIME_DIR", "/tmp"), PROCESS_NAME)


setproctitle.setproctitle(PROCESS_NAME)
with open(PID_PATH, "w") as pid_file:
    pid_file.write(str(PID_CURR))


###############################################################################

x11_screen = Wnck.Screen.get_default()
x11_screen.force_update()
x11_recent_space = x11_screen.get_active_workspace()


def recent_workspace():
    if x11_recent_space:
        x11_recent_space.activate(0)


def next_workspace(reverse=False):
    curr_w = x11_screen.get_active_workspace().get_number()
    windows = x11_screen.get_windows()
    active_w = set()
    for w in windows:
        _workspace = w.get_workspace()
        if _workspace and not w.is_minimized():
            active_w.add(_workspace.get_number())

    active_w = sorted(active_w, reverse=reverse)
    for s in active_w:
        if (s > curr_w and not reverse) or (s < curr_w and reverse):
            x11_screen.get_workspace(s).activate(0)
            break


def on_workspace_changed(screen, previously_active_space):
    global x11_recent_space
    x11_recent_space = previously_active_space


def recent_window():
    current = x11_screen.get_active_workspace().get_number()
    stacked = x11_screen.get_windows_stacked()

    windows = list()
    for w in stacked:
        workspace = w.get_workspace()
        if workspace and workspace.get_number() == current:
            windows.append(w)

    recent_list = windows[-2:-1]
    if recent_list:
        recent_list[0].activate(int(time.time()))

###############################################################################

x11_screen.connect("active-workspace-changed", on_workspace_changed)
signal.signal(signal.SIGURG, lambda *args: recent_workspace())
signal.signal(signal.SIGUSR1, lambda *args: next_workspace())
signal.signal(signal.SIGUSR2, lambda *args: next_workspace(reverse=True))
# signal.signal(signal.SIGCHLD, lambda *args: recent_window())
signal.signal(signal.SIGTERM, lambda *args: exit())


loop = GLib.MainLoop(None)
loop.run()
