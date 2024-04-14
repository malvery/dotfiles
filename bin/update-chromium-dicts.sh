#!/bin/bash
set -e

bdic=(en-US-10-1.bdic ru-RU-3-0.bdic)
# dict=${HOME}/.var/app/com.github.Eloston.UngoogledChromium/config/chromium/Dictionaries/
dict=${HOME}/.config/chromium/Dictionaries/

for i in "${bdic[@]}"
do
    curl -L https://chromium.googlesource.com/chromium/deps/hunspell_dictionaries/+/refs/heads/main/${i}?format=TEXT -o /tmp/${i}
    base64 -d /tmp/${i} > ${dict}/${i}
    rm /tmp/${i}

    echo "Downloaded: ${i}"
done

echo "Well done!"
