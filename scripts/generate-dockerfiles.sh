#!/bin/bash
# 生成各个镜像的专用 Dockerfile

set -e

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DOCKERFILES_DIR="$BASE_DIR/dockerfiles"

mkdir -p "$DOCKERFILES_DIR"

declare -A IMAGES=(
    ["prometheus"]="prom/prometheus:v2.47.0"
    ["grafana"]="grafana/grafana:10.0.0"
    ["alertmanager"]="prom/alertmanager:v0.26.0"
    ["pushgateway"]="prom/pushgateway:v1.6.0"
    ["blackbox-exporter"]="prom/blackbox-exporter:v0.24.0"
    ["snmp-exporter"]="prom/snmp-exporter:v0.24.1"
    ["node-exporter"]="prom/node-exporter:v1.6.1"
    ["cadvisor"]="gcr.io/cadvisor/cadvisor:v0.47.2"
)

TEMPLATE="$DOCKERFILES_DIR/Dockerfile.template"

for name in "${!IMAGES[@]}"; do
    upstream="${IMAGES[$name]}"
    dir="$DOCKERFILES_DIR/$name"
    
    mkdir -p "$dir"
    
    cat > "$dir/Dockerfile" << EOF
# Auto-generated Dockerfile for $name
# Source: $upstream

FROM $upstream

LABEL maintainer="auto-sync"
LABEL source="$upstream"
LABEL sync-date="$(date +%Y-%m-%d)"
EOF

    echo "Generated: $dir/Dockerfile (FROM $upstream)"
done

echo ""
echo "All Dockerfiles generated successfully!"
