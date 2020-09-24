import os

SYS_CLASS = '/sys/class/backlight'
SYS_DEVICE = 'intel_backlight'

BRIGHTNESS_MIN = 2
BRIGHTNESS_MAX = 100
BRIGHTNESS_STEP = 2


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


class SwayIdleControl:
    def __init__(self):
        self.__block_path = '/tmp/swayidle-block'

    def is_blocked(self):
        try:
            with open(self.__block_path, 'r'):
                return True

        except FileNotFoundError:
            return False

    def toggle(self):
        if self.is_blocked():
            os.remove(self.__block_path)
        else:
            with open(self.__block_path, 'a'):
                os.utime(self.__block_path, None)


class Py3status:
    __led_control = BrightnessControl()
    __idle_control = SwayIdleControl()
    cache_timeout = 5
    format = "LED: {level}%"

    def backlight(self):
        level = self.__led_control.get()

        response = {
            "cached_until": self.py3.time_in(self.cache_timeout),
            "full_text": self.py3.safe_format(self.format, {"level": level}),
            "urgent": self.__idle_control.is_blocked()
        }

        if level >= 75:
            response['color'] = self.py3.COLOR_BAD
        elif level >= 40:
            response['color'] = self.py3.COLOR_DEGRADED
        return response

    def on_click(self, event):
        button = event["button"]
        if button == 4:
            self.__led_control.inc(BRIGHTNESS_STEP)

        elif button == 5:
            self.__led_control.inc(BRIGHTNESS_STEP * -1)

        elif button == 3:
            self.py3.command_run("pkill -USR1 '^gammastep$'")

        elif button == 2:
            self.__idle_control.toggle()
