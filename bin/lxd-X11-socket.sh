#!/bin/bash
index=${DISPLAY#*:}
dest=/tmp/.X11-unix/Xc
# dest=${XDG_RUNTIME_DIR}/Xc


if test -e ${dest}
then
    rm ${dest}
fi

ln -sf /tmp/.X11-unix/X${index} ${dest}

# if [ -n "${XAUTHORITY}" ]
# then
#     ln -sf ${XAUTHORITY} ${XDG_RUNTIME_DIR}/xauth_c
# else
#     touch ${XDG_RUNTIME_DIR}/xauth_c
# fi
