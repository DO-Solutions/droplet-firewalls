#!/bin/bash

# Fetch the list of droplet IDs
DROPLET_IDS=$(doctl compute droplet list --format ID --no-header)

# Iterate over each droplet ID
for DROPLET_ID in $DROPLET_IDS; do
  # Check if the droplet has firewalls attached
  FIREWALL_IDS=$(doctl compute firewall list-by-droplet $DROPLET_ID --format ID --no-header)
  
  # If no firewall is attached, log an issue
  if [ -z "$FIREWALL_IDS" ]; then
    echo "No firewall attached for Droplet ID $DROPLET_ID"
  fi
done