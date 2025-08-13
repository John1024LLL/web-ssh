FROM golang:1.21-alpine

# 安装 bash 和 openssh-client
RUN apk add --no-cache bash openssh-client

# 下载 GoTTY 最新二进制（替换为最新版本链接）
RUN wget https://github.com/sorenisanerd/gotty/releases/download/v1.6.0/gotty_v1.6.0_linux_amd64.tar.gz -O gotty.tar.gz \
    && tar -xzf gotty.tar.gz \
    && mv gotty /usr/local/bin/gotty \
    && chmod +x /usr/local/bin/gotty \
    && rm gotty.tar.gz

# 创建测试用户（用户名 user，密码 password）
RUN adduser -D user && echo "user:password" | chpasswd

# 暴露 Render 默认端口
EXPOSE 8080

# 以 user 身份运行 gotty，启动 bash 终端，允许匿名访问不安全，实际部署建议加认证
CMD ["gotty", "--port", "8080", "--permit-write", "--credential", "user:password", "bash", "-l"]

