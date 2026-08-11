#!/usr/bin/env bash
#
# create-symlinks.sh
#
# Creates symlinks for the dotfiles listed in config/symlinks.toml.
# Works with bash or zsh.
#
# Usage:
#   scripts/create-symlinks.sh            # create symlinks
#   scripts/create-symlinks.sh --dry-run   # show what would happen, no changes
#   scripts/create-symlinks.sh --force     # overwrite existing files instead of backing them up
#
# Notes:
# - `source` paths in symlinks.toml are relative to $HOME (e.g. dev/dotfiles/...).
# - `target` paths are relative to $HOME, unless they start with "/" (absolute).
# - Existing targets that are not already the correct symlink are backed up to
#   <target>.bak-<timestamp> unless --force is passed, in which case they are removed.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TOML_FILE="${REPO_ROOT}/config/symlinks.toml"

DRY_RUN=false
FORCE=false

for arg in "$@"; do
  case "${arg}" in
    --dry-run) DRY_RUN=true ;;
    --force) FORCE=true ;;
    -h|--help)
      grep '^#' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "Unknown option: ${arg}" >&2
      exit 1
      ;;
  esac
done

if [[ ! -f "${TOML_FILE}" ]]; then
  echo "Could not find ${TOML_FILE}" >&2
  exit 1
fi

resolve_path() {
  # Resolve a toml-relative path against $HOME, leaving absolute paths as-is.
  local path="$1"
  if [[ "${path}" == /* ]]; then
    printf '%s' "${path}"
  else
    printf '%s' "${HOME}/${path}"
  fi
}

link_one() {
  local source_path="$1"
  local target_path="$2"

  if [[ ! -e "${source_path}" ]]; then
    echo "SKIP  (missing source) ${source_path}" >&2
    return
  fi

  # Already linked correctly.
  if [[ -L "${target_path}" && "$(readlink "${target_path}")" == "${source_path}" ]]; then
    echo "OK    ${target_path} -> ${source_path}"
    return
  fi

  if [[ -e "${target_path}" || -L "${target_path}" ]]; then
    if ${FORCE}; then
      echo "RM    ${target_path}"
      ${DRY_RUN} || rm -rf "${target_path}"
    else
      local backup="${target_path}.bak-$(date +%Y%m%d%H%M%S)"
      echo "BACKUP ${target_path} -> ${backup}"
      ${DRY_RUN} || mv "${target_path}" "${backup}"
    fi
  fi

  local target_dir
  target_dir="$(dirname "${target_path}")"
  if [[ ! -d "${target_dir}" ]]; then
    echo "MKDIR ${target_dir}"
    ${DRY_RUN} || mkdir -p "${target_dir}"
  fi

  echo "LINK  ${target_path} -> ${source_path}"
  ${DRY_RUN} || ln -s "${source_path}" "${target_path}"
}

# Parse the [[dotfiles]] entries out of symlinks.toml. The format is a
# small, predictable subset of TOML (one key per line), so a simple line
# scan is enough and avoids requiring a TOML parser as a dependency.
source_rel=""
target_rel=""

process_entry() {
  if [[ -n "${source_rel}" && -n "${target_rel}" ]]; then
    link_one "$(resolve_path "${source_rel}")" "$(resolve_path "${target_rel}")"
  fi
  source_rel=""
  target_rel=""
}

while IFS= read -r line || [[ -n "${line}" ]]; do
  line="$(echo "${line}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

  case "${line}" in
    '[[dotfiles]]')
      process_entry
      ;;
    source\ =\ *)
      source_rel="${line#source = }"
      source_rel="${source_rel%\"}"
      source_rel="${source_rel#\"}"
      ;;
    target\ =\ *)
      target_rel="${line#target = }"
      target_rel="${target_rel%\"}"
      target_rel="${target_rel#\"}"
      ;;
  esac
done < "${TOML_FILE}"

# Process the final entry.
process_entry
