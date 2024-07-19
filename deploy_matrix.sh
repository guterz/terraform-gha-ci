#!/bin/bash
set -e

ACCOUNT=$1
REGION=$2
LAYER=$3

cd ${ACCOUNT}/${REGION}/${LAYER}

#tfswitch
terraform init

if [[ "$BRANCH_NAME" == "main" ]] ; then
  terraform apply -auto-approve
else
  terraform plan
fi
