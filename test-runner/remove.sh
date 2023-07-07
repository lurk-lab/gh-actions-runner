#!/bin/bash

# Helper script to purge the self-hosted runner systemd service
# Run install.sh afterward to reinstall

systemctl stop gh-actions-runner
systemctl disable gh-actions-runner
rm /etc/systemd/system/gh-actions-runner.service
rm /etc/systemd/system/gh-actions-runner.service # and symlinks that might be related
rm /etc/gh-actions-runner.env
rm /etc/gh-actions-runner-compose.yml
rm /usr/lib/systemd/system/gh-actions-runner.service
rm /usr/lib/systemd/system/gh-actions-runner.service # and symlinks that might be related
systemctl daemon-reload
systemctl reset-failed

# Optional
#docker system prune -a
