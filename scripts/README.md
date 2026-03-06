# Scripts

본 디렉터리는 AWS ParallelCluster 운영 시 사용할 수 있는 Example 스크립트를 포함한다.

## 목적
- HeadNode / ComputeNode 초기화 예제
- FSx mount 상태 점검
- Cluster 상태 확인
- 운영 점검 및 테스트용 스크립트 제공

## 포함 예제

### headnode-init-example.sh
- HeadNode 구성 완료 시점 예제 스크립트
- 디렉터리 생성
- 환경 변수 파일 생성
- `/fsx` 마운트 확인

### computenode-start-example.sh
- ComputeNode 시작 시점 예제 스크립트
- 호스트명 기록
- `/fsx` 마운트 및 사용량 확인

### computenode-configure-example.sh
- ComputeNode 구성 완료 시점 예제 스크립트
- 작업 디렉터리 생성
- 공용 디렉터리 생성

### check-cluster-status.sh
- `pcluster describe-cluster` 기반 상태 확인 예제 스크립트

## 주의사항
- 모든 스크립트는 Example 용도이다
- 실제 운영값, 계정 정보, 민감한 경로는 포함하지 않는다
- 운영 환경 적용 전 반드시 검토 및 수정이 필요하다