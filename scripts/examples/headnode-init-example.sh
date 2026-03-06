#!/bin/bash
set -euo pipefail

LOG_FILE="/var/log/headnode-init-example.log"

echo "[INFO] $(date '+%F %T') headnode init start" | tee -a "${LOG_FILE}"
echo "[INFO] hostname: $(hostname)" | tee -a "${LOG_FILE}"

mkdir -p /shared/admin/scripts
mkdir -p /shared/admin/logs

cat >/etc/profile.d/cluster-env.sh <<'EOF'
export CLUSTER_ENV=example
export SHARED_FS=/fsx
EOF

chmod +x /etc/profile.d/cluster-env.sh

echo "[INFO] checking /fsx mount" | tee -a "${LOG_FILE}"
mount | grep /fsx | tee -a "${LOG_FILE}" || true

echo "[INFO] headnode init complete" | tee -a "${LOG_FILE}"