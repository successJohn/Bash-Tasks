# Task 4: The Backup Script
**Concepts:** `tar`, `date` formats, functions, argument checking, cleanup with `ls | sort | tail | xargs`

## Setup
```
bash setup.sh      # creates a project/ folder to back up
```

## Your mission
Write `backup.sh SOURCE_DIR DEST_DIR` that:
1. Validates both arguments (usage message and exit **2** if missing; exit **1** if the source does not exist).
2. Creates `DEST_DIR` if needed.
3. Saves a compressed archive named `backup_YYYY-MM-DD_HHMMSS.tar.gz`.
4. Prints `Created <path>`.
5. Keeps only the **3 newest** backups and deletes older ones.

## Hints
- `tar -czf archive.tar.gz -C parent_dir folder_name`
- `date +%Y-%m-%d_%H%M%S`
- Because the timestamp is in the name, `ls | sort -r` puts the newest first; `tail -n +4` lists everything after the first 3.
- Put the usage message in a function.

## Check your work
```
bash check.sh ~/path/to/backup.sh      # takes about 6 seconds
```

## Stretch goals
- Add a `-k N` option for how many backups to keep.
- Print the archive size with `du -h`.
