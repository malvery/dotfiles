#!/usr/bin/python3
import setproctitle
import i3ipc
import json
# noinspection PyProtectedMember
from i3ipc._private.types import MessageType

PROCESS_NAME = "sway-kbdd"
setproctitle.setproctitle(PROCESS_NAME)


########################################################################################################################
# SOCK client
class Connection(i3ipc.Connection):
    def __init__(self):
        super().__init__()
        self.__raw_events = dict()

    def _subscribe(self, events):
        try:
            self._sub_lock.acquire()
            data = self._ipc_send(
                self._sub_socket,
                MessageType.SUBSCRIBE,
                json.dumps(list(self.__raw_events.values()))
            )
            data = json.loads(data)
            assert data.get('success') is True
        finally:
            self._sub_lock.release()

        super()._subscribe(events=events)

    def _ipc_recv(self, sock):
        data, msg_type = super()._ipc_recv(self._sub_socket)
        msg_type_hex = hex(msg_type)
        if msg_type_hex in self.__raw_events:
            self._pubsub.emit(self.__raw_events[msg_type_hex], json.loads(data))

        return data, msg_type

    def subscribe_raw(self, name, hex_code, handler):
        self.__raw_events[hex_code] = name
        self._pubsub.subscribe(name, handler)


########################################################################################################################
# XKB watcher
class XKBWatcher:
    def __init__(self):
        self._i3_conn = i3ipc.Connection()
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
        if e.get('change') == 'xkb_layout' and e.get('input'):
            xkb_layout_index = e['input'].get('xkb_active_layout_index')
            if self.curr_xkb_layout != xkb_layout_index:
                xkb_layout_name = e['input'].get('xkb_active_layout_name')
                with open(self.xkb_log_file, 'a') as f:
                    f.write(xkb_layout_name + '\n')

                if xkb_layout_index is not None:
                    self.xkb_per_app[self.curr_window_id] = xkb_layout_index
                    self.curr_xkb_layout = xkb_layout_index


xkb_watcher = XKBWatcher()

########################################################################################################################

i3_conn = Connection()
i3_conn.subscribe_raw(name='input', hex_code='0x80000015', handler=xkb_watcher.xkb_layout)
# noinspection PyTypeChecker
i3_conn.on(i3ipc.Event.WINDOW_FOCUS, xkb_watcher.window_focus)
i3_conn.main()
