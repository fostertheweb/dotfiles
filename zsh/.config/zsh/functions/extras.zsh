#!/usr/bin/env zsh

function ttv() {
  local url="twitch.tv/$1"
  streamlink $url best --stream-url --twitch-disable-ads | xargs open -a "QuickTime Player.app"
  open -a Safari "https://$url/chat"
}

function run-zsh-fn() {
  local user_funcs=()
  local func

  for func in ${(k)functions}; do
    if [[ "$func" != _* ]]; then
      user_funcs+="$func"
    fi
  done

  local selected
  selected=$(printf "%s\n" "${user_funcs[@]}" | sort | fzf --prompt="Run Command: ")

  if [[ -n "$selected" ]]; then
    $selected
  fi
}

function run-app() {
apps_list=$(osascript <<EOF
set appNames to ""
tell application "Finder"
    set installedApps to name of every application file of (path to applications folder)
end tell
return installedApps
EOF
)

  # TODO: fix app names with a space
  echo "$apps_list" | tr "," "\n" | sed 's/\.app$//' | awk '{$1=$1; print}' | fzf | xargs open -a
}

function prefix-api-key() {
  local anthropic="$(op read 'op://Private/Anthropic API/credential')"
  local openai="$(op read 'op://Private/OpenAI API/credential')"
  local deepseek="$(op read 'op://Private/DeepSeek API/credential')"
  OPENAI_API_KEY=$openai ANTHROPIC_API_KEY=$anthropic DEEPSEEK_API_KEY=$deepseek $1
}

