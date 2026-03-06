# Update / Scale Operation Checklist

## 1. 변경 전 공통 확인
- 현재 cluster-config 백업
- 현재 `pcluster describe-cluster` 결과 확인
- HeadNode 상태 확인
- Slurm queue / node 상태 확인
- FSx 마운트 상태 확인
- CloudWatch 로그 확인 가능 여부 확인
- CustomActions 경로 및 스크립트 존재 여부 확인
- 실제값이 아닌 example 값으로 문서화 중인지 확인

## 2. Static Node 환경 확인
- MinCount / MaxCount가 동일한 구조인지 확인
- 고정 수량 변경이 필요한지 확인
- Capacity Reservation 사용 여부 확인
- 상시 비용 발생 구조인지 확인

## 3. Dynamic Node 환경 확인
- MinCount=0 구조인지 확인
- MaxCount 변경 필요 여부 확인
- EFA 사용 여부 확인
- Scale-out 시 quota / capacity 영향 확인
- idle scale-down 영향 확인

## 4. 업데이트 전 검증
- YAML 문법 확인
- `pcluster update-cluster --dryrun true` 수행
- Custom AMI 호환성 확인
- OS 호환성 확인
- S3 script path 확인

## 5. 변경 후 검증
- `pcluster describe-cluster` 확인
- `sinfo` 확인
- `scontrol show nodes` 확인
- 테스트 job 제출
- `/fsx` 접근 확인
- CloudWatch Logs 확인

## 6. 장애 시 확인 우선순위
1. Stack event 확인
2. HeadNode bootstrap / custom action 로그 확인
3. Slurm 상태 확인
4. Compute node 기동 상태 확인
5. FSx mount 상태 확인