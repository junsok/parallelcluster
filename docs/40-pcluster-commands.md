# pcluster Commands

본 문서는 AWS ParallelCluster 운영 시 자주 사용하는 pcluster 명령어를 예제 기준으로 정리한다.

## 1. 버전 / 목록 조회

```bash
pcluster version
pcluster list-clusters --region <REGION>
pcluster list-images --region <REGION>
```

## 2. 클러스터 상세 조회

```bash
pcluster describe-cluster --cluster-name <CLUSTER_NAME> --region <REGION>
pcluster get-cluster-stack-events --cluster-name <CLUSTER_NAME> --region <REGION>
```

## 3. 클러스터 생성
```bash
pcluster create-cluster \
  --cluster-name <CLUSTER_NAME> \
  --cluster-configuration cluster-config.yaml \
  --region <REGION>
  ```

## 4. 클러스터 업데이트
```bash
pcluster update-cluster \
  --cluster-name <CLUSTER_NAME> \
  --cluster-configuration cluster-config.yaml \
  --region <REGION>
```

## Dry Run 검증
```bash
pcluster update-cluster \
  --cluster-name <CLUSTER_NAME> \
  --cluster-configuration cluster-config.yaml \
  --region <REGION> \
  --dryrun true
```

## 5. 클러스터 삭제
```bash
pcluster delete-cluster --cluster-name <CLUSTER_NAME> --region <REGION>
```

## 6. 이미지 관련
```bash
pcluster describe-image --image-id <IMAGE_ID> --region <REGION>
```

## 7. 운영 시 자주 보는 목적

| 명령어 | 목적 |
|---|---|
| `describe-cluster` | 현재 반영 상태 확인 |
| `get-cluster-stack-events` | 생성/업데이트 실패 원인 확인 |
| `update-cluster --dryrun true` | 변경 전 검증 |
| `delete-cluster` | 삭제 전 외부 연동 리소스 영향 확인 |


## 8. Available Images 조회

ParallelCluster에서 사용 가능한 AMI 이미지 목록을 조회할 수 있다.

```bash
pcluster list-images --region <REGION>

#OR

pcluster list-official-images --region <REGION>

```

예시 출력:
| ImageName                         | Os         | Arch   |
|----------------------------------|------------|--------|
| aws-parallelcluster-alinux2      | alinux2    | x86_64 |
| aws-parallelcluster-ubuntu2204   | ubuntu2204 | x86_64 |
| aws-parallelcluster-alinux2023   | alinux2023 | x86_64 |

설명:
- ImageName: ParallelCluster에서 사용할 수 있는 이미지 이름
- Os: 운영체제
- Arch: CPU 아키텍처

운영 시 주로 다음을 확인한다.
- 현재 pcluster 버전에서 지원하는 OS
- Custom AMI 생성 기준 OS 선택
- HeadNode / ComputeNode 호환 OS 확인

## 9. 특정 이미지 상세 조회

특정 이미지의 상세 정보를 확인할 수 있다.
```bash
pcluster describe-image \
  --image-id <IMAGE_ID> \
  --region <REGION>
```

확인 가능한 정보:

- ImageId
- OS 정보
- 생성 시간
- 상태(Status)

## 10. Custom Image 생성
ParallelCluster에서는 Custom AMI를 생성하여 클러스터에서 사용할 수 있다.

```bash
pcluster build-image \
  --image-configuration image-config.yaml \
  --image-id <IMAGE_NAME> \
  --region <REGION>
```

주요 사용 목적:
- 패키지 사전 설치
- CUDA / 드라이버 설치
- HPC 라이브러리 구성
- 컨테이너 런타임 준비
