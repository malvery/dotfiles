#!/usr/bin/python3

import os
import sys
import subprocess
import argparse

parser = argparse.ArgumentParser(description='script to convert flac to mp3')
parser.add_argument('--dir-in', help='in dir', required=True)
parser.add_argument('--dir-out', help='out dir', required=True)

args = parser.parse_args()

dir_in = args.dir_in
dir_out = args.dir_out

for root, sub_dirs, files in os.walk(dir_in):
    if files:
        create_dir = dir_out + root.replace(dir_in, '')
        subprocess.call(['mkdir', '-p', create_dir])

        for filename in files:
            file_in = root + '/' + filename
            file_out = root.replace(dir_in, dir_out) + '/' + filename.replace('flac', 'mp3')

            subprocess.check_call(
                '/usr/bin/cat "%s" | /usr/bin/flac -d -c - | /usr/bin/lame --cbr -b 320 - - | /usr/bin/cat - > "%s"' %
                (file_in, file_out),
                shell=True
            )
