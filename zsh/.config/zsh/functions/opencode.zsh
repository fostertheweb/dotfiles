#!/usr/bin/env zsh

alias commit="gum confirm --default=false 'Commit all changes?' && opencode run 'commit all changes, breakup into multiple commits if some changes are not related to another. i typically group commits by program or area of config, but sometimes mutiple tool configs need changes for one cohesive feature. consider that when creating commits.'"
