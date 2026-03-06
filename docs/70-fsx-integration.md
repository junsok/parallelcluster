# FSx Integration

본 문서는 AWS ParallelCluster 환경에서 FSx for Lustre를 연동하고 운영 시 확인하는 기본 항목을 정리한다.

## 1. 개요

FSx for Lustre는 HPC 및 AI/ML 워크로드에서 자주 사용하는 고성능 병렬 파일 시스템이다.

ParallelCluster에서는 SharedStorage로 연동하여 HeadNode와 ComputeNode가 동일한 경로로 데이터를 공유할 수 있다.

주요 용도:
- 학습 데이터 공유
- 결과 파일 저장
- 공용 작업 디렉터리 운영
- 대용량 파일 처리

## 2. Example 구성

예시:

```yaml
SharedStorage:
  - MountDir: /fsx
    Name: fsx
    StorageType: FsxLustre
    FsxLustreSettings:
      FileSystemId: <FSX_FILE_SYSTEM_ID>
```

설명:
MountDir: 마운트 경로
StorageType: FSx Lustre 사용
FileSystemId: 실제 FSx ID는 문서에 노출하지 않음

## 3. 운영 시 기본 확인 명령

마운트 확인
```bash
mount | grep fsx
```

파일시스템 사용량 확인
```bash
df -h | grep fsx
```

Lustre 용량 확인
```bash
lfs df -h /fsx
```

Lustre inode 확인
```bash
lfs df -i /fsx
```
## 4. HeadNode / ComputeNode 확인

운영 시에는 HeadNode뿐 아니라 ComputeNode에서도 FSx가 정상적으로 보이는지 확인해야 한다.

확인 포인트:
동일 마운트 경로 사용 여부
읽기/쓰기 가능 여부
Job 수행 시 /fsx 접근 가능 여부
Dynamic Node 생성 후에도 정상 마운트 되는지 여부

## 5. 운영 예시

테스트 파일 생성
```bash
touch /fsx/test_file
ls -l /fsx/test_file
```

쓰기 테스트
```bash
echo "fsx test" > /fsx/test_write.txt
cat /fsx/test_write.txt
```

ComputeNode에서 확인
```bash
srun -N 1 -n 1 hostname
srun -N 1 -n 1 ls -l /fsx
```

## 6. 장애 시 확인 포인트

- 마운트가 안 보이는 경우

```bash
mount | grep fsx # 확인
df -h # 확인
```
SharedStorage 설정 확인
HeadNode / ComputeNode 부트스트랩 로그 확인

- Lustre 명령이 실패하는 경우

```bash
lfs df -h /fsx #확인
```
Lustre client 상태 확인
네트워크 / 보안 그룹 영향 여부 확인

- Dynamic Node에서만 문제인 경우

ComputeNode 시작 시점 스크립트 확인
Queue / ComputeResource 설정 확인
노드 기동 후 bootstrap / resume 로그 확인

## 7. 운영 팁

- 공용 데이터는 /fsx 기준으로 경로를 통일하는 것이 좋다
- 테스트 Job으로 실제 ComputeNode에서 접근 가능한지 확인한다
- 대용량 데이터 사용 전 용량 및 inode 상태를 함께 본다
- 문제 발생 시 HeadNode만 보지 말고 ComputeNode에서도 확인한다

## 8. 정리

FSx for Lustre는 ParallelCluster 환경에서 공용 고성능 스토리지의 핵심 역할을 한다.
따라서 운영 시에는 다음을 기본으로 점검한다.

- 마운트 정상 여부
- 용량 / inode 상태
- HeadNode / ComputeNode 접근 가능 여부
- Job 수행 시 실제 사용 가능 여부