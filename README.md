# AWS ParallelCluster HPC Guide

이 저장소는 AWS ParallelCluster 운영 경험을 바탕으로 정리한 문서, 설정 예제, 운영 스크립트를 관리하기 위한 repository 입니다.

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