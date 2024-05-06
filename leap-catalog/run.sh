#!/bin/bash

set -e

# Install package
if [ -n "$1" ]; then
  # If argument 1 is provided, assume it's a Git URL
  python -m pip install "$1"
else
  # If argument 1 is not provided, assume it's a package name with version
  python -m pip install "$2"
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
