#!/bin/bash

# http://superuser.com/questions/181517/how-to-execute-a-command-whenever-a-file-changes

while true; do
  change=$(inotifywait -e close_write,moved_to,create -r /home/guda/scaffold_pico)
  change=${change#./ * }
  # if [ "$change" = "myfile.py" ]; then ./myfile.py; fi

  # exec 3>&1
  # output=$( asaa 2>&1 1>&3 )
  # exec 3>&-

  ruby -I ~/scaffold_pico/lib ~/scaffold_pico/bin/scaffold_pico.rb -d -m Assistant -n administation/pencho --fields email:string first_name:string last_name:string terms:string


  if [ $? -ne 0 ]; then
    notify-send "Failed"
  fi


done