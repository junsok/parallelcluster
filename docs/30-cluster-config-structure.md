# Cluster Config Structure

본 문서는 AWS ParallelCluster `cluster-config.yaml`의 주요 구조를 Example 기준으로 설명한다.

## 1. 개요

ParallelCluster는 YAML 기반의 설정 파일을 사용하여 클러스터 구성을 정의한다.

일반적으로 다음과 같은 항목들로 구성된다.

- Imds
- Image
- LoginNodes
- HeadNode
- Scheduling
- SlurmQueues
- ComputeResources
- SharedStorage
- Monitoring
- DevSettings
- Tags

## 2. Imds

인스턴스 메타데이터 서비스(IMDS) 사용 방식을 정의한다.

예시:

```yaml
Imds:
  ImdsSupport: v2.0
```

설명:
v2.0 사용을 권장
보안 강화를 위해 IMDSv2 기준으로 운영


## 3. Image
클러스터 노드의 OS 및 Custom AMI를 정의한다.

예시:
```yaml
Image:
  Os: alinux2023
  CustomAmi: ami-xxxxxxxxxxxxxxxxx
```

설명:
Os: 노드 운영체제 지정
CustomAmi: 사전 구성된 AMI 사용 시 지정
문서에는 실제 AMI ID를 직접 노출하지 않음

운영 포인트:
HeadNode / ComputeNode와 호환되는 AMI인지 확인
Custom AMI 사용 시 pcluster 버전 및 OS 호환성 확인

## 4. LoginNodes
사용자 접속용 LoginNode를 별도로 정의할 때 사용한다.

예시:
```yaml
LoginNodes:
  Pools:
    - Name: login-node
      Count: <LOGIN_NODE_COUNT>
      InstanceType: <LOGIN_INSTANCE_TYPE>
      Networking:
        SubnetIds:
          - <PUBLIC_SUBNET_ID>
        AdditionalSecurityGroups:
          - <SECURITY_GROUP_ID>
```

설명:
사용자 접속 경로를 HeadNode와 분리할 때 사용
주로 Static GPU 환경에서 유용

## 5. HeadNode
클러스터 제어 노드에 대한 설정이다.

```yaml
HeadNode:
  InstanceType: <HEADNODE_INSTANCE_TYPE>
  Ssh:
    KeyName: <SSH_KEY_NAME>
  Networking:
    SubnetId: <PUBLIC_SUBNET_ID>
    AdditionalSecurityGroups:
      - <SECURITY_GROUP_ID>
    ElasticIp: <ELASTIC_IP_OR_PLACEHOLDER>
  LocalStorage:
    RootVolume:
      Size: 800
      Iops: 16000
      Throughput: 1000
      DeleteOnTermination: true
```

설명:
HeadNode 인스턴스 타입
SSH 접속용 KeyName
Subnet / Security Group / Elastic IP
Root Volume 크기 및 성능 설정

운영 포인트:
HeadNode는 운영/점검 기준점이므로 충분한 디스크와 성능 확보 필요
실제 KeyName, EIP, Subnet ID는 문서에 노출하지 않음

## 6. CustomActions
노드 구성 또는 시작 시점에 사용자 정의 스크립트를 실행할 수 있다.

```yaml
CustomActions:
  OnNodeConfigured:
    Script: s3://<S3_BUCKET>/script/headnode-init-example.sh
```

설명:
OnNodeConfigured: 노드 구성 완료 시 실행
OnNodeStart: 노드 시작 시 실행

사용 예:
패키지 설치
디렉터리 생성
환경 변수 설정
점검 로그 기록

## 7. Scheduling
스케줄러 및 Slurm 관련 설정을 정의한다.

```yaml
Scheduling:
  Scheduler: slurm
  SlurmSettings:
    ScaledownIdletime: 60
    QueueUpdateStrategy: DRAIN
    EnableMemoryBasedScheduling: true
    CustomSlurmSettingsIncludeFile: s3://<S3_BUCKET>/script/slurm-settings-example.conf
```

