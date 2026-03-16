#!/usr/bin/env zsh

function origin-status() {
  if [[ -n $1 ]]; then
    z $1
  fi

  git fetch origin

  local trunk=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
  read -r ahead behind <<<$(git rev-list --left-right --count HEAD...origin/$trunk)
  local output="$behind behind, $ahead ahead"
  local merge_dry_run=$(git merge --no-commit --no-ff --dry-run origin/main 2>&1)

  if echo "$merge_dry_run" | grep -q 'CONFLICT'; then
    output="$output with conflicts"
  fi

  echo $output
}

function pull-requests() {
  local repo_name="$1"
  local pr_number="$2"
  local worktree=$(get-or-create-worktree)

  cd "$worktree"

  gh pr checkout "$pr_number" 2>/dev/null || {
    git fetch origin "pull/$pr_number/head:pr-$pr_number"
    git checkout "pr-$pr_number" 2>/dev/null || git checkout -b "pr-$pr_number"
  }

  local repo_full

  if [[ "$repo_name" == *"/"* ]]; then
    repo_full="$repo_name"
  else
    repo_full=$(git remote get-url origin 2>/dev/null | sed -E 's|.*/([^/]+/[^/]+)(\.git)?$|\1|')
    if [[ -z "$repo_full" ]]; then
      repo_full="$repo_name"
    fi
  fi

  nvim -c "Gitsigns change_base origin/main true" "gh://$repo_full/pr/$pr_number"
}

function get-or-create-worktree() {
  local repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)")
  local worktree="../$repo_name@pr-review"

  if [[ ! -d "$worktree" ]]; then
    local trunk=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
    local current=$(git branch --show-current)
    if [[ "$current" == "$trunk" ]]; then
      git worktree add -b "local-pr-review" "$worktree" "$trunk"
    else
      git worktree add "$worktree" "$trunk"
    fi
  fi

  echo "$worktree"
}

