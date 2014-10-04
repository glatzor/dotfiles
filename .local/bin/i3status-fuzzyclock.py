#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is a python reimplementation of:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.pl
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
# In its current version it will display the cpu frequency governor, but you
# are free to change it to display whatever you like, see the comment in the
# source code below.
#
# © 2012 Valentin Haenel <valentin.haenel@gmx.de>
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License (WTFPL), Version
# 2, as published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

import json
import sys
from time import localtime, strftime

LOOKUP_MINUTES=[
    ' ',
    'kurz nach',
    'kurz vor viertel',
    'viertel',
    'kurz nach viertel',
    'kurz vor halb',
    'halb',
    'kurz nach halb',
    'kurz vor dreiviertel',
    'dreiviertel',
    'kurz nach dreiviertel',
    'kurz vor',
]
LOOKUP_HOUR=[
    'mitternacht',
    'eins',
    'zwei',
    'drei',
    'vier',
    'fünf',
    'sechs',
    'sieben',
    'acht',
    'neun',
    'zehn',
    'elf',
    'zwölf',
    'eins',
]

def get_fuzzy_time():
    """Return the fuzzy time"""
    # Get minutes
    time_min = strftime("%M", localtime())
    # Get hour, as int
    time_hour = int(strftime("%H", localtime()))

    # round minutes to nearest 5, return as int
    time_min = int(round(float(time_min) * 2, -1) / 2)

    # Make it 12 hour, rather than 24
    if time_hour >= 13:
        time_hour = time_hour - 12

    # Get the O'clock for if it's around 0mins past
    if time_min == 0:
        return "genau " + LOOKUP_HOUR[time_hour]
    elif time_min == 60:
        return "genau " + LOOKUP_HOUR[time_hour + 1]
    elif time_min <= 5:
        return LOOKUP_MINUTES[time_min / 5] + " " + LOOKUP_HOUR[time_hour]
    else:
        return LOOKUP_MINUTES[time_min / 5] + " " + LOOKUP_HOUR[time_hour + 1]

def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere
        # CHANGE THIS LINE TO INSERT SOMETHING ELSE
        j.append({'full_text' : '%s' % get_fuzzy_time(), 'name' : 'fuzzy_clock'})
        # and echo back new encoded json
        print_line(prefix+json.dumps(j))
