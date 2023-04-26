#!/bin/bash

REPOSITORY=$REPO
ACCESS_TOKEN=$TOKEN

echo "REPO ${REPOSITORY}"
echo "ACCESS_TOKEN ${ACCESS_TOKEN}"

REG_TOKEN=$(curl -X POST -H "Authorization: Bearer ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/${REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

echo "Reg token created"

cd /home/docker/actions-runner

./config.sh --url https://github.com/${REPOSITORY} --token ${REG_TOKEN}

echo "Config complete"

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!