#!/usr/bin/env bash

### START-OF-ICON-MAP
function __icon_map() {
  case "$1" in
  "Activity Monitor")
    icon_result=":activity_monitor:"
    ;;
  "Accents")
    icon_result=":text:"
    ;;
  "Actions")
    icon_result=":shortcuts:"
    ;;
  "Affinity")
    icon_result=":affinity_designer_2:"
    ;;
  "AirPort Utility")
    icon_result=":airport_utility:"
    ;;
  "AeroSpace")
    icon_result=":windows_app:"
    ;;
  "Anki")
    icon_result=":anki:"
    ;;
  "AppCleaner")
    icon_result=":app_eraser:"
    ;;
  "App Store")
    icon_result=":app_store:"
    ;;
  "Arc")
    icon_result=":arc:"
    ;;
  "Balatro")
    icon_result=":games:"
    ;;
  "Blender")
    icon_result=":blender:"
    ;;
  "Books" | "Calibre" | "Bücher")
    icon_result=":book:"
    ;;
  "Brain.fm")
    icon_result=":brainfm:"
    ;;
  "Brave Browser")
    icon_result=":brave_browser:"
    ;;
  "Calculator" | "Calculette" | "Rechner")
    icon_result=":calculator:"
    ;;
  "Calendar" | "Notion Calendar")
    icon_result=":calendar:"
    ;;
  "Claude")
    icon_result=":claude:"
    ;;
  "Clop")
    icon_result=":maccy_clip:"
    ;;
  "Code" | "Visual Studio Code")
    icon_result=":code:"
    ;;
  "Color Picker")
    icon_result=":color_picker:"
    ;;
  "Compressor")
    icon_result=":final_cut_pro:"
    ;;
  "Copilot" | "GitHub Copilot for Xcode")
    icon_result=":copilot:"
    ;;
  "Cork")
    icon_result=":terminal:"
    ;;
  "Cursor")
    icon_result=":cursor:"
    ;;
  "darktable")
    icon_result=":camera:"
    ;;
  "DeepSeek")
    icon_result=":deepseek:"
    ;;
  "Developer")
    icon_result=":code:"
    ;;
  "Default")
    icon_result=":default:"
    ;;
  "deno")
    icon_result=":deno:"
    ;;
  "Dia")
    icon_result=":dia:"
    ;;
  "Legcord | Discord" | "Discord Canary" | "Discord PTB")
    icon_result=":discord:"
    ;;
  "Docker" | "Docker Desktop")
    icon_result=":docker:"
    ;;
  "Dropover")
    icon_result=":cloud:"
    ;;
  "Element")
    icon_result=":element:"
    ;;
  "Emacs")
    icon_result=":emacs:"
    ;;
  "FaceTime" | "FaceTime 通话")
    icon_result=":face_time:"
    ;;
  "Figma")
    icon_result=":figma:"
    ;;
  "Final Cut Pro")
    icon_result=":final_cut_pro:"
    ;;
  "Finder" | "访达")
    icon_result=":finder:"
    ;;
  "Firefox")
    icon_result=":firefox:"
    ;;
  "Firefox Developer Edition" | "Firefox Nightly")
    icon_result=":firefox_developer_edition:"
    ;;
  "FL Studio")
    icon_result=":flstudio:"
    ;;
  "Fork")
    icon_result=":fork:"
    ;;
  "System Preferences" | "System Settings" | "系统设置" | "Réglages Système" | "システム設定" | "Systemeinstellungen" | "System­einstellungen")
    icon_result=":gear:"
    ;;
  "GarageBand")
    icon_result=":music:"
    ;;
  "Ghostty")
    icon_result=":ghostty:"
    ;;
  "GitHub Desktop")
    icon_result=":git_hub:"
    ;;
  "Godot")
    icon_result=":godot:"
    ;;
  "Google Chrome")
    icon_result=":google_chrome:"
    ;;
  "GrandPerspective")
    icon_result=":statistics:"
    ;;
  "Helium")
    icon_result=":helium:"
    ;;
  "Homerow")
    icon_result=":keyboard:"
    ;;
  "Hyperspace")
    icon_result=":comet:"
    ;;
  "Image2Icon")
    icon_result=":image_playground:"
    ;;
  "ImageOptim")
    icon_result=":preview:"
    ;;
  "iA Writer")
    icon_result=":textedit:"
    ;;
  "iPhone Mirroring")
    icon_result=":iphone_mirroring:"
    ;;
  "iMovie")
    icon_result=":play:"
    ;;
  "Karabiner-Elements" | ".Karabiner-VirtualHIDDevice-Manager")
    icon_result=":karabiner_elements:"
    ;;
  "Karabiner-EventViewer")
    icon_result=":karabiner_elements_event_viewer:"
    ;;
  "Keka")
    icon_result=":forklift:"
    ;;
  "Keystroke Pro")
    icon_result=":keyboard_maestro:"
    ;;
  "Keynote" | "Keynote 讲演")
    icon_result=":keynote:"
    ;;
  "Klack")
    icon_result=":keyboard:"
    ;;
  "LanguageTool for Desktop")
    icon_result=":languagetool_for_desktop:"
    ;;
  "Latest")
    icon_result=":down_arrow:"
    ;;
  "League of Legends")
    icon_result=":league_of_legends:"
    ;;
  "Linear")
    icon_result=":linear:"
    ;;
  "Logic Pro")
    icon_result=":logicpro:"
    ;;
  "Lunar")
    icon_result=":moonlight:"
    ;;
  "MainStage")
    icon_result=":logicpro:"
    ;;
  "Mail")
    icon_result=":mail:"
    ;;
  "Maps")
    icon_result=":maps:"
    ;;
  "Mela")
    icon_result=":book:"
    ;;
  "Google Meet")
    icon_result=":meet:"
    ;;
  "Monocle")
    icon_result=":spotlight:"
    ;;
  "Motion")
    icon_result=":fusion:"
    ;;
  "Mp3tag")
    icon_result=":playing:"
    ;;
  "Messages" | "信息" | "Nachrichten" | "メッセージ")
    icon_result=":messages:"
    ;;
  "Music" | "音乐" | "Musique" | "ミュージック" | "Musik" | "Longplay")
    icon_result=":music:"
    ;;
  "NetNewsWire")
    icon_result=":netnewswire:"
    ;;
  "Neovim" | "neovim" | "nvim")
    icon_result=":neovim:"
    ;;
  "Noir")
    icon_result=":moon:"
    ;;
  "Notes" | "备忘录" | "メモ" | "Notizen")
    icon_result=":notes:"
    ;;
  "Notion")
    icon_result=":notion:"
    ;;
  "Numbers" | "Numbers 表格")
    icon_result=":numbers:"
    ;;
  "Obsidian")
    icon_result=":obsidian:"
    ;;
  "OBS")
    icon_result=":obsstudio:"
    ;;
  "Onigiri")
    icon_result=":widget:"
    ;;
  "1Password" | "1Password for Safari")
    icon_result=":one_password:"
    ;;
  "ChatGPT" | "ChatGPT Atlas")
    icon_result=":openai:"
    ;;
  "OpenAI Translator")
    icon_result=":openai_translator:"
    ;;
  "OpenVPN Connect")
    icon_result=":openvpn_connect:"
    ;;
  "OrbStack")
    icon_result=":orbstack:"
    ;;
  "Pages" | "Pages 文稿")
    icon_result=":pages:"
    ;;
  "Pandan")
    icon_result=":clock:"
    ;;
  "Passwords" | "Passwörter")
    icon_result=":passwords:"
    ;;
  "Photomator")
    icon_result=":photos:"
    ;;
  "Photos" | "Fotos")
    icon_result=":photos:"
    ;;
  "Pixelmator Pro")
    icon_result=":pixelmator_pro:"
    ;;
  "Podcasts" | "播客")
    icon_result=":podcasts:"
    ;;
  "Postman")
    icon_result=":postman:"
    ;;
  "Preview" | "预览" | "Skim" | "zathura" | "Aperçu" | "プレビュー" | "Vorschau")
    icon_result=":preview:"
    ;;
  "Proxyman")
    icon_result=":wifi:"
    ;;
  "RCT Classic+")
    icon_result=":games:"
    ;;
  "Raycast")
    icon_result=":raycast:"
    ;;
  "Refined GitHub")
    icon_result=":git_hub:"
    ;;
  "Reminders" | "提醒事项" | "Rappels" | "リマインダー" | "Erinnerungen")
    icon_result=":reminders:"
    ;;
  "Replacicon")
    icon_result=":sketch:"
    ;;
  "Riot Client")
    icon_result=":league_of_legends:"
    ;;
  "Safari" | "Safari浏览器" | "Safari Technology Preview")
    icon_result=":safari:"
    ;;
  "Sequel Pro")
    icon_result=":sequel_pro:"
    ;;
  "SF Symbols" | "SF Symbole")
    icon_result=":sf_symbols:"
    ;;
  "Shortcat")
    icon_result=":cursor:"
    ;;
  "Shortcuts")
    icon_result=":shortcuts:"
    ;;
  "Sim Daltonism")
    icon_result=":color_picker:"
    ;;
  "Slack")
    icon_result=":slack:"
    ;;
  "Spotify")
    icon_result=":spotify:"
    ;;
  "Spotlight")
    icon_result=":spotlight:"
    ;;
  "Steam" | "Steam Helper")
    icon_result=":steam:"
    ;;
  "Subler")
    icon_result=":quicktime:"
    ;;
  "SubscriptionDay")
    icon_result=":calendar:"
    ;;
  "superwhisper")
    icon_result=":voice_memos:"
    ;;
  "TablePlus")
    icon_result=":tableplus:"
    ;;
  "Tailscale")
    icon_result=":wireguard:"
    ;;
  "TeamSpeak 3" | "TeamSpeak")
    icon_result=":team_speak:"
    ;;
  "TestFlight")
    icon_result=":app_store:"
    ;;
  "Terminal" | "终端" | "ターミナル")
    icon_result=":terminal:"
    ;;
  "TextEdit")
    icon_result=":textedit:"
    ;;
  "QuickTime Player")
    icon_result=":quicktime:"
    ;;
  "TickTick")
    icon_result=":tick_tick:"
    ;;
  "Tide Guide")
    icon_result=":rain:"
    ;;
  "Town of Salem 2")
    icon_result=":games:"
    ;;
  "Transmit" | "Transmission")
    icon_result=":transmit:"
    ;;
  "TuneIn")
    icon_result=":podcasts:"
    ;;
  "uBlock Origin Lite")
    icon_result=":vpnoff:"
    ;;
  "UHF")
    icon_result=":tv:"
    ;;
  "UTM")
    icon_result=":utm:"
    ;;
  "VibeTunnel")
    icon_result=":music:"
    ;;
  "VLC")
    icon_result=":vlc:"
    ;;
  "VMware Fusion")
    icon_result=":vmware_fusion:"
    ;;
  "VyprVPN")
    icon_result=":vpn:"
    ;;
  "Warp")
    icon_result=":warp:"
    ;;
  "Weather" | "Wetter")
    icon_result=":weather:"
    ;;
  "WhatsApp" | "‎WhatsApp")
    icon_result=":whats_app:"
    ;;
  "Wipr")
    icon_result=":stopped:"
    ;;
  "WireGuard")
    icon_result=":wireguard:"
    ;;
  "Xbox")
    icon_result=":games:"
    ;;
  "Xcode")
    icon_result=":xcode:"
    ;;
  "Yaak")
    icon_result=":terminal:"
    ;;
  "YouTube")
    icon_result=":youtube:"
    ;;
  "YouTube Music")
    icon_result=":youtube_music:"
    ;;
  "Zed")
    icon_result=":zed:"
    ;;
  "Zen" | "Zen Browser")
    icon_result=":zen_browser:"
    ;;
  "zoom.us")
    icon_result=":zoom:"
    ;;
  *)
    icon_result=":default:"
    ;;
  esac
}
### END-OF-ICON-MAP
