# 使用一个官方的、轻量的Python 3.10基础镜像
# This is a good, modern default for most Python projects.
FROM python:3.10-slim

# 在容器中创建一个名为 /app 的工作目录
# All our work will happen inside this folder.
WORKDIR /app

# 复制依赖文件到工作目录
# We confirmed the project uses 'requirements.txt'. This line is correct.
COPY requirements.txt requirements.txt

# 安装所有在 requirements.txt 中列出的依赖库
# This command reads the file and installs everything.
RUN pip install --no-cache-dir -r requirements.txt

# 将你仓库中的所有代码文件复制到工作目录
# This brings your main.py and other files into the container.
COPY . .

# 声明容器将对外暴露8080端口
# This tells Cloud Run which port our service is listening on. 8080 is a standard.
EXPOSE 8080

# 【最终执行命令】当容器启动时，运行gunicorn服务器来启动你的应用
# This is the most important line.
# "gunicorn" is a production-grade server.
# "--bind 0.0.0.0:8080" makes it accessible from outside on port 8080.
# "main:app" tells gunicorn: "Look for a file named main.py, and inside it, find the Flask app instance named app".
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
