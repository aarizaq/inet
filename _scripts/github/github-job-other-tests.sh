#!/bin/env bash

# This script runs the "other tests" job on GitHub.
#
# The following environment variables must be set when invoked:
#    TESTDIR                - must be the name of a subfolder in the tests directory
#                             in which all tests can be run simply as: ./runtest
#                             (such as: module, packet, queueing, unit, ...)
#
#    GITHUB_WORKSPACE       - this is provided by GitHub, most likely has
#                             the value "/home/runner/work/inet/inet"


set -e # make the script exit with error if any executed command exits with error


export PATH="/root/omnetpp-6.0pre9-linux/bin:$PATH"

# this is where the cloned INET repo is mounted into the container
cd $GITHUB_WORKSPACE

. setenv -f

cp -r /root/nsc-0.5.3 3rdparty

echo "::group::Enable all features"
opp_featuretool enable all  2>&1 # redirecting stderr so it doesn't get out of sync with stdout
echo "::endgroup::"

echo "::group::Make Makefiles"
make makefiles
echo "::endgroup::"

echo "::group::Make message headers"
make -C src msgheaders smheaders
echo "::endgroup::"

echo "::group::Run $TESTDIR tests"
cd tests/$TESTDIR
./runtest | tee runtest.out
#        ^---- Everything from here on is only needed to make the pretty GitHub annotations. ----v
EXITCODE="${PIPESTATUS[0]}"
echo "::endgroup::"


DIFFPATTERN="([^\n]*\n[?] *\^\n)" # matches a line that looks like "?     ^" and the line before it

FAILPATTERN="test: FAIL |FAILED tests:|FAIL: [^0]"
UNRESOLVEDPATTERN="test: UNRESOLVED |UNRESOLVED tests: |UNRESOLVED: [^0]"
LINEPATTERN="([^\n]*($FAILPATTERN|$UNRESOLVEDPATTERN)[^\n]*\n)"

# the "| tr -d" is there only to get rid of the terminating NUL which is there because
# of "grep -z" which is needed to make the entire input look like one long line
FAILS=$(grep -P -zo "$DIFFPATTERN|$LINEPATTERN" runtest.out | tr -d '\0')

if [ -n "$FAILS" ]
then
    # newline characters are replaced with '%0A' to make them appear as multiline on the web UI
    # Source: https://github.com/actions/starter-workflows/issues/68#issuecomment-581479448
    # (Also: https://github.com/mheap/phpunit-github-actions-printer/pull/14 )
    echo "::error::${FAILS//$'\n'/%0A}"
fi

exit $EXITCODE