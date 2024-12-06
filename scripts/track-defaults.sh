#!/usr/bin/env bash

DOMAIN="${$1:-com.apple.dock}"
BEFORE_FILE="/tmp/before.plist"
AFTER_FILE="/tmp/after.plist"
MODIFIED_FILE="/tmp/modified.plist"

# Save current preferences
defaults export $DOMAIN $BEFORE_FILE

echo "Make your changes to $DOMAIN now, then press Enter."
read -r

# Save new preferences
defaults export $DOMAIN $AFTER_FILE

# Compare the before and after
plutil -convert xml1 $BEFORE_FILE
plutil -convert xml1 $AFTER_FILE
diff $BEFORE_FILE $AFTER_FILE >$MODIFIED_FILE

# Parse the differences to output `defaults write` commands
echo "Modified keys:"
awk '/<key>/{key=$0}/<string>|<integer>|<true\/>|<false\/>/{
    value=$0
    sub(/<key>|<\/key>/,"",key)
    sub(/<(.*)>|<\/.*>/,"",value)
    print "defaults write " ENVIRON["DOMAIN"] " " key " " value
}' $MODIFIED_FILE
