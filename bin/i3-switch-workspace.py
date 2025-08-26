#!/usr/bin/python3
import subprocess
import signal
import i3ipc
import os

PROCESS_NAME = "i3ipc-switch-workspace"
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


###############################################################################

i3 = i3ipc.Connection()


# noinspection PyPep8Naming
def on_signal(signalNumber, frame):
    if signalNumber in (10, 12):
        w_list = i3.get_workspaces()

        w_curr = None
        for w in w_list:
            if w.visible:
                w_curr = w.num
                break

        if w_curr:
            w_next = w_curr + 1 if signalNumber == 10 else w_curr - 1
            if 1 <= w_next <= 9:
                i3.command("workspace %s" % w_next)

    elif signalNumber == 2:
        os.remove(PID_PATH)
        exit()


signal.signal(signal.SIGUSR1, on_signal)
signal.signal(signal.SIGUSR2, on_signal)
signal.signal(signal.SIGINT, on_signal)

i3.main()
