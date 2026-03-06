#!/bin/bash

echo "===== sinfo ====="
sinfo

echo
echo "===== nodes ====="
scontrol show nodes | egrep "NodeName=|State=|CfgTRES="
