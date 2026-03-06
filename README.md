# AWS ParallelCluster HPC Guide

## What I Built

This repository documents how I designed and operated AWS ParallelCluster environments for HPC and AI workloads.

Key areas covered:

- Static GPU Cluster architecture for AI research workloads
- Dynamic HPC Cluster architecture with automatic scaling
- Slurm scheduler configuration and operational commands
- FSx for Lustre integration for shared high-performance storage
- Cluster bootstrap automation using CustomActions scripts
- ParallelCluster operational runbooks and troubleshooting guides

## Real Project Context

The examples in this repository are based on real environments I worked on:

### GPU AI Research Cluster
- Static GPU compute nodes
- Capacity Reservation based architecture
- LoginNode + HeadNode separation
- Container workloads using Pyxis + Enroot

### HPC PoC Cluster
- Dynamic compute nodes
- MinCount=0 autoscaling architecture
- EFA enabled networking
- Slurm-based HPC workloads

## 범위
- Static GPU Cluster 운영 예제
- Dynamic HPC Cluster 운영 예제
- Slurm 기반 스케줄링 운영
- FSx for Lustre 연동
- pcluster 명령어 정리
- 운영 체크리스트 / Runbook / Troubleshooting

## 프로젝트 기준
### 1) AWS GPU 사업
- Static Node 기반
- LoginNode 포함
- Capacity Reservation 기반 운영 예제
- Compute Node 수량 고정 예제

### 2) IBS PoC
- Dynamic Node 기반
- Slurm 작업 수요에 따라 Compute Node 자동 확장/축소
- EFA 사용 예제
- HPC 워크로드 중심 운영 예제

## Repository Structure
```text
docs/      # 운영 문서
configs/   # cluster config / slurm settings example
scripts/   # 운영 및 점검용 example script

## Skills Demonstrated

This repository demonstrates experience with:

- AWS ParallelCluster
- HPC infrastructure design
- Slurm scheduler operations
- FSx for Lustre
- EFA networking
- Cluster bootstrap automation
- Linux system administration
- Infrastructure documentation