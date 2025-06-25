#!/usr/bin/env python3
import argparse
import json
from subprocess import run

parser = argparse.ArgumentParser()
parser.add_argument('--input', action=argparse.BooleanOptionalAction)
args = parser.parse_args()


def select_device(query):
    p = run(['pactl', f"get-default-{query}"], capture_output=True)
    curr = p.stdout.decode().strip()
    curr_desc = None

    p = run(['pactl', '-f', 'json', 'list', f"{query}s"], capture_output=True)
    out = json.loads(p.stdout.decode())

    devices = dict()
    for item in out:
        name = item.get("name")
        desc = item.get("description")

        devices[desc] = name
        if name == curr:
            curr_desc = desc

    msg = "\n".join(devices.keys())
    p = run(
        ['bemenu', "-l 10", "-p", f"{query.upper()} [{curr_desc}]:"],
        capture_output=True,
        input=msg.encode()
    )
    selected = p.stdout.decode().strip()
    pactl_target = devices.get(selected, str())

    if pactl_target:
        run(['pactl', f"set-default-{query}", pactl_target])


select_device(query="source" if args.input else "sink")
