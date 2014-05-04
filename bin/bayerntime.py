#!/usr/bin/python
# -*- coding: utf-8 -*-

from time import localtime, strftime

minLookup=[
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
hourLookup=[
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

#Get minutes
time_min = strftime("%M", localtime())
#Get hour, as int
time_hour = int(strftime("%H", localtime()))

#round minutes to nearest 5, return as int
time_min = int(round(float(time_min)*2,-1)/2)

#Make it 12 hour, rather than 24
if time_hour >= 13:
    time_hour = time_hour - 12

#Get the O'clock for if it's around 0mins past
if time_min == 0:
    print "genau " + hourLookup[time_hour]
elif time_min == 60:
    print "genau " + hourLookup[time_hour+1]
elif time_min <= 5:
    print minLookup[time_min/5] + " " + hourLookup[time_hour]
else:
    print minLookup[time_min/5] + " " + hourLookup[time_hour+1]
