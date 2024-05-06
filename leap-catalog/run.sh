#!/bin/bash

set -e

# Check if version is "latest"
if [ "$1" = "latest" ]; then
  # Clone the GitHub repository
  git clone https://github.com/leap-stc/leap-data-management-utils

  cd leap-data-management-utils

  # Install the package from the cloned repository
  python -m pip install ".[catalog]"
else
  # Install package from PyPI
  python -m pip install "leap-data-management-utils[catalog]==$1"
fi

# Validate Feedstocks
if [ -n "$3" ]; then
  leap-catalog validate --path "$3"
elif [ -n "$4" ]; then
  leap-catalog validate --single "$4"
fi

# Generate Catalog
if [ -n "$5" ] && [ -n "$6" ]; then
  leap-catalog generate --path "$5" --output "$6"
fi
