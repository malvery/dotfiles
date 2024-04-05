#!/usr/bin/env python3
from subprocess import run
import argparse
import json
import time


parser = argparse.ArgumentParser()
parser.add_argument('--switch', action=argparse.BooleanOptionalAction)
parser.add_argument('--py3status', action=argparse.BooleanOptionalAction)
args = parser.parse_args()


def run_cmd(cmd):
    p = run(cmd, capture_output=True)
    return p.stdout.decode().strip()


def error(msg):
    if args.switch:
        raise AttributeError(msg)

    exit(0)


DESIRED_PROFILE = [
    "a2dp-sink",
    "headset-head-unit-msbc"
]

PROFILE_NAME_MAP = {
    "a2dp-sink": "A2DP",
    "headset-head-unit-msbc": "mSBC"
}

COLOR = "#FE8600"

default_sink = run_cmd(["pactl", "get-default-sink"]).split(".")
system = default_sink[0]

if system != "bluez_output":
    error("Unable to find default bluez sink")

_id = default_sink[1]

card_id = f"bluez_card.{_id}"
card_all = json.loads(
    run_cmd([
        "pactl", "-f", "json", "list", "cards"
    ])
)

card_info = dict()
for i in card_all:
    if i.get("name") == card_id:
        card_info = i
        break

if card_info is None:
    error(f"Unable to find card {card_id}")

active_profile = card_info.get("active_profile", str())

if args.switch:
    DESIRED_PROFILE.remove(active_profile)
    run_cmd([
        "pactl", "set-card-profile", card_id, DESIRED_PROFILE[0]
    ])

    if args.py3status:
        time.sleep(1)
        out = run_cmd([
            "pkill", "-USR1", "py3status"
        ])

else:
    if active_profile:
        pretty_name = PROFILE_NAME_MAP.get(active_profile, active_profile)
        print(pretty_name)
        # print(COLOR)

    exit(0)
