#!/usr/bin/python3
import setproctitle
import subprocess
import signal
import gi
gi.require_version('Wnck', '3.0')
from gi.repository import GLib, Wnck
from ewmh import EWMH


################################################################################


class RecentSpace:
    id = 0


RECENT_SPACE = RecentSpace()
PROCESS_NAME = "wm-recent-tag"
ewmh = EWMH()


def kill_process():
    pid_list = subprocess.check_output([
        '/bin/bash', '-c', 'pidof %s || true' % PROCESS_NAME
    ]).decode('utf-8')
    pid_list = pid_list.replace('\n', '').split(' ')

    for pid in pid_list:
        if pid:
            subprocess.call(['kill', pid])


kill_process()
setproctitle.setproctitle(PROCESS_NAME)


################################################################################

def receiveSignal(signalNumber, frame):
    subprocess.call(['wmctrl', '-s', str(RECENT_SPACE.id)])
    ewmh.setCurrentDesktop(RECENT_SPACE.id)
    ewmh.display.flush()


def receiveExit(signalNumber, frame):
    kill_process()


signal.signal(signal.SIGUSR1, receiveSignal)
signal.signal(signal.SIGINT, receiveExit)

################################################################################


def on_workspace_changed(screen, previously_active_space):
    attr = getattr(previously_active_space, "get_number", None)
    if attr:
        # print("WORKSPACE: %s" % RECENT_SPACE.id)
        RECENT_SPACE.id = attr()


screen = Wnck.Screen.get_default()
screen.connect('active-workspace-changed', on_workspace_changed)

loop = GLib.MainLoop(None)
loop.run()

