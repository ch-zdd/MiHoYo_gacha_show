@echo off
chcp 65001 >nul 2>&1  # ���ñ���ΪUTF-8��ȷ������������ʾ

echo ==============================================
echo           JSON�ļ��Զ����¹���
echo ==============================================
echo.

:: ���Python�Ƿ�װ
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo ����δ�ҵ�Python���������Ȱ�װPython����ӵ���������
    echo.
    pause
    exit /b 1
)

:: ���requests���Ƿ�װ
python -c "import requests" >nul 2>&1
if %errorlevel% neq 0 (
    echo ��⵽ȱ�ٱ�Ҫ��������ڰ�װ...
    pip install requests --quiet
    if %errorlevel% neq 0 (
        echo ���󣺰�װrequests��ʧ�ܣ����ֶ�ִ�� pip install requests
        echo.
        pause
        exit /b 1
    )
)

:: ִ��Python�ű�
echo ��ʼִ�и��²���...
echo.
python "update_config.py"

:: ��ʾִ�н��
echo.
if %errorlevel% equ 0 (
    echo ������ɣ�JSON�ļ����³ɹ�
) else (
    echo ������ɣ�JSON�ļ�����ʧ�ܣ���鿴update_log.txt��ȡ��ϸ��Ϣ
)

echo.
echo ==============================================
echo ��������رմ���...
pause >nul
    