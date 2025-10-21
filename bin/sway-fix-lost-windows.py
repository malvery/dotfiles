#!/usr/bin/env python3
from collections import Counter
import i3ipc
import json


i3 = i3ipc.Connection()


def find_duplicates(input_list):
    counts = Counter(input_list)
    duplicates = [item for item, count in counts.items() if count > 1]
    return duplicates


workspaces = i3.get_tree().workspaces()
duplicates = find_duplicates([x.num for x in workspaces])
broken = dict()


for w in workspaces:
    if w.num in duplicates:
        broken.setdefault(w.num, list()).append(w)


for _, b in broken.items():
    sorted(b, key=lambda x: x.id, reverse=True)
    target = b[0].num

    for w in b[1:]:
        for leave in w.leaves():
            leave.command(f"move to workspace {target}")
