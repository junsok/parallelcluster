#!/bin/bash
set -e

echo "Executing $0"

# -------------------------------------------------------
# ComputeNode start script example
# Purpose:
#  - Prepare Enroot runtime environment
#  - Prepare Pyxis runtime directory
#  - Handle Ubuntu 24.04 AppArmor restriction for Enroot
# -------------------------------------------------------

# Configure Enroot directories
ENROOT_PERSISTENT_DIR="/var/enroot"
ENROOT_VOLATILE_DIR="/run/enroot"
ENROOT_CONF_DIR="/etc/enroot"

sudo mkdir -p $ENROOT_PERSISTENT_DIR
sudo chmod 1777 $ENROOT_PERSISTENT_DIR

sudo mkdir -p $ENROOT_VOLATILE_DIR
sudo chmod 1777 $ENROOT_VOLATILE_DIR

sudo mkdir -p $ENROOT_CONF_DIR
sudo chmod 1777 $ENROOT_CONF_DIR

# Apply example Enroot configuration
sudo cp -a /opt/parallelcluster/examples/enroot/enroot.conf /etc/enroot/enroot.conf
sudo chmod 0644 /etc/enroot/enroot.conf


# Configure Pyxis runtime directory
PYXIS_RUNTIME_DIR="/run/pyxis"

sudo mkdir -p $PYXIS_RUNTIME_DIR
sudo chmod 1777 $PYXIS_RUNTIME_DIR 


# Ubuntu 24.04 workaround for Enroot
# AppArmor blocks unprivileged user namespaces
# which are required by Enroot runtime

source /etc/os-release

if [ "${ID}${VERSION_ID}" == "ubuntu24.04" ]; then
    echo "kernel.apparmor_restrict_unprivileged_userns = 0" \
        | sudo tee /etc/sysctl.d/99-pcluster-disable-apparmor-restrict-unprivileged-userns.conf

    sudo sysctl --system
fi