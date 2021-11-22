#!/usr/bin/python3
import setproctitle
import subprocess
import signal
import i3ipc
import os
import logging
from dataclasses import dataclass


logger = logging.getLogger()
logger.setLevel(logging.INFO)

PROCESS_NAME = "i3ipc-recent-window"
PID_CURR = os.getpid()
PID_PATH = "%s/%s.pid" % (os.getenv("XDG_RUNTIME_DIR", "/tmp"), PROCESS_NAME)

###############################################################################

# send SIGNTERM for another processes
pid_list = subprocess.check_output(
    ["/bin/bash", "-c", "pidof %s || true" % PROCESS_NAME]
).decode("utf-8")
pid_list = pid_list.replace("\n", "").split(" ")

for pid in pid_list:
    if pid:
        subprocess.call(["kill", pid])

with open(PID_PATH, "w") as pid_file:
    pid_file.write(str(PID_CURR))

setproctitle.setproctitle(PROCESS_NAME)

###############################################################################


@dataclass
class Recent:
    curr: int = None
    last: int = None


class Watcher(object):
    _workspace = 1
    _recent = dict(tuple((x, Recent()) for x in range(10)))

    @classmethod
    def workspace_focus(cls, _, e):
        cls._workspace = e.current.num

    @classmethod
    def window_focus(cls, _, e):
        logger.debug(f"{e.container.window_title} {e.container.id}")
        workspace = cls._workspace

        if e.container.floating != "user_on":
            if cls._recent[workspace].curr != e.container.id:
                cls._recent[workspace].last = cls._recent[workspace].curr
                cls._recent[workspace].curr = e.container.id

    @classmethod
    def focus_to_recent(cls, i3):
        command = '[con_id="%s"] focus' % cls._recent[cls._workspace].last
        result = i3.command(command)
        if isinstance(result, list) and result:
            if (
                isinstance(result[0], i3ipc.CommandReply)
                and getattr(result[0], "success") is True
            ):
                return True

        i3.command("focus right")


###############################################################################

i3_conn_commands = i3ipc.Connection()


# noinspection PyPep8Naming
def on_signal(signalNumber, frame):
    if signalNumber == 10:
        Watcher.focus_to_recent(i3=i3_conn_commands)

    elif signalNumber == 2:
        os.remove(PID_PATH)
        exit()


signal.signal(signal.SIGUSR1, on_signal)
signal.signal(signal.SIGINT, on_signal)

i3_conn_events = i3ipc.Connection()
i3_conn_events.on(i3ipc.Event.WORKSPACE_FOCUS, Watcher.workspace_focus)
i3_conn_events.on(i3ipc.Event.WINDOW_FOCUS, Watcher.window_focus)
i3_conn_events.main()
