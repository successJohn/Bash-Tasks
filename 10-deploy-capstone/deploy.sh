#!/usr/bin/env bash
set -euo pipefail

version=""
environment="dev"
dry_run=false
release=""
release_created=false
deploy_complete=false

usage() {
    echo "Usage: $0 -v VERSION [-e dev|staging|prod] [-d]" >&2
}

log() {
    local level="$1"
    local message="$2"
    local line

    line="[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $message"

    if [[ "$dry_run" == true ]]; then
        printf '%s\n' "$line"
    else
        printf '%s\n' "$line" | tee -a deploy.log
    fi
}

cleanup() {
    local status=$?

    # Only remove a release created by this run.
    if (( status != 0 )) &&
       [[ "$release_created" == true &&
          "$deploy_complete" == false ]]; then
        printf 'Removing incomplete release: %s\n' "$release" >&2
        rm -rf -- "$release" || true
    fi
}

trap cleanup EXIT

while getopts ":v:e:d" option; do
    case "$option" in
        v) version="$OPTARG" ;;
        e) environment="$OPTARG" ;;
        d) dry_run=true ;;
        :)
            echo "Error: -$OPTARG requires a value" >&2
            usage
            exit 2
            ;;
        \?)
            echo "Error: unknown option -$OPTARG" >&2
            usage
            exit 2
            ;;
    esac
done

shift "$((OPTIND - 1))"

if [[ -z "$version" ]] || (( $# != 0 )); then
    usage
    exit 2
fi

# Keep VERSION a single, safe directory name.
if [[ ! "$version" =~ ^[a-zA-Z0-9][a-zA-Z0-9._-]*$ ]]; then
    echo "Error: invalid version '$version'" >&2
    exit 2
fi

case "$environment" in
    dev|staging|prod) ;;
    *)
        echo "Error: invalid environment '$environment'" >&2
        exit 3
        ;;
esac

if [[ ! -d app ]]; then
    echo "Error: app/ directory missing" >&2
    exit 4
fi

release="releases/$version"

if [[ -e "$release" || -L "$release" ]]; then
    echo "Error: version '$version' already exists" >&2
    exit 5
fi

# Allow current to be absent or a symlink.
if [[ -e current && ! -L current ]]; then
    echo "Error: current exists and is not a symlink" >&2
    exit 1
fi

log INFO "Deploy started: version=$version env=$environment"

if [[ "$dry_run" == true ]]; then
    log INFO "Would copy app/ to $release/"
    log INFO "Would write env=$environment to $release/.env"
    log INFO "Would point current at $release"
    log INFO "Deploy finished (dry run)"
    exit 0
fi

mkdir -p -- releases

# Claim this release before copying so cleanup can remove partial copies.
# If mkdir fails, release_created stays false.
mkdir -- "$release"
release_created=true

cp -R -- app/. "$release/"
printf 'env=%s\n' "$environment" > "$release/.env"

ln -sfn -- "$release" current
deploy_complete=true

log INFO "Deploy finished"
