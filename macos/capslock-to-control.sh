#!/bin/sh
# Remap Caps Lock -> Control for this host, same as
# System Settings > Keyboard > Modifier Keys. Idempotent.
#
# Values are HID usages with the keyboard page in the high bits
# (0x700000000 = 30064771072):
#   Caps Lock     0x39 -> 30064771129
#   Right Control 0xE4 -> 30064771300
set -eu

SRC=30064771129
DST=30064771300
PREFIX=com.apple.keyboard.modifiermapping
VALUE="<dict><key>HIDKeyboardModifierMappingSrc</key><integer>$SRC</integer><key>HIDKeyboardModifierMappingDst</key><integer>$DST</integer></dict>"

# 0-0-0 is the fallback that applies to keyboards without their own entry.
# Also refresh any per-device entries System Settings created earlier.
keys="$PREFIX.0-0-0
$(defaults -currentHost read -g 2>/dev/null | grep -o "$PREFIX\.[0-9]*-[0-9]*-[0-9]*" | sort -u || true)"

for key in $(printf '%s\n' "$keys" | sort -u); do
  defaults -currentHost write -g "$key" -array "$VALUE"
done
