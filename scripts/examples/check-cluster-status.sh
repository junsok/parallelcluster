#!/bin/bash
set -euo pipefail

CLUSTER_NAME="${1:-<CLUSTER_NAME>}"
REGION="${2:-<REGION>}"

echo "===== Cluster Status Check ====="
echo "CLUSTER_NAME: ${CLUSTER_NAME}"
echo "REGION      : ${REGION}"
echo

pcluster describe-cluster --cluster-name "${CLUSTER_NAME}" --region "${REGION}"