#!/usr/bin/env python3
from subprocess import run
import os

DMENU_ARGS = os.environ.get("DMENU_ARGS", str())


def get_history():
    p = run(["gpaste-client", "--oneline"], capture_output=True)
    out = p.stdout.decode().split("\n")

    history = [x.split(":", 1)[1] for x in out if x]
    return history


history = get_history()

dmenu_msg = "\n".join([f"{i:02}: {x}" for i, x in enumerate(history)])
dmenu_command = f"rofi -dmenu {DMENU_ARGS} -l 20 -p clipboard"

p = run(
    dmenu_command.split(),
    capture_output=True,
    text=True,
    check=False,
    encoding="UTF-8",
    input=dmenu_msg,
)
selected = p.stdout.split(":", 1)

print(selected)
run(["gpaste-client", "--use-index", "select", selected[0]])
