import os
from ranger.api.commands import Command
from ranger.core.linemode import LinemodeBase

# Hook to prevent going up beyond the Git root
def hook_change_path(fm, path):
    git_root = find_git_root(fm.thisdir.path)
    if git_root and not os.path.commonpath([path, git_root]) == git_root:
        fm.notify("Cannot go beyond the Git root directory.", bad=True)
        return True  # Cancel the directory change
    return False

# Find the Git root directory
def find_git_root(path):
    while path != '/':
        if os.path.isdir(os.path.join(path, '.git')):
            return path
        path = os.path.dirname(path)
    return None

# Attach the hook to the Ranger event
old_cd = ranger.core.fm.FM.cd
def new_cd(fm, path, *args, **kwargs):
    if hook_change_path(fm, path):
        return
    old_cd(fm, path, *args, **kwargs)

ranger.core.fm.FM.cd = new_cd
