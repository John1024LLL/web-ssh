FROM node:18-alpine

# 安装 wetty（Web SSH 终端）
RUN npm install -g wetty

# 创建一个测试用户（用户名：user，密码：password）
RUN adduser -D user && echo "user:password" | chpasswd

# 暴露 Render 默认 HTTP 端口
EXPOSE 8080

# 启动 wetty（绑定 0.0.0.0，让 Render 能访问）
CMD ["wetty", "--base", "/", "--ssh-host", "localhost", "--ssh-user", "user", "--port", "8080", "--allow-iframe"]
