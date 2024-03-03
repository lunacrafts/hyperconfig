#!/bin/sh

# Directory containing your kubeconfig files
CONFIG_DIR="./hyperconfig"

# Create a variable to hold the combined path of all kubeconfig files
KUBECONFIG_FILES=""

# Loop through all .yml and .yaml files in the directory
for FILE in $CONFIG_DIR/*.{yml,yaml}; do
  # Check if the file exists to avoid adding non-existent paths
  if [ -f "$FILE" ]; then
    # Append the file path to the KUBECONFIG_FILES variable, separated by colon
    KUBECONFIG_FILES="$KUBECONFIG_FILES:$FILE"
  fi
done

# Remove the initial colon character from the list
KUBECONFIG_FILES="${KUBECONFIG_FILES:1}"

# Export the KUBECONFIG environment variable with the combined paths
export KUBECONFIG="$KUBECONFIG_FILES"

kubectl config view --merge --flatten > ~/.kube/config
