#!/usr/bin/env fish

function run-app
    set apps_list (osascript -e 'set appNames to ""
tell application "Finder"
    set installedApps to name of every application file of (path to applications folder)
end tell
return appNames')

  # TODO: fix app names with a space
  echo "$apps_list" | tr "," "\n" | sed 's/\.app$//' | awk '{$1=$1; print}' | fzf | xargs open -a
end
