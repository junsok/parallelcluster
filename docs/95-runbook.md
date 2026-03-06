본 문서는 AWS ParallelCluster 운영 시 기본 절차를 정리한 Runbook이다.

## 1. 현재 상태 확인

```bash
pcluster describe-cluster --cluster-name <CLUSTER_NAME> --region <REGION>
```

## 2. 클러스터 업데이트
1. cluster-config.yaml 수정
2. 변경사항 검토

dry-run 수행
```bash
pcluster update-cluster \
  --cluster-name <CLUSTER_NAME> \
  --cluster-configuration cluster-config.yaml \
  --region <REGION> \
  --dryrun true

# 문제 없으면 update 수행

pcluster update-cluster \
  --cluster-name <CLUSTER_NAME> \
  --cluster-configuration cluster-config.yaml \
  --region <REGION>
```

## 3. 업데이트 후 검증

Cluster 상태 확인
```bash
pcluster describe-cluster
```

노드 확인
```bash
scontrol show nodes
```

FSx 확인
```bash
mount | grep fsx
df -h
```
## 4. 장애 발생 시
1. CloudFormation Stack Event 확인
2. HeadNode bootstrap 로그 확인
3. CustomActions 로그 확인
4. Slurm 상태 확인

