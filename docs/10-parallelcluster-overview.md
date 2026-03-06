# ParallelCluster Overview

본 문서는 AWS ParallelCluster 기반 HPC/AI 연구 환경의 기본 구조를 정리한다.

## 1. ParallelCluster란

AWS ParallelCluster는 HPC(High Performance Computing) 및 AI/ML 워크로드를 위해 AWS 상에서 클러스터 환경을 손쉽게 구성하고 운영할 수 있도록 도와주는 오픈소스 기반 도구이다.

주요 특징:
- HeadNode / ComputeNode 기반 클러스터 구성
- Slurm 등 스케줄러 연동
- FSx for Lustre 등 고성능 스토리지 연동
- 정적(Static) / 동적(Dynamic) 노드 운영 가능
- 클러스터 생성, 수정, 삭제를 CLI 기반으로 관리 가능

## 2. 기본 구성 요소

### HeadNode
- 클러스터 제어 노드
- Slurm Controller 및 관리 기능 수행
- 사용자 접속 및 운영 점검의 기준 노드 역할 수행

### LoginNode
- 사용자 접속 전용 노드
- HeadNode와 역할을 분리하고 싶은 경우 사용
- 주로 Static GPU 환경에서 별도 구성 가능

### ComputeNode
- 실제 Job이 수행되는 노드
- Slurm Scheduler에 의해 자원이 할당됨
- Static 또는 Dynamic 방식으로 운영 가능

### Scheduler
- 본 저장소의 예제는 Slurm 기준으로 작성
- Job 제출, 자원 할당, 큐 관리, 노드 상태 관리 수행

### Shared Storage
- FSx for Lustre를 공용 스토리지로 사용
- HeadNode와 ComputeNode가 동일 경로로 데이터 접근 가능
- 대용량 데이터셋 및 HPC/AI 학습 데이터 공유에 적합

## 3. 운영 방식

### Static Node 방식
- Compute Node 수량이 고정됨
- 일반적으로 `MinCount = MaxCount`
- 상시 자원이 필요한 GPU 연구 환경에 적합
- 예: AWS GPU 사업

### Dynamic Node 방식
- 작업 제출 시 필요한 수량만큼 Compute Node가 확장됨
- 유휴 상태가 되면 자동 축소 가능
- 일반적으로 `MinCount = 0`, `MaxCount > 0`
- HPC 및 일시적 대규모 연산 환경에 적합
- 예: IBS PoC

## 4. 본 저장소 기준 운영 사례

### AWS GPU 사업
- Static GPU Cluster 기반
- LoginNode 포함 가능
- Capacity Reservation 기반 운영 예제 포함
- 상시 연구용 GPU 자원 제공에 적합

### IBS PoC
- Dynamic HPC Cluster 기반
- Slurm 작업 수요에 따라 Compute Node 자동 확장/축소
- EFA 사용 예제 포함
- HPC 중심 워크로드 수행에 적합

## 5. 운영 시 자주 보는 대상

운영 시 일반적으로 다음 항목을 우선적으로 확인한다.

- `pcluster describe-cluster`: 클러스터 현재 상태 확인
- `pcluster get-cluster-stack-events`: 생성/수정 실패 원인 확인
- `sinfo`: Slurm 파티션 및 노드 상태 확인
- `squeue`: 실행 중 / 대기 중 Job 확인
- `scontrol show nodes`: 상세 노드 상태 확인
- `mount`, `df -h`, `lfs df -h`: FSx 마운트 및 Lustre 상태 확인

## 6. Example 문서화 원칙

본 저장소의 모든 문서와 예제 파일은 실제 운영값을 제거한 Example 형식으로 작성한다.

비노출 대상:
- AMI ID
- VPC / Subnet ID
- Security Group ID
- Elastic IP
- SSH KeyName
- S3 Bucket Name
- FSx FileSystemId
- Capacity Reservation ID
- 실제 Cluster Name
- 계정 식별 가능 값

작성 원칙:
- 실제 값 대신 `<PLACEHOLDER>` 또는 `${VARIABLE_NAME}` 사용
- 운영 방식과 구조 위주로 설명
- 외부 공유 시 식별 가능한 정보 제거