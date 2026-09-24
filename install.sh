#!/usr/bin/env bash
#
# Library Editor installer.
#
#   curl -fsSL https://raw.githubusercontent.com/SamDickinsonReece/pipe-editor/main/install.sh | bash
#
# Downloads the latest release, installs it to ~/Applications, and clears the
# macOS quarantine flag so the app opens by double-click. No admin password and
# no Apple Developer certificate involved.
#
# Deliberately uses only tools present on a stock macOS install: curl, ditto,
# xattr, codesign, open, defaults. No python, no jq, no Xcode tools — invoking
# /usr/bin/python3 on a clean Mac can pop an "install developer tools" dialog.
set -euo pipefail

REPO="${PIPE_EDITOR_REPO:-SamDickinsonReece/pipe-editor}"
ASSET="LibraryEditor-handoff.zip"
APP_NAME="Library Editor.app"
DEST="$HOME/Applications"
# GitHub's documented permalink to the newest release, so no JSON parsing.
URL="https://github.com/$REPO/releases/latest/download/$ASSET"

bold() { printf '\033[1m%s\033[0m\n' "$1"; }
fail() {
  printf '\033[31m%s\033[0m\n' "$1" >&2
  exit 1
}

[ "$(uname -s)" = "Darwin" ] || fail "This installer is for macOS only."

bold "Library Editor installer"
echo "  source: $REPO"

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

echo "==> downloading (about 250 MB, this can take a few minutes)"
if ! curl -fL --progress-bar "$URL" -o "$WORK/$ASSET"; then
  fail "Download failed.
  Tried: $URL
  Either there is no published release yet, or the network blocked it."
fi

echo "==> unpacking"
# ditto, not unzip: it preserves the code signature inside the app bundle.
ditto -x -k "$WORK/$ASSET" "$WORK/unpacked" || fail "Could not unpack the download."

APP=$(find "$WORK/unpacked" -maxdepth 2 -name "$APP_NAME" -print -quit)
[ -n "$APP" ] || fail "The download did not contain $APP_NAME."

mkdir -p "$DEST"
if [ -d "$DEST/$APP_NAME" ]; then
  echo "==> replacing the existing copy"
  # Quit a running instance first, or the old code keeps running from a
  # bundle that no longer exists on disk.
  osascript -e 'quit app "Library Editor"' >/dev/null 2>&1 || true
  sleep 1
  rm -rf "$DEST/$APP_NAME"
fi

echo "==> installing to $DEST"
mv "$APP" "$DEST/$APP_NAME"

# Gatekeeper blocks anything carrying this flag. The app is ad-hoc signed
# rather than notarized, so clearing the flag is what makes it launchable.
echo "==> clearing the download quarantine flag"
xattr -dr com.apple.quarantine "$DEST/$APP_NAME" 2>/dev/null || true

codesign --verify "$DEST/$APP_NAME" 2>/dev/null ||
  echo "    note: signature check failed, the app may refuse to open"

VERSION=$(defaults read "$DEST/$APP_NAME/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null || echo "?")

echo "==> launching"
open "$DEST/$APP_NAME" || fail "Installed, but could not launch. Open it from $DEST."

cat <<EOF

$(bold "Installed — Library Editor $VERSION")

The app is in your own Applications folder:
  Finder > Go menu > Home > Applications

Tip: drag it to the Dock so it is easy to find next time.

It asks for a library JSON file when it opens — pick the file you were sent,
for example reece-digital-library-v7.json.

To update later, run the same command again.
EOF
