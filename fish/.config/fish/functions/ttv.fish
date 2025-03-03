#!/usr/bin/env fish

function ttv
    set url "twitch.tv/$argv[1]"
    streamlink $url best --stream-url --twitch-disable-ads | xargs open -a "QuickTime Player.app"
    open -a Safari "https://$url/chat"
end

