#!/usr/bin/python3
import setproctitle
import i3ipc
import json

PROCESS_NAME = "sway-kbdd"
setproctitle.setproctitle(PROCESS_NAME)


########################################################################################################################
# XKB watcher
class XKBWatcher:
    def __init__(self):
        self.xkb_device = '*'
        self.xkb_default_index = 0
        self.xkb_log_file = '/tmp/sway-xkb'
        self.xkb_per_app = dict()
        self.curr_window_id = None
        self.curr_xkb_layout = None

    def window_focus(self, i3, e):
        window_id = e.container.id
        self.curr_window_id = window_id

        xkb_stored_layout = self.xkb_per_app.get(window_id)
        if xkb_stored_layout is not None:
            if xkb_stored_layout != self.curr_xkb_layout:
                i3.command('input %s xkb_switch_layout %s' % (self.xkb_device, xkb_stored_layout))

        elif self.curr_xkb_layout != self.xkb_default_index:
            i3.command('input %s xkb_switch_layout %s' % (self.xkb_device, self.xkb_default_index))

    def xkb_layout(self, i3, e):
        if e.change == 'xkb_layout' and e.input:
            xkb_layout_index = e.input.xkb_active_layout_index
            if self.curr_xkb_layout != xkb_layout_index:
                xkb_layout_name = e.input.xkb_active_layout_name
                with open(self.xkb_log_file, 'a') as f:
                    f.write(xkb_layout_name + '\n')

                if xkb_layout_index is not None:
                    self.xkb_per_app[self.curr_window_id] = xkb_layout_index
                    self.curr_xkb_layout = xkb_layout_index


xkb_watcher = XKBWatcher()

########################################################################################################################

i3_conn = i3ipc.Connection()
i3_conn.on(i3ipc.Event.WINDOW_FOCUS, xkb_watcher.window_focus)
i3_conn.on(i3ipc.Event.INPUT, xkb_watcher.xkb_layout)
i3_conn.main()
