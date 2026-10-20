# Task 10: Capstone: The Deploy Script
**Concepts:** `set -euo pipefail`, `getopts`, `trap`, logging, exit codes, symlinks, dry-run mode. This task combines almost everything from Tasks 1 to 9.

## Setup
```
bash setup.sh      # creates app/ with index.html and config.txt
```

## Your mission
Write `deploy.sh -v VERSION [-e ENV] [-d]` that "deploys" the `app/` folder:

| Option | Meaning |
|---|---|
| `-v VERSION` | **Required.** Release version, e.g. `1.0` |
| `-e ENV` | `dev` (default), `staging` or `prod` |
| `-d` | Dry run: log what would happen, change nothing |

## What a successful deploy does
1. Logs `Deploy started: ...` to **both** the screen and `deploy.log`, with timestamps (use `tee -a`).
2. Copies `app/` to `releases/VERSION/`.
3. Writes `env=<ENV>` into `releases/VERSION/.env`.
4. Points a symlink `current` at the new release: `ln -sfn releases/VERSION current`.
5. Logs `Deploy finished`.

## Exit codes
| Code | When |
|---|---|
| 0 | Success (or dry run) |
| 2 | Missing `-v` or bad option |
| 3 | Invalid environment |
| 4 | `app/` directory missing |
| 5 | That version already exists |

## Requirements
- Start the script with `set -euo pipefail`.
- Use `getopts` for the options.
- Use a `trap ... EXIT` function that **removes a half-finished release** if something fails after the copy. It must never delete a release that already existed.
- Put logging in a `log LEVEL "message"` function.

## Check your work
```
bash check.sh ~/path/to/deploy.sh
```

## Stretch goals
- Add `-r` to roll back by pointing `current` at the previous release.
- Keep only the last 5 releases.
- Refuse `prod` deploys unless the user types `yes` to confirm.
