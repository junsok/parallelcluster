#!/bin/bash
set -euo pipefail

LOG_FILE="/var/log/computenode-configure-example.log"

echo "[INFO] $(date '+%F %T') compute node configure start" | tee -a "${LOG_FILE}"

mkdir -p /scratch/work || true
chmod 1777 /scratch/work || true

mkdir -p /fsx/shared/example || true

echo "[INFO] hostname: $(hostname)" | tee -a "${LOG_FILE}"
echo "[INFO] compute node configure complete" | tee -a "${LOG_FILE}"