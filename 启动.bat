@echo off
echo ���ڵ�ǰĿ¼����֧�־��������ʵ�Python HTTP������...

:: ��ȡ����������IP��ַ
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "169.254."') do (
    set "local_ip=%%a"
    goto :found_ip
)
:found_ip
set "local_ip=%local_ip: =%"  :: ȥ��IP�еĿո�

echo ���������е�ַ��
echo - ���ط��ʣ�http://localhost:8000
echo - ���������ʣ�http://%local_ip%:8000�������豸ʹ�ô˵�ַ��
echo.
echo �� Ctrl+C ��ֹͣ������
echo.

:: ����������ǰ���Զ��򿪱�����ҳ
start http://localhost:8000

:: �������������󶨵���������ӿڣ�֧�־��������ʣ�
python -m http.server 8000 --bind 0.0.0.0

:: ��ͣ�Բ鿴���ܵĴ�����Ϣ
pause
    