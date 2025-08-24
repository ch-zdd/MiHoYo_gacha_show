@echo off
chcp 65001 >nul 2>&1  # 设置编码为UTF-8，确保中文正常显示

echo ==============================================
echo           JSON文件自动更新工具
echo ==============================================
echo.

:: 检查Python是否安装
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误：未找到Python环境，请先安装Python并添加到环境变量
    echo.
    pause
    exit /b 1
)

:: 检查requests库是否安装
python -c "import requests" >nul 2>&1
if %errorlevel% neq 0 (
    echo 检测到缺少必要组件，正在安装...
    pip install requests --quiet
    if %errorlevel% neq 0 (
        echo 错误：安装requests库失败，请手动执行 pip install requests
        echo.
        pause
        exit /b 1
    )
)

:: 执行Python脚本
echo 开始执行更新操作...
echo.
python "update_config.py"

:: 显示执行结果
echo.
if %errorlevel% equ 0 (
    echo 操作完成：JSON文件更新成功
) else (
    echo 操作完成：JSON文件更新失败，请查看update_log.txt获取详细信息
)

echo.
echo ==============================================
echo 按任意键关闭窗口...
pause >nul
    