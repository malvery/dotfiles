#!/usr/bin/env python3
import argparse
import json
from subprocess import run

parser = argparse.ArgumentParser()
parser.add_argument('--input', action=argparse.BooleanOptionalAction)
args = parser.parse_args()


def select_device(query, target):

    p = run(['pactl', '-f', 'json', 'list', query], capture_output=True)
    out = json.loads(p.stdout.decode())

    devices = dict()
    for item in out:
        devices[item.get("description")] = item.get("name")

    rofi_msg = "\n".join(devices.keys())
    p = run(['rofi', '-dmenu', "-p",
            f"Audio {query}"], capture_output=True, input=rofi_msg.encode())
    selected = p.stdout.decode().strip()
    pactl_target = devices.get(selected, str())

    if pactl_target:
        run(['pactl', target, pactl_target])


if args.input:
    select_device(query="sources", target="set-default-source")
else:
    select_device(query="sinks", target="set-default-sink")
