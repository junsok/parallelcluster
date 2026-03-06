#!/bin/bash
#SBATCH -J scale-test
#SBATCH -p compute
#SBATCH -N 2
#SBATCH --ntasks-per-node=1
#SBATCH -t 00:10:00

hostname
scontrol show hostnames "$SLURM_JOB_NODELIST"

sleep 60