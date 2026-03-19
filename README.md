# MonitorHub

Prometheus 监控栈镜像自动同步到阿里云

## 镜像列表

| 组件 | 原镜像 | 阿里云镜像 |
|------|--------|------------|
| Prometheus | prom/prometheus:v2.47.0 | registry.cn-hangzhou.aliyuncs.com/wenty/prometheus:v2.47.0 |
| Grafana | grafana/grafana:10.0.0 | registry.cn-hangzhou.aliyuncs.com/wenty/grafana:10.0.0 |
| AlertManager | prom/alertmanager:v0.26.0 | registry.cn-hangzhou.aliyuncs.com/wenty/alertmanager:v0.26.0 |
| PushGateway | prom/pushgateway:v1.6.0 | registry.cn-hangzhou.aliyuncs.com/wenty/pushgateway:v1.6.0 |
| Blackbox Exporter | prom/blackbox-exporter:v0.24.0 | registry.cn-hangzhou.aliyuncs.com/wenty/blackbox-exporter:v0.24.0 |
| SNMP Exporter | prom/snmp-exporter:v0.24.1 | registry.cn-hangzhou.aliyuncs.com/wenty/snmp-exporter:v0.24.1 |
| Node Exporter | prom/node-exporter:v1.6.1 | registry.cn-hangzhou.aliyuncs.com/wenty/node-exporter:v1.6.1 |
| cAdvisor | gcr.io/cadvisor/cadvisor:v0.47.2 | registry.cn-hangzhou.aliyuncs.com/wenty/cadvisor:v0.47.2 |

## 使用方法

### 1. 配置阿里云镜像仓库

确保阿里云容器镜像服务已开通，并创建命名空间 `wenty`

### 2. 配置 GitHub Secrets

在仓库 Settings → Secrets 中添加：
- `ALIYUN_USERNAME`: 阿里云账号
- `ALIYUN_PASSWORD`: 阿里云镜像仓库密码

### 3. 触发同步

- 自动：每天凌晨 2 点执行
- 手动：Actions 页面点击 "Run workflow"

## 使用镜像

```bash
# 拉取示例
docker pull registry.cn-hangzhou.aliyuncs.com/wenty/prometheus:v2.47.0

# docker-compose 示例
services:
  prometheus:
    image: registry.cn-hangzhou.aliyuncs.com/wenty/prometheus:v2.47.0
```

## 自动化特性

- ✅ 每天自动检查同步
- ✅ 支持手动触发
- ✅ 镜像已存在则跳过
- ✅ 支持强制重建
- ✅ 多架构支持 (amd64/arm64)
- ✅ 构建缓存加速
