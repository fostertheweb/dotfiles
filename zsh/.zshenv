export XDG_CONFIG_HOME="$HOME/.config"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

source "$HOME/.cargo/env"

[[ -f ~/.api-credentials ]] && source ~/.api-credentials
