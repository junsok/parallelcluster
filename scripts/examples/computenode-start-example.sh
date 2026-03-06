#!/bin/bash
set -euo pipefail

LOG_FILE="/var/log/computenode-start-example.log"

echo "[INFO] $(date '+%F %T') compute node start" | tee -a "${LOG_FILE}"
echo "[INFO] hostname: $(hostname)" | tee -a "${LOG_FILE}"

echo "[INFO] checking /fsx mount" | tee -a "${LOG_FILE}"
mount | grep /fsx | tee -a "${LOG_FILE}" || true

echo "[INFO] checking filesystem usage" | tee -a "${LOG_FILE}"
df -h | grep /fsx | tee -a "${LOG_FILE}" || true

echo "[INFO] compute node start script complete" | tee -a "${LOG_FILE}"