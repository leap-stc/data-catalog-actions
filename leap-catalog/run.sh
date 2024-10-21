#!/bin/bash

set -e

echo "🔄 Initializing LEAP Catalog Action..."
echo "Arguments: version=$1, validation-path=$2, single-feedstock=$3, generation-single=$4, generation-path=$5, output-directory=$6"

echo "🔍 Installing package version: $1"
python -m pip install "leap-data-management-utils[catalog]==$1" || {
  echo "Specific version installation failed"
  exit 1
}

# Print version and show which leap-catalog and python
echo "🔍 Version: $1"
echo "🔍 leap-catalog location: $(which leap-catalog)"
echo "🔍 python location: $(which python)"
echo "🔍 python version: $(python --version)"

# Validate or generate based on input arguments
if [ -n "$3" ]; then
  echo "🔍 Validating single feedstock: $3"
  leap-catalog validate --single "$3" || {
    echo "Validation failed for single feedstock"
    exit 1
  }
elif [ -n "$2" ]; then
  echo "🔍 Validating feedstocks from: $2"
  leap-catalog validate --path "$2" || {
    echo "Validation failed for feedstocks"
    exit 1
  }
elif [ -n "$4" ] && [ -n "$6" ]; then
  echo "🔍 Generating catalog for a single feedstock from: $4 to $6"
  leap-catalog generate --single"$4" --output "$5" || {
    echo "Catalog generation failed"
    exit 1
  }
elif [ -n "$5" ] && [ -n "$6" ]; then
  echo "🔍 Generating catalog for multiple feedstocks from: $5 to $6"
  leap-catalog generate --path "$5" --output "$6" || {
    echo "Catalog generation failed"
    exit 1
  }
else
  echo "⚠️ No valid action specified. Please check input parameters."
  exit 1
fi

exit 0
