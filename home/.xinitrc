#ck-launch-session awesome
/home/malvery/bin/bg_random_set.sh &
urxvt -e ~/bin/tmux.sh &
redshift -l 56.79:60.63 -m vidmode -t 5500:4000 &
xsetroot -cursor_name left_ptr &
exec awesome
