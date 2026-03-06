# ParallelCluster Config Examples

본 디렉터리는 AWS ParallelCluster cluster configuration example을 포함한다.

---

파일
cluster-config-static-gpu-example.yaml
## Static GPU Cluster

- 고정 Compute Node
- Capacity Reservation 기반
- LoginNode 포함

---

파일
cluster-config-dynamic-hpc-example.yaml
## Dynamic HPC Cluster

- Slurm 기반 자동 확장
- MinCount = 0
- MaxCount > 0
- EFA 사용

---

모든 설정은 실제 운영값이 아닌 example 값으로 작성되었다.