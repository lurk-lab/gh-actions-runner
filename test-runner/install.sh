#!/bin/bash

# Helper script to deploy/redeploy self-hosted runners

systemctl stop gh-actions-runner
install -m 644 gh-actions-runner-compose.yml /etc/
install -m 600 gh-actions-runner.env /etc/
install -m 644 gh-actions-runner.service /etc/systemd/system
systemctl daemon-reload
systemctl enable gh-actions-runner
systemctl start gh-actions-runner
