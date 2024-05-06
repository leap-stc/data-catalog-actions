#!/bin/bash

set -e

echo "🔄 Initializing LEAP Catalog Action..."

# Check if version is "latest"
if [ "$1" = "latest" ]; then
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

# Check if any action is specified
if [ -n "$3" ]; then
  if [ -n "$4" ]; then
    # Validate single feedstock
    echo "🔍 Validating single feedstock: $4"
    leap-catalog validate --single "$4"
  elif [ -n "$2" ]; then
    # Validate feedstocks
    echo "🔍 Validating feedstocks from: $2"
    leap-catalog validate --path "$2"
  else
    echo "⚠️ No action specified. Please provide either 'single-feedstock', 'validation-path', or 'generation-path' and 'output-directory' inputs."
  fi
elif [ -n "$5" ] && [ -n "$6" ]; then
  # Generate catalog
  echo "🔍 Generating catalog from: $5 to $6"
  leap-catalog generate --path "$5" --output "$6"
fi
