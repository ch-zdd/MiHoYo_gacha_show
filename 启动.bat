@echo off
echo 正在当前目录启动支持局域网访问的Python HTTP服务器...

:: 获取本机局域网IP地址
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "169.254."') do (
    set "local_ip=%%a"
    goto :found_ip
)
:found_ip
set "local_ip=%local_ip: =%"  :: 去除IP中的空格

echo 服务器运行地址：
echo - 本地访问：http://localhost:8000
echo - 局域网访问：http://%local_ip%:8000（其他设备使用此地址）
echo.
echo 按 Ctrl+C 可停止服务器
echo.

:: 启动服务器前先自动打开本地网页
start http://localhost:8000

:: 启动服务器并绑定到所有网络接口（支持局域网访问）
python -m http.server 8000 --bind 0.0.0.0

:: 暂停以查看可能的错误信息
pause
    