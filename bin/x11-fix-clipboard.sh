#!/bin/bash

while clipnotify; do
    xclip -selection clipboard -o | xclip -selection clipboard -i
done

