#!/bin/bash
VARIABLE="${1}"
# export AWS_ACCESS_KEY_ID=?
# export AWS_SECRET_ACCESS_KEY=?
# export AWS_DEFAULT_REGION=?
echo $( aws secretsmanager get-secret-value --secret-id "${VARIABLE}" --query SecretString --output text )
exit 0
