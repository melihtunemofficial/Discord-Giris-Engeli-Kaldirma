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

set BIN=%~dp0bin\
set ARGS=--wf-tcp=443 --wf-udp=443,50000-65535 ^ 
--filter-udp=443 --hostlist=\"%~dp0list-discord.txt\" --dpi-desync=fake --dpi-desync-udplen-increment=10 --dpi-desync-repeats=6 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-fake-quic=\"%BIN%quic_initial_www_google_com.bin\" --new ^ 
--filter-udp=50000-65535 --dpi-desync=fake,tamper --dpi-desync-any-protocol --dpi-desync-fake-quic=\"%BIN%quic_initial_www_google_com.bin\" --new ^ 
--filter-tcp=443 --hostlist=\"%~dp0list-discord.txt\" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls=\"%BIN%tls_clienthello_www_google_com.bin\"

set SRVCNAME=zapret

net stop "%SRVCNAME%"
sc delete "%SRVCNAME%"
sc create "%SRVCNAME%" binPath= "%BIN%winws.exe %ARGS%" DisplayName= "zapret DPI bypass : winws1" start= auto
sc description "%SRVCNAME%" "zapret DPI bypass yazılımı"
sc start "%SRVCNAME%"

pause
