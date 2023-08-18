#!/usr/bin/env bash

# This script should be run first before the deployment of the infrastructure.
# It enables the required APIs for the resources that will be deployed.

# NOTE: The project user that is running this script needs to have the following permissions on the project
# - roles/owner
# OR
# - roles/editor
# - resourcemanager.projects.setIamPolicy
# - iam.serviceAccounts.setIamPolicy


# Enable APIS
ENABLE_APIS=true


#OUTPUT COLORING
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

# Required APIs list
API_List=("serviceusage.googleapis.com"
  "servicemanagement.googleapis.com"
  "cloudbuild.googleapis.com"
  "cloudresourcemanager.googleapis.com"
  "compute.googleapis.com"
  "storage-api.googleapis.com"
  "storage-component.googleapis.com"
  "deploymentmanager.googleapis.com"
  "iam.googleapis.com"
  "iamcredentials.googleapis.com"
  "appengineflex.googleapis.com"
  "appengine.googleapis.com")

if [ "$ENABLE_APIS" = true ]; then
  echo -e " --> Enabling required project APIs"
  for API in "${API_List[@]}"; do
    gcloud services enable $API;
    ret=$?
    if [ $ret -ne 0 ]; then
      echo -e "\t -> ${RED}Could not enable ${API} ${NC}"
    else
      echo -e "\t -> ${API}....${GREEN}enabled${NC}"
    fi
  done
  echo -e "\n"
else
  echo -e "\t -> Skipping enabling APIs\n"
fi




