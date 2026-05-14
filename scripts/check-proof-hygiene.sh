#!/usr/bin/env bash
set -euo pipefail

target="${1:-Curify}"
pattern='\b(sorry|admit|axiom|unsafe|opaque)\b'

set +e
rg -n "${pattern}" "${target}"
status=$?
set -e

case "${status}" in
  0)
    echo "proof hygiene check failed: forbidden proof escape found in ${target}" >&2
    exit 1
    ;;
  1)
    echo "proof hygiene check passed: no forbidden proof escapes in ${target}"
    ;;
  *)
    exit "${status}"
    ;;
esac
