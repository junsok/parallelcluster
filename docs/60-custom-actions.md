# ParallelCluster Custom Actions

ParallelCluster에서는 HeadNode 및 ComputeNode에 Custom Script를 실행할 수 있다.

## OnNodeConfigured

노드 구성 완료 시 1회 실행

예시

- 패키지 설치
- 환경 변수 설정
- 디렉터리 생성

```bash
headnode-init-example.sh
```

## OnNodeStart
노드 시작 시 실행

예시
- runtime 환경 설정
- mount 확인
- 로그 기록

```bash
computenode-start-example.sh
```

## 실행 위치

HeadNode
```bash
/var/log/parallelcluster/bootstrap.log
```

ComputeNode
```bash
/var/log/parallelcluster/slurm_resume.log
```

