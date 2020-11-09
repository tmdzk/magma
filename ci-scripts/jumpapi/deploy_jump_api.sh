#!/usr/bin/env bash
# Copyright (c) 2016-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.
set -ef -o pipefail
DEPLOY_PATH="${pwd}/deploy"
DEPLOY_PATH="${pwd}/"

# Terraforming the server
cd ./terraform
terraform init
terraform apply
cd ..

# Make sure the jumpapi is running
AWS_JUMPAPI_DATA=$(aws --region "us-west-2" ec2 describe-instances --filters '[{"Name":"tag:Name","Values":["jumpapi"]},{"Name":"instance-state-name","Values":["running"]}]')

RESERVATIONS=$(echo "${AWS_JUMPAPI_DATA}" | jq ".Reservations")
if [ "${RESERVATIONS}" == "[]" ]; then
    echo "The JUMPAPI Server isn't up yet. Check your terraform config"
    exit 1
fi

# Figure out the IP address of the VPN server
JUMPAPI_IP=$(echo "${AWS_JUMPAPI_DATA}" | jq -r ".Reservations[0].Instances[0].PublicIpAddress")
echo "JUMPAPI Server: ${JUMPAPI_IP}"


# Provision the jumpapi
cd ./deploy
cat <<EOF > ./hosts
[magma_jumpapi]
jumpapi ansible_host=${JUMPAPI_IP} ansible_user=ubuntu ansible_port=22
EOF

ansible-playbook -i ./vpnhosts -e 'ansible_python_interpreter=/usr/bin/python3' ./jumpapi.yml
echo "Your jumpapi is ready at ${JUMPAPI_IP}!"
