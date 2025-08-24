#!/bin/bash

repo="HelloNeptune/<REPO_NAME>"

# Get the list of artifacts from the repo
artifacts=$(gh api "repos/$repo/actions/artifacts?per_page=100" --paginate | jq -r '.artifacts[] | "\(.id) \(.name)"')

# Delete it
while read -r id name; do
 echo "Deleting: $name (ID: $id)"
 gh api --method DELETE "repos/$repo/actions/artifacts/$id"
done <<< "$artifacts"
