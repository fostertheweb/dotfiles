#! /usr/bin/env zsh

function fzf-jobs() {
  local -a jobs dirs menu uniq_dirs
  local -A job2dir
  local jobline dirline choice stripped rid display target
  integer i len

  # 1) Read jobs -dl two lines at a time
  while IFS=$'\n' read -r jobline && IFS=$'\n' read -r dirline; do
    jobs+=("$jobline")
    dirline=${dirline#*\(pwd[[:space:]]*:[[:space:]]}  # strip prefix
    dirline=${dirline%\)}                              # strip trailing ")"
    dirs+=("$dirline")
  done < <(jobs -dl)

  # 1a) Bail if nothing to show
  if (( ${#jobs[@]} == 0 )); then
    echo "No background jobs to display."
    return 0
  fi

  len=${#jobs[@]}

  # 2) Map job‑ID → start dir
  for (( i=1; i<=len; i++ )); do
    rid=${jobs[i]#\[}; rid=${rid%%\]*}
    job2dir[$rid]="${dirs[i]}"
  done

  # 3) Unique dirs (preserve order)
  uniq_dirs=("${(@u)dirs[@]}")

  # 4) Build fzf menu: blue dirs + indented jobs
  for dir in "${uniq_dirs[@]}"; do
    display=${dir/#$HOME/\~}
    menu+=($'\e[1;34m'"$display"$'\e[0m')
    for (( i=1; i<=len; i++ )); do
      [[ ${dirs[i]} == "$dir" ]] && menu+=("  ${jobs[i]}")
    done
  done

  # 5) Run fzf
  choice=$(printf '%s\n' "${menu[@]}" | fzf --ansi --no-sort) || return

  # 6) Strip ANSI
  stripped=$(printf '%s' "$choice" | sed -E 's/\x1b\[[0-9;]*m//g')

  # 7) Handle selection
  if [[ "$stripped" == '  '* ]]; then
    # job selected
    jobline=${stripped#  }
    rid=${jobline#\[}; rid=${rid%%\]*}
    target=${job2dir[$rid]}
    # expand any leading ~ just in case
    target=${target/#\~/$HOME}
    cd "$target" && fg "%$rid"
  else
    # dir selected
    target=${stripped/#\~/$HOME}
    cd "$target"
  fi
}

# ctrl-t
# List current sessions and go to
bindkey -s '^T' 'fzf-jobs^M'

# cmd-o
# Create "session"
bindkey -s '\eo' 'cd $(zoxide query --interactive)^M'
