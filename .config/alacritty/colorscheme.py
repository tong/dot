#!/usr/bin/env python

import os
import sys
import random
import re
import yaml

CONFIG_FILE_NAME = "colorschemes.yml"
CONFIG_FILE_DIR = os.path.expanduser("~/.config/alacritty/")
CONFIG_FILE_PATH = os.path.join(CONFIG_FILE_DIR, CONFIG_FILE_NAME)
COLOR_SCHEME_LINE_SEARCH = "colors: \*(\S+)"
COLOR_SCHEME_LINE_TEMPLATE = "colors: *{}\n"

class ColorSchemes:

    def __init__(self):
        with open(CONFIG_FILE_PATH, "r") as config_file:
            self.config = yaml.safe_load(config_file)
            config_file.seek(0)
            self.lines = config_file.readlines()
        self.colors_line_index = -1
        for i, line in enumerate(self.lines):
            match = re.search(COLOR_SCHEME_LINE_SEARCH, line)
            if match is not None:
                self.current_color_scheme = match.group(1)
                self.colors_line_index = i
        self.available_color_schemes = list(self.config["schemes"].keys())
        self.color_scheme_index = self.available_color_schemes.index(self.current_color_scheme)

    def write_config(self):
        with open(CONFIG_FILE_PATH, "w") as config_file:
            for line in self.lines: config_file.write(line)

    def set_next(self):
        self.color_scheme_index = (self.color_scheme_index + 1) % len(self.available_color_schemes)
        self.lines[self.colors_line_index] = COLOR_SCHEME_LINE_TEMPLATE.format(self.available_color_schemes[self.color_scheme_index])
        self.write_config()

    def set_prev(self):
        self.color_scheme_index = (self.color_scheme_index - 1) % len(self.available_color_schemes)
        self.lines[self.colors_line_index] = COLOR_SCHEME_LINE_TEMPLATE.format(self.available_color_schemes[self.color_scheme_index])
        self.write_config()

    def set_random(self):
        self.color_scheme_index = random.randint(0, len(self.available_color_schemes))
        self.lines[self.colors_line_index] = COLOR_SCHEME_LINE_TEMPLATE.format(self.available_color_schemes[self.color_scheme_index])
        self.write_config()

    def set_theme(self,theme:str):
        try:
            index = self.available_color_schemes.index(theme)
        except:
            print('theme not found')
            exit(1)
        self.current_color_scheme = theme
        self.color_scheme_index = self.available_color_schemes.index(self.current_color_scheme)
        self.lines[self.colors_line_index] = COLOR_SCHEME_LINE_TEMPLATE.format(self.available_color_schemes[self.color_scheme_index])
        self.write_config()

cs = ColorSchemes()
cmd = sys.argv.pop()
if cmd == "next": cs.set_next()
elif cmd == "prev": cs.set_prev()
elif cmd == "random": cs.set_random()
else: cs.set_theme(cmd)
