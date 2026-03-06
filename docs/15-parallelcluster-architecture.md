# ParallelCluster Architecture
## Static GPU Cluster (AWS GPU 사업)

```
User
 │
 │ SSH
 ▼
Login Node
 │
 ▼
Head Node
 │
 │ Slurm Scheduler
 ▼
Compute Nodes (Static GPU)
 │
 ▼
FSx Lustre
```

### 특징
- Static Node
- Capacity Reservation
- Login Node 존재
- GPU 연구용 환경

---

## Dynamic HPC Cluster (IBS PoC)

```
User
 │
 │ SSH
 ▼
Head Node
 │
 │ Slurm Scheduler
 ▼
Dynamic Compute Nodes
 │
 │ (MinCount=0 → MaxCount)
 ▼
EFA Network
 │
 ▼
FSx Lustre
```

### 특징
- Dynamic Node
- Slurm Scale-out
- EFA 사용
- HPC 워크로드