설명:
Scheduler: 스케줄러 종류
ScaledownIdletime: Dynamic Node 유휴 축소 시간
QueueUpdateStrategy: 큐 업데이트 시 동작 방식
EnableMemoryBasedScheduling: 메모리 기반 스케줄링 여부
CustomSlurmSettingsIncludeFile: 별도 Slurm 설정 파일 포함

## 8. SlurmQueues
클러스터 내 Job Queue를 정의한다.

```yaml
SlurmQueues:
  - Name: compute
    Networking:
      SubnetIds:
        - <PRIVATE_SUBNET_ID>
      AdditionalSecurityGroups:
        - <SECURITY_GROUP_ID>
```

설명:
하나 이상의 큐를 정의 가능
큐별로 네트워크, 인스턴스 타입, 확장 방식, CustomActions 분리 가능

## 9. ComputeResources
각 Queue에서 사용할 실제 Compute 자원을 정의한다.

```yaml
ComputeResources:
  - Name: hpc-dynamic
    InstanceType: <HPC_INSTANCE_TYPE>
    MinCount: 0
    MaxCount: <MAX_DYNAMIC_NODE_COUNT>
    Efa:
      Enabled: true

# 또는

ComputeResources:
  - Name: gpu-static
    InstanceType: <GPU_INSTANCE_TYPE>
    MinCount: <STATIC_NODE_COUNT>
    MaxCount: <STATIC_NODE_COUNT>
```

설명:
InstanceType: Compute 노드 타입
MinCount, MaxCount: 노드 수 범위
Dynamic 환경은 보통 MinCount = 0
Static 환경은 보통 MinCount = MaxCount
EFA 사용 시 Efa.Enabled: true

## 10. Capacity Reservation
Static GPU 환경에서 Capacity Reservation을 사용할 수 있다.

```yaml
CapacityReservationTarget:
  CapacityReservationId: <CAPACITY_RESERVATION_ID>
```

설명:
특정 인스턴스 자원을 사전에 확보한 상태로 운영 가능
상시 사용형 GPU 환경에서 유용

## 11. SharedStorage
공용 스토리지 설정이다.

```yaml
SharedStorage:
  - MountDir: /fsx
    Name: fsx
    StorageType: FsxLustre
    FsxLustreSettings:
      FileSystemId: <FSX_FILE_SYSTEM_ID>
```

설명:
FSx for Lustre를 /fsx로 마운트
HeadNode / ComputeNode가 동일 경로로 사용

운영 포인트:
실제 FileSystemId는 문서에 직접 노출하지 않음
마운트 후 mount, df -h, lfs df -h 등으로 확인

## 12. Monitoring
CloudWatch Logs 및 Dashboard 설정이다.

```yaml
Monitoring:
  DetailedMonitoring: true
  Logs:
    CloudWatch:
      Enabled: true
  Dashboards:
    CloudWatch:
      Enabled: true
```

설명:
상세 모니터링 사용 여부
CloudWatch Logs 수집 여부
CloudWatch Dashboard 생성 여부

## 13. DevSettings
운영/부트스트랩 관련 timeout 설정을 정의할 수 있다.

```yaml
DevSettings:
  Timeouts:
    HeadNodeBootstrapTimeout: 3600
```
설명:
HeadNode 구성 시간이 오래 걸리는 환경에서 timeout 조정 가능

## 14. Tags
클러스터 리소스에 공통 태그를 지정한다.

```yaml
Tags:
  - Key: Environment
    Value: example
```

설명:
운영 환경 구분
비용 관리 및 자원 식별에 유용

## 15. 정리
Cluster Config는 단순한 YAML 파일이 아니라 클러스터 전체 구조를 정의하는 핵심 설정이다.
따라서 운영 시에는 아래 순서로 접근하는 것이 좋다.

1. Image / HeadNode / Networking 구조 확인
2. Scheduling / SlurmQueues / ComputeResources 구조 확인
3. SharedStorage / Monitoring / CustomActions 확인
4. 변경 전 pcluster update-cluster --dryrun true 수행
5. 변경 후 Slurm / FSx / 로그 상태 검증