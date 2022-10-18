#!/usr/bin/env python3
from subprocess import run


def get_history():
    p = run(['gpaste-client', '--oneline'], capture_output=True)
    out = p.stdout.decode().split("\n")

    history = [x.split(":", 1)[1] for x in out if x]
    return history


history = get_history()
dmenu_msg = "\n".join([f"{i:02}: {x}" for i, x in enumerate(history)])

p = run(
    ['bemenu', '-l 20', '-p clipboard'],
    capture_output=True,
    input=dmenu_msg.encode()
)
selected = p.stdout.decode().split(":", 1)

print(selected)
run(['gpaste-client', '--use-index', 'select', selected[0]])
