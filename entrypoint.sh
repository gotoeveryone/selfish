#!/bin/bash

set -e

if [ "$SSM_ACTIVATE" = "true" ]; then
  ACTIVATE_PARAMETERS=$(aws ssm create-activation \
    --default-instance-name bastion \
    --description bastion \
    --iam-role "service-role/AmazonEC2RunCommandRoleForManagedInstances" \
    --tags "Key=From,Value=selfish" \
    --region ap-northeast-1 \
    --registration-limit 5)

  ACTIVATE_CODE=$(echo $ACTIVATE_PARAMETERS | jq -r .ActivationCode)
  ACTIVATE_ID=$(echo $ACTIVATE_PARAMETERS | jq -r .ActivationId)
  amazon-ssm-agent -register -code "${ACTIVATE_CODE}" -id "${ACTIVATE_ID}" -region "ap-northeast-1" -y

  echo "activateId is ${ACTIVATE_ID}"

  amazon-ssm-agent
fi
