# 基础镜像
FROM debian:stable-slim

# 安装 Shadowsocks-libev
RUN apt-get update \
    && apt-get install -y shadowsocks-libev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 创建配置文件目录
RUN mkdir -p /etc/shadowsocks

# 写入默认配置文件
RUN echo '{
    "server": "0.0.0.0",
    "server_port": 8388,
    "password": "123456789",
    "method": "aes-256-gcm",
    "timeout": 300,
    "fast_open": true
}' > /etc/shadowsocks/config.json

# 开放 Shadowsocks 端口
EXPOSE 8388

# 启动命令
CMD ["ss-server", "-c", "/etc/shadowsocks/config.json", "-u"]
