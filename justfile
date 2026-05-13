_default:
  @ just --list --unsorted

# Format every .aww in this repo via `awsum format -i`
format:
  #!/bin/sh
  set -eu
  find . -name '*.aww' -not -path './.git/*' -print0 | xargs -0 -n1 awsum format -i
  echo "\n\n✅ Formatting completed!\n\n"

# Run hello/Main.aww through every backend and assert identical stdout (same check CI runs)
test:
  #!/bin/sh
  set -eu
  expected="Hello, world!"
  for target in llvm jvm clr wasm js; do
    echo "=== $target ==="
    actual=$(awsum run hello/Main.aww --program-type cli -t "$target" --stdin < hello/input.txt)
    if [ "$actual" != "$expected" ]; then
      printf 'target=%s\nexpected: %s\nactual:   %s\n' "$target" "$expected" "$actual"
      exit 1
    fi
    echo "OK: $actual"
  done
  echo "\n\n✅ All backends agree.\n\n"

# Full precommit: format → test
fix: format test

# Confirm potentially dangerous actions with a specific confirmation input (e.g. version, environment name)
[private]
manual-confirmation-input message required_confirmation:
  #!/bin/sh
  set -eu

  message="{{ message }}"
  required_confirmation="{{ required_confirmation }}"

  echo "$message"
  echo "Type '$required_confirmation' to confirm:"
  read response

  if [ "$response" != "$required_confirmation" ]; then
    echo "Confirmation failed. Exiting..."
    exit 1
  fi

# Tag and push the version currently in .github/workflows/ci.yml (AWSUM_VERSION).
# Run after the prep PR is merged into main.
release:
  #!/bin/sh
  set -eu
  git checkout main
  git pull
  version=$(awk '/^[[:space:]]*AWSUM_VERSION:/ {print $2; exit}' .github/workflows/ci.yml)
  just manual-confirmation-input "About to tag and push v$version" "$version"
  git tag -a "v$version" -m "Release $version"
  git push origin "v$version"
