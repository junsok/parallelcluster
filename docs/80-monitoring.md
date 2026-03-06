# Monitoring

ParallelCluster 환경에서는 CloudWatch Logs 및 Dashboard를 통해 상태를 모니터링한다.

## HeadNode 상태 확인

```bash
pcluster describe-cluster --cluster-name <CLUSTER_NAME>
```
## Slurm 상태 확인

```bash
sinfo
squeue
scontrol show nodes
```

## Compute Node 확인

확인 항목
- node state
- cpu allocation
- memory usage

## FSx 상태
```bash
mount | grep fsx
lfs df -h
lfs df -i
```
