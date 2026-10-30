#!/usr/bin/env bash
# Runs the three implementations against the three checks and verifies that:
#   - the real implementation passes all three;
#   - each lookup table passes the sample it was built from, 100%;
#   - both lookup tables fail the definition on fresh random cases.
set -euo pipefail
cd "$(dirname "$0")"

cabal build -v0 checks
out=$(cabal run -v0 checks)
echo "$out"
echo

failures=0
expect() {
  if grep -qE -- "$2" <<<"$out"; then
    echo "ok   $1"
  else
    echo "FAIL $1 (expected a line matching: $2)"; failures=1
  fi
}

expect "insertionSort passes all three checks"           '^insertionSort +12/12 +50/50 +OK'
expect "fromExamples passes the example suite, 100%"     '^fromExamples +12/12 '
expect "fromExamples fails the definition on new cases"  '^fromExamples .*FAILED on '
expect "fromSaved passes the saved cases, 100%"          '^fromSaved +[0-9]+/12 +50/50 '
expect "fromSaved fails the definition on new cases"     '^fromSaved .*FAILED on '
exit $failures
