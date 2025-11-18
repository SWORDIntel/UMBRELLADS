#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

ROOT_DIR="$SCRIPT_DIR"
REPO_NAME="UMBRELLA-ADS"
GITHUB_USER="John"
USER_EMAIL="intel@swordintelligence.airforce"
REMOTE_PROTO="https"

usage() {
    cat <<USAGE
Usage: $(basename "$0") [options]

Options:
  --root <path>     Directory to turn into a repo (default: script directory)
  --repo <name>     Repository name (default: UMBRELLA-ADS)
  --user <name>     GitHub username (default: John)
  --email <email>   Commit author email (default: intel@swordintelligence.airforce)
  --https           Use HTTPS remote instead of SSH
  -h, --help        Show this message

Example:
  $(basename "$0") --repo UMBRELLA-ADS --user John --https
USAGE
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --root)
            ROOT_DIR="$(cd -- "$2" && pwd)"
            shift 2
            ;;
        --repo)
            REPO_NAME="$2"
            shift 2
            ;;
        --user)
            GITHUB_USER="$2"
            shift 2
            ;;
        --email)
            USER_EMAIL="$2"
            shift 2
            ;;
        --https)
            REMOTE_PROTO="https"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
    esac
done

if [[ "$REMOTE_PROTO" == "https" ]]; then
    REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
else
    REMOTE_URL="git@github.com:${GITHUB_USER}/${REPO_NAME}.git"
fi

echo "Working directory : $ROOT_DIR"
echo "Repository name   : $REPO_NAME"
echo "GitHub user       : $GITHUB_USER"
echo "Remote URL        : $REMOTE_URL"

cd "$ROOT_DIR"

if [[ ! -d .git ]]; then
    git init
    echo "Initialized git repository."
fi

git config user.name "$GITHUB_USER"
git config user.email "$USER_EMAIL"

gh_available=false
gh_authed=false

if command -v gh >/dev/null 2>&1; then
    gh_available=true
    if gh auth status >/dev/null 2>&1; then
        gh_authed=true
    fi
fi

if $gh_available && $gh_authed; then
    if ! gh repo view "${GITHUB_USER}/${REPO_NAME}" >/dev/null 2>&1; then
        echo "Creating private repo ${GITHUB_USER}/${REPO_NAME} via gh..."
        if gh repo create "${GITHUB_USER}/${REPO_NAME}" --private --description "Umbrella ads archive" >/dev/null 2>&1; then
            echo "Repository created."
        else
            cat <<WARN
Unable to create ${GITHUB_USER}/${REPO_NAME} via gh. Ensure you are authenticated
as ${GITHUB_USER} or pre-create the repository manually.
WARN
        fi
    else
        echo "Repo ${GITHUB_USER}/${REPO_NAME} already exists on GitHub."
    fi
else
    if ! $gh_available; then
        echo "GitHub CLI (gh) not installed; skipping remote creation."
    elif ! $gh_authed; then
        cat <<WARN
GitHub CLI not authenticated. Run 'gh auth login' or set GH_TOKEN,
or ensure the remote repository ${GITHUB_USER}/${REPO_NAME} exists before continuing.
WARN
    fi
fi

if git rev-parse --verify main >/dev/null 2>&1; then
    git checkout main >/dev/null 2>&1 || true
fi

if [[ -n "$(git status --porcelain)" ]]; then
    git add .
    git commit -m "Initial import"
else
    echo "No changes to commit."
fi

if git remote | grep -q "^origin$"; then
    git remote set-url origin "$REMOTE_URL"
else
    git remote add origin "$REMOTE_URL"
fi

git branch -M main
git push -u origin main
