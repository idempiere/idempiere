#!/bin/bash
VARIABLE="${1}"
VALUE="${2}"
# export AWS_ACCESS_KEY_ID=?
# export AWS_SECRET_ACCESS_KEY=?
# export AWS_DEFAULT_REGION=?
aws secretsmanager create-secret --name "${VARIABLE}" --secret-string "${VALUE}"
if [ $? != 0 ]
then
    aws secretsmanager update-secret --secret-id "${VARIABLE}" --secret-string "${VALUE}"
fi
