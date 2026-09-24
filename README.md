# Library Editor

A spreadsheet-style editor for the digital product library JSON. Nested
structures — per-SKU variants, water authority approvals, list-valued fields —
stay intact; saving always writes a new file rather than modifying the one you
opened.

macOS only.

## Install

Paste this into Terminal and press Return:

```
curl -fsSL https://raw.githubusercontent.com/SamDickinsonReece/pipe-editor/main/install.sh | bash
```

It downloads the app, installs it to your own `~/Applications` folder and opens
it. No admin password needed. Run the same command again to update.

Terminal lives in Applications > Utilities, or press ⌘Space and type
"Terminal".

## Using it

Ask Sam for the guide, or see
[the user guide](https://github.com/SamDickinsonReece/pipe-editor/blob/main/USER-GUIDE.md).

The app does not include any data — it asks you to pick a library JSON file
when it opens.

## What the installer does

1. Downloads the latest release zip (~250 MB)
2. Unpacks it with `ditto`, which preserves the app's code signature
3. Moves the app to `~/Applications`
4. Clears the macOS download quarantine flag, so Gatekeeper stops blocking it
5. Launches the app

The app is ad-hoc signed but not notarized, which is why step 4 is needed. It
uses only tools built into macOS.
