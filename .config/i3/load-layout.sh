#!/bin/sh
i3-msg 'workspace 4:dpool; append_layout /home/renate/.config/i3/layouts/dpool.json'
i3-msg 'workspace 3:chat; append_layout /home/renate/.config/i3/layouts/chat.json'
i3-msg 'workspace 2:www; append_layout /home/renate/.config/i3/layouts/www.json'
i3-msg 'workspace 1:mail; append_layout /home/renate/.config/i3/layouts/mail.json'

# Start some useful applications
i3-msg 'exec --no-startup-id urxvt -e mutt'
i3-msg 'exec --no-startup-id urxvt -e irssi'
i3-msg 'exec --no-startup-id urxvt -e profanity'
i3-msg 'exec --no-startup-id firefox'
i3-msg 'exec --no-startup-id firefox-dpool'
