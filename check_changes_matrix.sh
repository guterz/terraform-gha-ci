#!/bin/bash
set -e

ACCOUNT=$1
REGION=$2
# LAYER=$3


if [[ "$BRANCH_NAME" == "main" ]] ; then
  DIFF=$(git diff --name-only --diff-filter=d "$PREV_SHA" "$SHA")
else
  DIFF=$(git diff --name-only --diff-filter=d origin/main HEAD)
fi

echo -e "Git diff :\n${DIFF}"
export LAYERS=$(echo "${DIFF}" | grep "${ACCOUNT}/${REGION}" | sed -E "s|${ACCOUNT}/[^/]*/([^/]*)/.*|\1|" | sort | uniq)
if ! echo "${DIFF}" | egrep -q "^${ACCOUNT}/${REGION}/"; then
  export CHANGED=false
else
  export CHANGED=true
fi

echo "${CHANGED}"
echo "${LAYERS}"

# for LAYER in "${LAYERS[@]}"; do
#   echo "${LAYER}"
# done
