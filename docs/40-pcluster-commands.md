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