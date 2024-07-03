# Check Firewalls on DigitalOcean Droplets

This repository contains a GitHub Action workflow to enumerate all Droplets in a DigitalOcean account and check if they have firewalls attached. If any Droplet does not have a firewall attached, it logs a message indicating the issue.

## Workflow Overview

The GitHub Action workflow:
1. Triggers on a push to the `main` branch or can be manually triggered.
2. Sets up the DigitalOcean CLI (`doctl`) using a provided API token.
3. Runs a shell script to list all Droplet IDs and check for attached firewalls.
4. Logs a message for each Droplet that does not have a firewall attached.

## Prerequisites

- A DigitalOcean account.
- A DigitalOcean API token with read permissions for Droplets and Firewalls.
- A GitHub repository.

## Setup

### Step 1: Add the DigitalOcean API Token

1. Go to your GitHub repository settings.
2. Navigate to "Secrets and variables" > "Actions".
3. Add a new repository secret named `DO_ACCESS_TOKEN` with your DigitalOcean API token as the value.

### Step 2: Create the Workflow File

Create a file at `.github/workflows/check-firewalls.yml` with the following content:

```yaml
name: Check Firewalls on Droplets

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  check-firewalls:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Set up DigitalOcean CLI
        uses: digitalocean/action-doctl@v2
        with:
          token: ${{ secrets.DO_ACCESS_TOKEN }}

      - name: Run firewall check script
        run: ./check-firewalls.sh