#!/usr/bin/env python3
from subprocess import run
import argparse
import json


parser = argparse.ArgumentParser()
parser.add_argument('--switch', action=argparse.BooleanOptionalAction)
parser.add_argument('--reconnect', action=argparse.BooleanOptionalAction)
parser.add_argument('--py3status', action=argparse.BooleanOptionalAction)
parser.add_argument('--waybar', action=argparse.BooleanOptionalAction)
args = parser.parse_args()


def run_cmd(cmd):
    p = run(cmd, capture_output=True)
    return p.stdout.decode().strip()


def error(msg):
    if args.switch:
        raise AttributeError(msg)

    exit(0)


COLOR = "#FE8600"

#####################################################################
# Get audio server info

info = json.loads(
    run_cmd([
        "pactl", "-f", "json", "info"
    ])
)

IS_PULSE = True if info["server_name"] == "pulseaudio" else False

#####################################################################
# Get device info

default_sink = run_cmd(["pactl", "get-default-sink"]).split(".")
system = default_sink[0]

if system not in ["bluez_output", "bluez_sink"]:
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

#####################################################################
# Pulseaudio or PipeWire

if IS_PULSE:
    bluez_id = card_info["properties"]["device.string"]
    bluez_alias = card_info["properties"]["bluez.alias"]

    DESIRED_PROFILE = [
        "a2dp_sink",
        "handsfree_head_unit"
    ]

    PROFILE_NAME_MAP = {
        "a2dp_sink": "A2DP",
        "handsfree_head_unit": "mSBC"
    }

else:
    bluez_id = card_info["properties"]["api.bluez5.address"]
    bluez_alias = card_info["properties"]["device.alias"]

    DESIRED_PROFILE = [
        "a2dp-sink",
        "headset-head-unit"
    ]

    PROFILE_NAME_MAP = {
        "a2dp-sink": "A2DP",
        "headset-head-unit": "mSBC"
    }

#####################################################################
# Switch profile

if args.switch:
    DESIRED_PROFILE.remove(active_profile)
    target = DESIRED_PROFILE[0]
    pretty = PROFILE_NAME_MAP.get(target, target)

    run_cmd([
        "notify-send", "Bluetooth Headset",
        f"Switching profile to the {pretty}: {bluez_alias}"
    ])

    run_cmd([
        "pactl", "set-card-profile", card_id, target
    ])


elif args.reconnect:
    run_cmd([
        "notify-send", "Bluetooth Headset",
        f"Reconnecting headset: {bluez_alias}"
    ])

    run_cmd(["bluetoothctl", "disconnect", bluez_id])
    run_cmd(["bluetoothctl", "connect", bluez_id])

#####################################################################
# Show current profile

if active_profile:
    pretty_name = PROFILE_NAME_MAP.get(active_profile, active_profile)
    print(pretty_name)

    if args.py3status:
        out = run_cmd(["pkill", "-USR1", "py3status"])

    elif args.waybar:
        out = run_cmd(["pkill", "-SIGRTMIN+20", "waybar"])
