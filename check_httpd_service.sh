#!/bin/bash

# Check if httpd service is running
if systemctl is-active --quiet httpd; then
  echo "httpd service is running."
else
  echo "httpd service is not running. Starting httpd..."
  systemctl start httpd
  if [ $? -eq 0 ]; then
    echo "httpd service started successfully."
  else
    echo "Failed to start httpd service."
  fi
fi
