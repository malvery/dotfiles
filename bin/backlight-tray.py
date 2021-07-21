#!/usr/bin/env python3
import signal
import gi
gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
gi.require_version('Notify', '0.7')
from gi.repository import Gtk, Gdk, AppIndicator3, Notify  # noqa E261

###############################################################################

APP_ID = 'backlight-tray'
APP_ICON = 'dialog-information'
SYS_CLASS = '/sys/class/backlight'
SYS_DEVICE = 'intel_backlight'

BRIGHTNESS_MIN = 2
BRIGHTNESS_MAX = 100
BRIGHTNESS_STEP = 2

SCROLL_DIVIDE = 5

signal.signal(signal.SIGINT, signal.SIG_DFL)

###############################################################################


class BrightnessControl:

    def __init__(self):
        with open(f'{SYS_CLASS}/{SYS_DEVICE}/max_brightness', 'r') as f:
            max_brightness = int(f.read().strip())

        self.__control_path = f'{SYS_CLASS}/{SYS_DEVICE}/brightness'
        self.__modifier = 100 / max_brightness

    def __raw_to_percent(self, value):
        return round(value * self.__modifier)

    def __percent_to_raw(self, value):
        return round(value / self.__modifier)

    @staticmethod
    def __restrict(value):
        if value < BRIGHTNESS_MIN:
            return BRIGHTNESS_MIN
        elif value > BRIGHTNESS_MAX:
            return BRIGHTNESS_MAX
        else:
            return value

    def get(self):
        with open(self.__control_path, 'r') as f:
            return self.__raw_to_percent(value=int(f.read().strip()))

    def set(self, value):
        value = self.__restrict(value=value)
        with open(self.__control_path, 'w') as f:
            value = self.__percent_to_raw(value=value)
            f.write(str(value))

    def inc(self, step):
        with open(self.__control_path, 'r+') as f:
            current = round(int(f.read().strip()) * self.__modifier)
            new = self.__restrict(value=current + step)
            if new != current:
                f.write(str(self.__percent_to_raw(new)))

            return new


brightness = BrightnessControl()

###############################################################################


class ScrollEvents:
    def __init__(self, notification):
        self._directions = [
            Gdk.ScrollDirection.UP,
            Gdk.ScrollDirection.DOWN
        ]
        self._events_count = 0
        self._notify = notification

    def event(self, indicator, steps, direction):
        if direction in self._directions:
            self._events_count += 1
            if self._events_count >= SCROLL_DIVIDE:
                step_mod = 1 if direction == Gdk.ScrollDirection.UP else -1
                new_value = brightness.inc(step=BRIGHTNESS_STEP * step_mod)

                self._notify.update(f'Brightness: {new_value}%')
                self._notify.show()

                indicator.set_title(f'Brightness: {new_value}%')

                self._events_count = 0


###############################################################################


def make_menu():
    """ Set up the menu """
    menu = Gtk.Menu()

    item_exit = Gtk.MenuItem()
    item_exit.set_label("Exit")
    item_exit.connect('activate', Gtk.main_quit)
    item_exit.show()

    menu.append(item_exit)
    menu.show()

    return menu


if __name__ == "__main__":
    Notify.init(APP_ID)
    scroll = ScrollEvents(
        notification=Notify.Notification.new("Brightness: None")
    )
    ai = AppIndicator3.Indicator.new(
        id=APP_ID,
        icon_name=APP_ICON,
        category=AppIndicator3.IndicatorCategory.HARDWARE
    )

    ai.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
    ai.set_title(f'Brightness: {brightness.get()}%')
    ai.set_menu(make_menu())
    ai.connect("scroll-event", scroll.event)
    Gtk.main()
