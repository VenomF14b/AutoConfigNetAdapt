
@echo off
cls
echo ###########################################################
echo #                                                         #
echo #          #### NETWORK Settings BY Venom ####            #
echo #                                                         #
echo ###########################################################
echo Choose: 
echo [1] Internal (Office USE)
echo [2] DHCP (HOME)
:choice 
SET /P C=[Please enter a number]? 
for %%? in (1) do if /I "%C%"=="%%?" goto 1 
for %%? in (2) do if /I "%C%"=="%%?" goto 2 

:1 
@ECHO OFF 
netsh interface ip set address "Wi-Fi" static 192.168.0.98 255.255.255.0 192.168.0.200 1
netsh interface ip set dnsservers "Wi-Fi" static 192.168.0.200 validate=no
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" ^
    /v ProxyEnable /t REG_DWORD /d 1 /f
ipconfig /renew
netsh int ip show config pause
echo Please wait 10 sec while the network adaptor refresh !
timeout /t 2
netsh interface set interface "Wi-Fi" DISABLED
timeout /t 2
netsh interface set interface "Wi-Fi" ENABLED
goto end

:2

ECHO Resetting IP Address and Subnet Mask For DHCP
netsh int ip set address name = "Wi-Fi" source = dhcp
netsh interface ip set dns "Wi-Fi" dhcp
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" ^
    /v ProxyEnable /t REG_DWORD /d 0 /f
ipconfig /renew

echo Please wait 10 sec while the network adaptor refresh !
timeout /t 2
netsh interface set interface "Wi-Fi" DISABLED
timeout /t 2
netsh interface set interface "Wi-Fi" ENABLED

goto end

:end