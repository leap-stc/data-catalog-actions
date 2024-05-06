#!/bin/bash

set -e

echo "🔄 Initializing LEAP Catalog Action..."

# Check if version is "latest"
if [ "$1" = "latest" ]; then
  echo "🔍 Cloning the latest version of the repository..."
  # Clone the GitHub repository
  git clone https://github.com/leap-stc/leap-data-management-utils

  cd leap-data-management-utils

  echo "🚀 Installing the package from the cloned repository..."
  # Install the package from the cloned repository
  python -m pip install ".[catalog]"
else
  echo "🔍 Installing package version: $1"
  # Install package from PyPI
  python -m pip install "leap-data-management-utils[catalog]==$1"
fi

# Validate Feedstocks
if [ -n "$3" ]; then
  echo "🔍 Validating feedstocks from: $3"
  leap-catalog validate --path "$3"
elif [ -n "$4" ]; then
  echo "🔍 Validating single feedstock: $4"
  leap-catalog validate --single "$4"
fi

# Generate Catalog
if [ -n "$5" ] && [ -n "$6" ]; then
  echo "🔍 Generating catalog from: $5 to $6"
  leap-catalog generate --path "$5" --output "$6"
fi
