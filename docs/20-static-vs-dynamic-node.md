# Static vs Dynamic Node

본 문서는 AWS ParallelCluster 환경에서 Static Node 방식과 Dynamic Node 방식의 차이를 정리한다.

## 1. 개요

ParallelCluster에서는 Compute Node를 고정 수량으로 유지할 수도 있고, 필요 시 자동으로 늘어나고 줄어들게 구성할 수도 있다.

본 저장소에서는 아래 두 가지 운영 사례를 기준으로 설명한다.

- Static Node: AWS GPU 사업
- Dynamic Node: IBS PoC

## 2. Static Node

Static Node 방식은 클러스터 생성 후 Compute Node가 고정 수량으로 유지되는 방식이다.

일반적인 특징:
- `MinCount = MaxCount`
- 항상 일정 수량의 노드가 유지됨
- 작업이 없어도 노드가 존재할 수 있음
- 상시 GPU 자원이 필요한 환경에 적합

적합한 예:
- 고정형 연구 환경
- 장시간 사용되는 GPU 개발/실험 환경
- Capacity Reservation과 함께 사용하는 구조

### 장점
- 노드 확보가 안정적
- 사용자가 즉시 자원을 사용할 수 있음
- 워크로드 시작 지연이 적음

### 단점
- 미사용 시간에도 비용 발생 가능
- 자원 유휴 상태가 생길 수 있음

## 3. Dynamic Node

Dynamic Node 방식은 Job이 제출될 때 필요한 노드가 생성되고, 유휴 상태가 되면 자동으로 축소되는 방식이다.

일반적인 특징:
- `MinCount = 0`
- `MaxCount > 0`
- 작업 수요에 따라 노드 수가 변동됨
- HPC 또는 대규모 배치성 연산에 적합

적합한 예:
- 일시적 대규모 연산
- 연구 시점에만 노드가 필요한 환경
- 사용량 중심 과금 구조가 중요한 환경

### 장점
- 비용 효율적
- 필요한 시점에만 자원 사용 가능
- 대규모 Scale-out에 유리

### 단점
- 초기 노드 기동 시간 필요
- 용량 부족, quota 부족, subnet IP 부족 등 외부 요인 영향 가능
- 운영 시 상태 점검 항목이 더 많음

## 4. 비교표

| 항목 | Static Node | Dynamic Node |
|---|---|---|
| 대표 사례 | AWS GPU 사업 | IBS PoC |
| 노드 수 | 고정 | 필요 시 증감 |
| Min / Max | Min = Max | Min = 0, Max > 0 |
| 비용 구조 | 상시 발생 가능 | 사용 시 중심 |
| 적합 워크로드 | 상시 GPU 연구 | HPC / 배치성 작업 |
| 시작 지연 | 적음 | 있을 수 있음 |
| 운영 포인트 | 고정 자원 관리 | Scale-out / Scale-in 관리 |

## 5. 운영 시 확인 포인트

### Static Node 확인 포인트
- Compute Node 수량이 고정 구조인지 확인
- Capacity Reservation 사용 여부 확인
- 상시 비용 발생 구조인지 확인
- LoginNode 포함 여부 확인

### Dynamic Node 확인 포인트
- `MinCount = 0` 구조인지 확인
- `MaxCount`가 요구 수량을 충족하는지 확인
- quota / capacity / subnet IP 여유 확인
- EFA, Placement, 네트워크 구성이 요구사항과 맞는지 확인
- idle 시 자동 축소 동작 여부 확인

## 6. 정리

Static Node는 즉시 사용 가능한 고정형 자원 환경에 적합하고, Dynamic Node는 필요 시 자동 확장되는 비용 효율형 환경에 적합하다.

따라서 운영 목적에 따라 아래처럼 선택하는 것이 일반적이다.

- 상시 GPU 연구 환경 → Static Node
- HPC / 대규모 일시성 작업 환경 → Dynamic Node