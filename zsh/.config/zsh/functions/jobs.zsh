#! /usr/bin/env zsh

function fzf-jobs() {
  local -a jobs dirs menu uniq_dirs
  local -A job2dir
  local jobline dirline choice stripped rid display target
  integer i len

  while IFS=$'\n' read -r jobline && IFS=$'\n' read -r dirline; do
    jobs+=("$jobline")
    dirline=${dirline#*\(pwd[[:space:]]*:[[:space:]]}  # strip prefix
    dirline=${dirline%\)}                              # strip trailing ")"
    dirs+=("$dirline")
  done < <(jobs -dl)

  if (( ${#jobs[@]} == 0 )); then
    echo "No background jobs to display."
    return 0
  fi

  len=${#jobs[@]}

  for (( i=1; i<=len; i++ )); do
    rid=${jobs[i]#\[}; rid=${rid%%\]*}
    job2dir[$rid]="${dirs[i]}"
  done

  uniq_dirs=("${(@u)dirs[@]}")

  for dir in "${uniq_dirs[@]}"; do
    display=${dir/#$HOME/\~}
    menu+=($'\e[1;34m'"$display"$'\e[0m')
    for (( i=1; i<=len; i++ )); do
      [[ ${dirs[i]} == "$dir" ]] && menu+=("  ${jobs[i]}")
    done
  done

  choice=$(printf '%s\n' "${menu[@]}" | fzf --ansi --no-sort) || return
  stripped=$(printf '%s' "$choice" | sed -E 's/\x1b\[[0-9;]*m//g')

  if [[ "$stripped" == '  '* ]]; then
    # job selected
    jobline=${stripped#  }
    rid=${jobline#\[}; rid=${rid%%\]*}
    target=${job2dir[$rid]}
    # expand any leading ~
    target=${target/#\~/$HOME}
    cd "$target" && fg "%$rid"
  else
    # dir selected
    target=${stripped/#\~/$HOME}
    cd "$target"
  fi
}
