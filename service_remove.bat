@echo off
:: Path check
set scriptPath=%~dp0
set "path_no_spaces=%scriptPath: =%"
if not "%scriptPath%"=="%path_no_spaces%" (
    echo Yol boşluk içeriyor. 
    echo Lütfen script'i boşluk içermeyen bir dizine taşıyın.
    pause
    exit /b
)

:: Yönetici hakları kontrolü
echo Bu dosyanın yönetici haklarıyla çalıştırılması gerekiyor (Sağ tık -> Yönetici olarak çalıştır).
echo Servisi oluşturmak için bir tuşa basın.
pause

set SRVCNAME=zapret

net stop "%SRVCNAME%"
sc delete "%SRVCNAME%"

pause
