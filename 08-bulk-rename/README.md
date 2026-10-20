# Task 8: Bulk Rename
**Concepts:** `for` over files, parameter expansion (`#`, `%`, `##`), quoting filenames with spaces, `shopt -s nullglob`

## Setup
```
bash setup.sh      # creates photos/ with IMG_0001.JPG ... plus a notes.txt and a file with a space
```

## Your mission
Write `rename.sh DIR NEW_PREFIX` that renames every `IMG_<something>.JPG` in `DIR` to `<NEW_PREFIX>_<something>.jpg` (lowercase extension).

```
$ ./rename.sh photos vacation
IMG_0001.JPG -> vacation_0001.jpg
IMG_0002.JPG -> vacation_0002.jpg
...
Renamed 4 file(s)
```

## Rules
- Do **not** use `rename` or `sed`; use parameter expansion only.
- Files that do not match (like `notes.txt`) must stay untouched.
- Filenames with spaces must work, so quote every variable.
- Exit **2** if arguments are missing, **1** if `DIR` does not exist.

## Hints
- `${var#IMG_}` removes a prefix; `${var%.JPG}` removes a suffix; `${var##*/}` gives the basename.
- Without `shopt -s nullglob`, a pattern that matches nothing is passed through literally.

## Check your work
```
bash check.sh ~/path/to/rename.sh
```

## Stretch goals
- Add a `-n` dry-run mode.
- Refuse to overwrite an existing file (`mv -n`).
