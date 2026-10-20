# Task 3: The File Organizer
**Concepts:** `for` loops, globbing, `case`, parameter expansion (`${f##*.}`), `mkdir -p`, `mv`

## Setup
```
bash setup.sh      # creates a messy/ folder full of mixed files
```

## Your mission
Write `organize.sh [DIR]` (default `messy`) that sorts files into subfolders by extension:

| Extensions | Folder |
|---|---|
| jpg, jpeg, png, gif | `images/` |
| txt, pdf, md, docx | `docs/` |
| anything else | `other/` |

Print `Moved <file> -> <folder>/` for every file. Exit with an error if the directory does not exist.

## Hints
- `${f##*.}` strips everything up to the last dot, leaving the extension.
- `${ext,,}` makes it lowercase so `PHOTO.JPG` works too.
- Skip directories with `[[ -f $f ]] || continue`.

## Check your work
```
bash check.sh ~/path/to/organize.sh
```

## Stretch goals
- Add a `-n` dry-run flag that only prints what would move.
- Handle name clashes by appending a number.
