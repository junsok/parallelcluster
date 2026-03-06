#!/bin/bash

echo "===== mount ====="
mount | grep fsx

echo
echo "===== df ====="
df -h | grep fsx

echo
echo "===== lustre ====="
lfs df -h /fsx
