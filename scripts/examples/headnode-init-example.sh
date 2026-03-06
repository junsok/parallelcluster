#!/bin/bash
set -e

echo "Executing $0"

# -------------------------------------------------------
# HeadNode bootstrap example
# Purpose:
#  - Enable Enroot runtime
#  - Configure Pyxis for Slurm container workloads
#  - Apply Slurm plugstack configuration
# -------------------------------------------------------

# Configure Enroot runtime directories
ENROOT_PERSISTENT_DIR="/var/enroot"
ENROOT_VOLATILE_DIR="/run/enroot"

sudo mkdir -p $ENROOT_PERSISTENT_DIR
sudo chmod 1777 $ENROOT_PERSISTENT_DIR
sudo mkdir -p $ENROOT_VOLATILE_DIR
sudo chmod 1777 $ENROOT_VOLATILE_DIR

# Apply example Enroot configuration
# Source path is provided by ParallelCluster examples
sudo cp -a /opt/parallelcluster/examples/enroot/enroot.conf /etc/enroot/enroot.conf
sudo chmod 0644 /etc/enroot/enroot.conf


# Configure Pyxis runtime directory
PYXIS_RUNTIME_DIR="/run/pyxis"

sudo mkdir -p $PYXIS_RUNTIME_DIR
sudo chmod 1777 $PYXIS_RUNTIME_DIR


# Configure Slurm plugstack for Pyxis
sudo mkdir -p /opt/slurm/etc/plugstack.conf.d/

sudo mv /opt/parallelcluster/examples/spank/plugstack.conf /opt/slurm/etc/
sudo mv /opt/parallelcluster/examples/pyxis/pyxis.conf /opt/slurm/etc/plugstack.conf.d/

# Reload Slurm configuration
sudo -i scontrol reconfigure


# Optional Lustre tuning (disabled example)
# systemctl start lustre-tuning.service