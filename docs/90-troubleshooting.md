# Troubleshooting

## 1. update-cluster 실패

확인 항목

- YAML 문법 오류
- Custom AMI 호환성
- IAM 권한
- Subnet / SG 설정

확인 명령

```bash
pcluster get-cluster-stack-events \
--cluster-name <CLUSTER_NAME>
```

## 2. Compute Node 생성 안됨
가능 원인

- instance quota 부족
- subnet IP 부족
- capacity 부족

```bash
sinfo
scontrol show nodes
```

## 3. FSx mount 실패
```bash
mount | grep fsx

# 또는

lfs df -h

```

## 4. Slurm 노드 상태 이상

slurm 상태 확인
Path: scripts/examples/check-slurm-nodes.sh


```bash
sinfo -N

DOWN
IDLE~
POWERING_UP
```
## 4-1. FSx 상태 확인
파일경로
scripts/examples/check-fsx-mount.sh

## 4-2. Scale 테스트 Job
파일경로
scripts/examples/scale-test-job.sh



