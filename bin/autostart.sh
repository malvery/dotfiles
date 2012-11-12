#~/bin/bg_random_set.sh &
urxvt -e ~/bin/tmux.sh &
redshift -l 56.79:60.63 -m vidmode -t 5500:4000 &
xsetroot -cursor_name left_ptr &
deluge-gtk &
chromium &
xfce4-power-manager &
nm-applet &
alsa-tray &
parcellite &

while true;
do
  awsetbg -r /home/malvery/wallpapers/ 
  sleep 20m
done &
