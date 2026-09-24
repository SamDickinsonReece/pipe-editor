# Library Editor — user guide

A spreadsheet-style editor for the digital library JSON. It never changes the
file you open: saving always writes a new file you name.

## Where the app lives

It sits in **your own Applications folder**, not the system one — no admin
password or IT request needed. To find it: Finder → **Go** menu → **Home** →
`Applications`. Or just press ⌘Space and type "Library Editor".

Worth dragging to the Dock once, to save hunting for it.

## Opening your data

1. Open **Library Editor**.
2. It asks for a library JSON file — pick the one you were sent, e.g.
   `reece-digital-library-v7.json`.
3. Use **Open…** (or ⌘O) any time to switch files.

## The three tabs

- **Records** — one row per product SKU. The `Group` dropdown narrows the
  columns down: `core` (sku, description), `inputs`, `variant` (per-SKU specs)
  or `product` (family-wide specs).
- **Approvals** — one row per SKU per water authority. Status columns are
  dropdowns, because only the five official values are allowed.
- **Flags** — the data warnings the export raised against specific fields.
  Edit the level and note, or delete a flag that has been resolved.

## Editing

- Click a cell to edit it. **Enter** saves and moves down, **Tab** moves right,
  **Esc** cancels. Arrow keys move around without editing.
- Edited cells turn **yellow** until you save. The count is in the top bar.
- Cells showing blue tags (e.g. Application, AU/NZ Standards) hold a **list** of
  values. Clicking one opens a box — put **one value per line**.
- **Revert all** throws away every unsaved edit and reloads the file.

## Saving

**Save As…** (⌘S) suggests the next version number, e.g. `v7` → `v8`. Pick a
name and location.

Before writing, the editor checks the whole file against the expected
structure. If something is wrong it writes nothing and shows the problem at the
bottom — that is a safety net, not a failure on your part. Send the message
along if it appears.

The file you opened is never modified. Closing with unsaved edits asks first.

## Filters

- **sku contains…** — narrow to one product or family.
- **search all columns…** — free text across everything on the current tab.
- **edited only** — show just the rows you have changed. Useful for a final
  check before saving.
