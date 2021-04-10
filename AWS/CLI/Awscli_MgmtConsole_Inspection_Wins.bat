::::::::::::::::::::::::::::::::::::::: Common Area:::::::::::::::::::::::::::::::::::::::::::

@echo off

setlocal
set infosec=C:\infosec
set john=%infosec%\john
set script=%infosec%\script

rem ��ũ��Ʈ ���� �� �׸� ī��Ʈ �����ֱ� ���� ����df
set item_count=0

TITLE Windosws Security Check

::���� ���� Ȯ�� ����
ver > ver.txt
for /f "delims=[ tokens=2" %%i in (ver.txt) do set MV=%%i
del ver.txt 2> nul

if exist %windir%\SysWOW64 (
	set WinBit=64
) else (
	set WinBit=32
)

:: windows 2000
if "%MV:~8,3%"=="5.0" (
	set WinVer=1
	set WinVer_name=2000
	echo Windows 2000 %WinBit%bit                                                            > %infosec%\real_ver.txt
)

:: windows 2003
if "%MV:~8,3%"=="5.2" (
	set WinVer=2
	set WinVer_name=2003
	echo Windows 2003 %WinBit%bit                                                            > %infosec%\real_ver.txt
)

:: windows 2008
if "%MV:~8,3%"=="6.0" (
	set WinVer=3
	set WinVer_name=2008
	echo Windows 2008 %WinBit%bit                                                            > %infosec%\real_ver.txt
)

:: windows 2008 r2
if "%MV:~8,3%"=="6.1" (
	set WinVer=4
	set WinVer_name=2008_R2
	echo Windows 2008 R2 %WinBit%bit                                                         > %infosec%\real_ver.txt
)

:: windows 2012
if "%MV:~8,3%"=="6.2" (
	set WinVer=5
	set WinVer_name=2012
	echo Windows 2012 %WinBit%bit                                                            > %infosec%\real_ver.txt
)

:: windows 2012 r2
if "%MV:~8,3%"=="6.3" (
	set WinVer=6
	set WinVer_name=2012_R2
	echo Windows 2012 R2 %WinBit%bit                                                         > %infosec%\real_ver.txt
)

:: windows 2016
if "%MV:~8,4%"=="10.0" (
	set WinVer=7
	set WinVer_name=2016
	echo Windows 2016 %WinBit%bit                                                         > %infosec%\real_ver.txt
)

type real_ver.txt > %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:: windows 2008 �̻������ icacls
if %WinVer% geq 3 (
	doskey cacls=icacls $*
)
::���� ���� Ȯ�� ��




set SCRIPT_LAST_UPDATE=2017.09.01
echo ======================================================================================= >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��������������������      Windows %WinVer_name% Security Check      ��������������������� >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��������������������      Copyright �� 2017, SK Infosec Co. Ltd.    ��������������������� >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ======================================================================================= >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo LAST_UPDATE %SCRIPT_LAST_UPDATE%                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �������������������������������������  Start Time  �������������������������������������  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
date /t                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
time /t                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt     
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
::sysinfo �ѱ�(chcp 437���� �ѱ� ??�� ���� ���� ����)
echo [+] Gathering systeminfo...
systeminfo																					 > %infosec%\systeminfo_ko.txt 2>nul

::�������� ����
chcp 437

::���� �������� ����
secedit /EXPORT /CFG Local_Security_Policy.txt >nul
net accounts > %infosec%\net-accounts.txt 



echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 1.1 START                                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################        Avoid the use of the "root" account         ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: Administrator ���� �̸��� �����Ͽ� ����ϴ� ��� ��ȣ                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net localgroup Administrators | findstr /V "Comment Members completed" | findstr .           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

net localgroup Administrators | findstr /V "Comment Members completed" | findstr .           > %infosec%\1.01-result.txt
type 1.01-result.txt | findstr /V "Alias name" | findstr /i administrator | findstr .        > %infosec%\result.txt

net localgroup Administrators | findstr /V "Comment Members completed" | findstr . | findstr /V "Alias name" | findstr /i administrator | findstr . > nul
if %errorlevel% equ 0 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=Administrator																		>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O																				>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
del %infosec%\1.01-result.txt 2>nul
del %infosec%\result.txt 2>nul

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0101 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0102 START                                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #################               GUEST ���� ����                ######################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: Guest ���� ��Ȱ��ȭ�� ��� ��ȣ                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net user guest | find "User name"                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net user guest | find "Account active"                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

net user guest | find "Account active" | %script%\awk -F" " {print$3}        >> %infosec%\result.txt

net user guest | find "Account active" | find "Yes" > nul
if %errorlevel% equ 0 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=Yes												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=No												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

del %infosec%\result.txt 2>nul

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0102 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0103 START                                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################              ���ʿ��� ���� ����               ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ���ʿ��� ������ �������� ���� ���                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ****************************  User Accounts List  *****************************         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net user | find /V "successfully" | findstr .                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *****************************  Account Information  ***************************         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        > %infosec%\account.txt 2>nul
FOR /F "tokens=1,2,3 skip=4" %%i IN ('net user') DO (
echo -------------------------------------------------------------------------------         >> %infosec%\account.txt 2>nul
net user %%i >> account.txt 2>nul
echo -------------------------------------------------------------------------------         >> %infosec%\account.txt 2>nul
net user %%j >> account.txt 2>nul
echo -------------------------------------------------------------------------------         >> %infosec%\account.txt 2>nul
net user %%k >> account.txt 2>nul
)
findstr "User active Comment Last --" account.txt                                            > %infosec%\account_temp1.txt
findstr /v "change profile Memberships User's" account_temp1.txt                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0103 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0104 START                                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################            ���� ��� �Ӱ谪 ����             ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �α׿� ���� ���� �����ϴ� ���� ��� �Ӱ谪�� 5�� ���Ϸ� �����Ǿ� ������ ��ȣ          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type net-accounts.txt | find "Lockout threshold"                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


type net-accounts.txt | find "Lockout threshold" | %script%\awk -F" " {print$3}        		> %infosec%\result.txt

type %infosec%\result.txt | find /i "never" > nul
if %errorlevel% neq 1 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=Never												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
)


echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\result.txt 2>nul

echo 0104 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0105 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################    �ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ ����    ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "�ص� ������ ��ȣȭ�� ����Ͽ� ��ȣ ����" ��å�� "������"���� �����Ǿ� ������ ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (ClearTextPassword = 0 �� ��� ��ȣ)                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type Local_Security_Policy.txt | Find /I "ClearTextPassword"                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type Local_Security_Policy.txt | Find /I "ClearTextPassword"  |  %script%\awk -F" " {print$3}    >> %infosec%\result.txt

for /f "delims= tokens=1" %%r in (result.txt) do set result=%%r
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=%result%												 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


echo 0105 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0106 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################      ������ �׷쿡 �ּ����� ����� ����        ##################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: Administrators �׷쿡 ���ʿ��� ������ ���� ���� ���� ��� ��ȣ                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net localgroup Administrators | findstr /V "Comment Members completed" | findstr .           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        > %infosec%\admin-account.txt 2>nul
echo *********************  Administrators Account Information  ********************         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
FOR /F "tokens=1,2,3,4 skip=6" %%j IN ('net localgroup administrators') DO (
net user %%j %%k %%l %%m >> %infosec%\admin-account.txt 2>nul
echo -------------------------------------------------------------------------------         >> %infosec%\admin-account.txt 2>nul
)
findstr c/:"User name | Account active | Last logon | -----" admin-account.txt               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0106 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0107 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ################     Everyone ��� ������ �͸� ����ڿ��� ����          ############### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : ��Everyone ��� ������ �͸� ����ڿ��� ���롱 ��å�� �������ԡ� ���� �Ǿ� ���� ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 		: (EveryoneIncludesAnonymous=4,0 �̸� ��ȣ)                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	echo Win 2000 �ش���� ����                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver >= 2003
if %WinVer% geq 2 (
	type Local_Security_Policy.txt | Find /I "EveryoneIncludesAnonymous"                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type Local_Security_Policy.txt | Find /I "EveryoneIncludesAnonymous"						 >> %infosec%\result.txt

for /f "tokens=2 delims==" %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0107 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0108 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #################              ���� ��� �Ⱓ ����              ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "���� ��� �Ⱓ", "���� ��� �Ⱓ ������� ����" ���� 60�� �̻����� �����Ǿ� ������ ��ȣ                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type net-accounts.txt | find "Lockout duration"                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type net-accounts.txt | find "Lockout observation"                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type net-accounts.txt | find "Lockout duration" | %script%\awk -F" " {print$4} > %infosec%\lockout.txt
type net-accounts.txt | find "Lockout observation" |%script%\awk -F" " {print$5} > %infosec%\lockout2.txt

for /f %%r in (lockout.txt) do set lockout1=%%r
for /f %%p in (lockout2.txt) do set lockout=%lockout1%:%%p					
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo Result=%lockout%												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\lockout.txt 2>nul
del %infosec%\lockout2.txt 2>nul

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0108 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0109 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #################             �н����� ���⼺ ����              ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "��ȣ�� ���⼺�� �����ؾ� ��" ��å�� "���" ���� �Ǿ� ���� ��� ��ȣ            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (PasswordComplexity = 1 �� ��� ��ȣ)                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "PasswordComplexity"                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


type Local_Security_Policy.txt | Find /I "PasswordComplexity" | %script%\awk -F" " {print$3}  >> %infosec%\result.txt

for /f "delims= tokens=1" %%r in (result.txt) do set result=%%r
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=%result%												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul



echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0109 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0110 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #################            �н����� �ּ� ��ȣ ����            ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ּ� ��ȣ ���� ������ 8�� �̻��� ��� ��ȣ                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type net-accounts.txt | find "length"                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type net-accounts.txt | find "length" | %script%\awk -F" " {print$4}                      >> %infosec%\result.txt

for /f "delims= tokens=1" %%r in (result.txt) do set result=%%r
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=%result%												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul

echo 0110 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0111 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #################            �н����� �ִ� ��� �Ⱓ           ######################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ִ� ��ȣ ��� �Ⱓ ������ 90�� ������ ��� ��ȣ                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type net-accounts.txt | find "Maximum password"                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type account.txt | findstr "User active expires Last --"                        			 > %infosec%\account_temp2.txt
type account_temp2.txt | findstr /v "change profile Memberships User's" | findstr "User active Password Last --" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type net-accounts.txt | find "Maximum password" | %script%\awk -F" " {print$5}                      >> %infosec%\result.txt

for /f "delims= tokens=1" %%r in (result.txt) do set result=%%r
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=%result%												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul


echo 0111 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0112 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #################           �н����� �ּ� ��� �Ⱓ            ######################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ������ �н����� ���Ⱓ�� �ּ� 1�� �̻��� ��� ��ȣ                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type net-accounts.txt | find "Minimum password age"                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type net-accounts.txt | find "Minimum password age" | %script%\awk -F" " {print$5} > %infosec%\result.txt

for /f "delims= tokens=1" %%r in (result.txt) do set result=%%r
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=%result%												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul


echo 0112 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0113 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #################         ������ ����� �̸� ǥ�� ����         ######################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "������ ����� �̸� ǥ�� ����" ��å�� "���"���� �����Ǿ� ���� ��� ��ȣ        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (DontDisplayLastUserName = 1)                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName" | %script%\awk -F" " {print$3}                      >> %infosec%\result.txt

for /f "delims= tokens=1" %%r in (result.txt) do set result=%%r
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=%result%												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul


echo 0113 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0114 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################               ���� �α׿� ���               ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "���� �α׿� ���" ��å�� "Administrators", "IUSR_" �� ������ ��� ��ȣ         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (Administrators = *S-1-5-32-544), (IUSR = *S-1-5-17)                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "SeInteractiveLogonRight"                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type Local_Security_Policy.txt | Find /I "SeInteractiveLogonRight" | %script%\awk -F= {print$2}                      >> %infosec%\result.txt

for /F "delims=, tokens=1-26" %%a in (result.txt) do (
	echo %%a  >> result2.txt 2> nul
	echo %%b  >> result2.txt 2> nul
	echo %%c  >> result2.txt 2> nul
	echo %%d  >> result2.txt 2> nul
	echo %%e  >> result2.txt 2> nul
	echo %%f  >> result2.txt 2> nul
	echo %%g  >> result2.txt 2> nul
	echo %%h  >> result2.txt 2> nul
	echo %%i  >> result2.txt 2> nul
	echo %%j  >> result2.txt 2> nul
	echo %%k  >> result2.txt 2> nul
	echo %%l  >> result2.txt 2> nul
	echo %%m  >> result2.txt 2> nul
	echo %%n  >> result2.txt 2> nul
	echo %%o  >> result2.txt 2> nul
	echo %%p  >> result2.txt 2> nul
	echo %%q  >> result2.txt 2> nul
	echo %%r  >> result2.txt 2> nul
	echo %%s  >> result2.txt 2> nul
	echo %%t  >> result2.txt 2> nul
	echo %%u  >> result2.txt 2> nul
	echo %%v  >> result2.txt 2> nul
	echo %%w  >> result2.txt 2> nul
	echo %%x  >> result2.txt 2> nul
	echo %%y  >> result2.txt 2> nul
	echo %%z  >> result2.txt 2> nul
)

type result2.txt | findstr /V /i "*S-1-5-32-544 *S-1-5-17 ECHO" >> result3.txt

type result3.txt | findstr "*S-1" > nul
if NOT ERRORLEVEL 1 (
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

if ERRORLEVEL 1 (
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul
del %infosec%\result2.txt 2>nul
del %infosec%\result3.txt 2>nul

echo 0114 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0115 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################           �͸� SID/�̸� ��ȯ ���            ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "�͸� SID/�̸� ��ȯ ���" ��å�� "��� �� ��" ���� �Ǿ� ���� ��� ��ȣ          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (LSAAnonymousNameLookup = 0)                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	echo Win 2000 �ش���� ����                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver >= 2003
if %WinVer% geq 2 (
	type Local_Security_Policy.txt | Find /I "LSAAnonymousNameLookup"                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type Local_Security_Policy.txt | Find /I "LSAAnonymousNameLookup" | %script%\awk -F" " {print$3}                      > %infosec%\result.txt

	for /f "delims= tokens=1" %%r in (result.txt) do echo Result=%%r	>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul

)

echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0115 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0116 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################                �ֱ� ��ȣ ���                ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ������ �ֱ� ����� �н����� ��� ������ 12�� �̻��� ��� ��ȣ                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type net-accounts.txt | find "history"                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type net-accounts.txt | find "history" | %script%\awk -F" " {print$6}                      >> %infosec%\result.txt

type %infosec%\result.txt | find /i "None" > nul

for /f "tokens=1" %%r in (result.txt) do echo Result=%%r >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul

echo 0116 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0117 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################  �ܼ� �α׿� �� ���� �������� �� ��ȣ ��� ����  ################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "�ܼ� �α׿� �� ���� �������� �� ��ȣ ��� ����" ��å�� "���"���� �Ǿ� ���� ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (LimitBlankPasswordUse = 4,1)                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
rem ��� ���� �������� ������ Default ���� ����(Default ����: LimitBlankPasswordUse 1 ��ȣ)
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	echo Win 2000 �ش���� ����                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver >= 2003
if %WinVer% geq 2 (
	type Local_Security_Policy.txt | Find /I "LimitBlankPasswordUse"                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type Local_Security_Policy.txt | Find /I "LimitBlankPasswordUse"                >> %infosec%\result.txt
	for /f "delims== tokens=2" %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul

	
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0117 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0118 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################    �����͹̳� ���� ������ ����� �׷� ����    ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ���� �͹̳� ������ ������ Administrators�׷�� Remote Desktop Users�׷쿡       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : ���ʿ��� ������ ��ϵǾ� ���� ���� ��� ��ȣ                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	echo Win 2000 �ش���� ����                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver >= 2008_R2
if %WinVer% geq 4 (
	net start | find /i "Remote Desktop Services" >nul
	IF NOT ERRORLEVEL 1 (
		echo �� Remote Desktop Services Enable                                          	>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo �� ���� �͹̳� ���� ��� ����                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		net localgroup "Administrators" | findstr /V "Comment Members completed" | findstr .         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		net localgroup "Remote Desktop Users" | findstr /V "Comment Members completed" | findstr .   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
	IF ERRORLEVEL 1 (
		echo �� Remote Desktop Services Disable                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
) else (
	NET START | FIND "Terminal Service" > NUL
	IF NOT ERRORLEVEL 1 (
		echo �� Terminal Service Enable                                          			>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo �� ���� �͹̳� ���� ��� ����                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		net localgroup "Administrators" | findstr /V "Comment Members completed" | findstr .         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		net localgroup "Remote Desktop Users" | findstr /V "Comment Members completed" | findstr .   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
	IF ERRORLEVEL 1 (
		echo �� Terminal Service Disable                                             		 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0118 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0201 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
chcp 949
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################          ���� ���� �� ����� �׷� ����        ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �Ϲݰ��� ������ ���ų� ���� ���丮 ���� ������ Everyone ���� ��� ��ȣ    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net share | find /v "$" | find /v "���"			                                      	 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net share | find /v "$" | find /v "���" | find /v "------"                                    	 > %infosec%\inf_share_folder.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type inf_share_folder.txt | find "\" > nul
IF %ERRORLEVEL% neq 0 echo ���������� �������� �ʽ��ϴ�.								>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo �� cacls ���                                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	FOR /F "tokens=2 skip=3" %%j IN (inf_share_folder.txt) DO cacls %%j                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2>nul
	
	FOR /F "tokens=2 skip=3" %%j IN (inf_share_folder.txt) DO cacls %%j  					>> %infosec%\result.txt
	type %infosec%\result.txt | findstr /i "everyone" > nul
	if NOT ERRORLEVEL 1 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	if ERRORLEVEL 1 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)
:: winver >= 2003
if %WinVer% geq 2 (	
	fsutil fsinfo drives 																	 > %infosec%\inf_using_drv_temp1.txt
	type inf_using_drv_temp1.txt | find /i "\" 												 > %infosec%\inf_using_drv_temp2.txt

	echo.																					 > %infosec%\inf_using_drv_temp3.txt
	FOR /F "tokens=1-26" %%a IN (inf_using_drv_temp2.txt) DO (
		echo %%a >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%b >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%c >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%d >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%e >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%f >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%g >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%h >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%i >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%j >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%k >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%l >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%m >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%n >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%o >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%p >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%q >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%r >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%s >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%t >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%u >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%v >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%w >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%x >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%y >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%z >> %infosec%\inf_using_drv_temp3.txt 2> nul
	)
	type inf_using_drv_temp3.txt | find /i "\" | find /v "A:\" 								 > %infosec%\inf_using_drv.txt
	
	FOR /F "tokens=1" %%a IN (inf_using_drv.txt) DO (
		type inf_share_folder.txt | find "%%a"												 >> %infosec%\inf_share_folder_temp.txt
	
	)
	
	%script%\sed "s/   */?/g" %infosec%\inf_share_folder_temp.txt 							 > %infosec%\inf_share_folder_temp_sed.txt
	type inf_share_folder_temp_sed.txt | findstr "^?"										 > %infosec%\inf_share_folder_temp_sed2.txt
	
	for /F "tokens=2 delims= " %%a in (inf_share_folder_temp.txt) do cacls ^"%%a^"		 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	for /F "tokens=2 delims=?" %%a in (inf_share_folder_temp_sed.txt) do cacls ^"%%a^"		 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	for /F "tokens=1 delims=?" %%a in (inf_share_folder_temp_sed2.txt) do cacls ^"%%a^"		 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	
	for /F "tokens=2 delims= " %%a in (inf_share_folder_temp.txt) do cacls ^"%%a^"		 >> %infosec%\result.txt
	for /F "tokens=2 delims=?" %%a in (inf_share_folder_temp_sed.txt) do cacls ^"%%a^"        >> %infosec%\result.txt 
	for /F "tokens=1 delims=?" %%a in (inf_share_folder_temp_sed2.txt) do cacls ^"%%a^"		  >> %infosec%\result.txt
	
	type %infosec%\result.txt | findstr /i "everyone" 2>nul
	if NOT ERRORLEVEL 1 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	if ERRORLEVEL 1 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Everyone ������ �������� �ʽ��ϴ�.														>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	
)

del %infosec%\result.txt 2>nul
chcp 437
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0201 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0202 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
set result0202=Default
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################            �ϵ��ũ �⺻ ���� ����          ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �⺻���� �׸�(C$, D$)�� �������� �ʰ� AutoShareServer ������Ʈ�� ���� 0�� ��� ��ȣ           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� �ϵ��ũ �⺻ ���� Ȯ��                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net share | FIND /V "IPC$" | FIND /V "command PRINT$ FAX$" | FIND "$" | findstr /I "^[A-Z]"  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net share | FIND /V "IPC$" | FIND /V "command PRINT$ FAX$" | FIND "$" | findstr /I "^[A-Z]" > nul
if %ERRORLEVEL% EQU 1 (
echo �⺻ ���� ������ ���� ���� �ʽ��ϴ�.													>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� Registry ����								                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
::%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer" | %script%\awk -F" " {print$3} > defaultshare.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

net share | FIND /V "IPC$" | FIND /V "command PRINT$ FAX$" | FIND "$" | findstr /I "^[A-Z]" > nul
IF %ERRORLEVEL% EQU 0 (	
	set result02021=F
) else (
	set result02021=O
)

%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer" | find "0" > nul
	if %ERRORLEVEL% EQU 0 (
		set result02022=O
		)
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters\AutoShareServer" | find "0" > nul
	if %ERRORLEVEL% EQU 1 (
		set result02022=F
		)
if not %result02021% == %result02022% (
	echo Result=F                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
	echo Result=%result02021%                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0202 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0203 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################              ���ʿ��� ���� ����             ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ý��ۿ��� �ʿ����� �ʴ� ����� ���񽺰� �����Ǿ� ���� ��� ��ȣ                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (1) Alerter(�������� Ŭ���̾�Ʈ�� ���޼����� ����)                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (2) Clipbook(������ Clipbook�� �ٸ� Ŭ���̾�Ʈ�� ����)                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (3) Messenger(Net send ��ɾ �̿��Ͽ� Ŭ���̾�Ʈ�� �޽����� ����)          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (4) Simple TCP/IP Services(Echo, Discard, Character, Generator, Daytime, ��)  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | findstr "Alerter ClipBook Messenger"                                             > %infosec%\service.txt
net start | find "Simple TCP/IP Services"                                                    >> %infosec%\service.txt

net start | findstr /I "Alerter ClipBook Messenger TCP/IP" service.txt > NUL
IF ERRORLEVEL 1 ECHO �� ���ʿ��� ���񽺰� �������� ����.                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
IF NOT ERRORLEVEL 1 (
echo �� �Ʒ��� ���� ���ʿ��� ���񽺰� �߰ߵǾ���.                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type service.txt                                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | findstr /I "Alerter ClipBook Messenger TCP/IP" service.txt > NUL
IF ERRORLEVEL 1 ECHO Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
IF NOT ERRORLEVEL 1 echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0203 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0204 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             IIS ���� ���� ����             ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : IIS ���񽺰� ���ʿ��ϰ� �������� �ʴ� ��� ��ȣ(����� ���ͺ�)                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                
if exist iis-enable.txt (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-04-enable
) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=Disabled																		>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-04-end
)


:2-04-enable

echo [IIS Version Ȯ��]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type iis-version.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:2-04-end

echo 0204 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0205 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################           IIS ���丮 ������ ����           ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : �⺻ ���� �� ����Ʈ�� "���͸� �˻�" ������ False �̸� ��ȣ                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-05-enable
) else (
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-05-end
)

:2-05-enable

echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [�⺻ ����]                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config | find /i "directoryBrowse"             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%systemroot%\System32\inetsrv\appcmd list config | find /i "directoryBrowse"             > %infosec%\result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs get W3SVC/EnableDirBrowsing  | find /i /v "Microsoft"      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cscript %script%\adsutil.vbs get W3SVC/EnableDirBrowsing  | find /i /v "Microsoft"      > %infosec%\result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%i in (website-name.txt) do (
		echo [WebSite Name] %%i                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%systemroot%\System32\inetsrv\appcmd list config %%i | find /i "directoryBrowse"       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%systemroot%\System32\inetsrv\appcmd list config %%i | find /i "directoryBrowse"      >> %infosec%\result.txt
		echo.                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		cscript %script%\adsutil.vbs enum %%i/root | find /i "EnableDirBrowsing" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i/root | find /i "EnableDirBrowsing"         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			cscript %script%\adsutil.vbs enum %%i/root | find /i "EnableDirBrowsing"         >> %infosec%\result.txt
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
			echo * �⺻ ������ ����Ǿ� ����.                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
	)
)

type result.txt | find /i "true" > nul
if %errorlevel% equ 0 (
echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=true												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=false												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

:2-05-end
echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\result.txt 2>nul
echo 0205 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0206 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################               IIS CGI ���� ����              ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : C:\inetpub\scripts �� C:\inetpub\cgi-bin ���͸��� ������� �ʴ� ��� ��ȣ     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : ��� �� Everyone�� ������, ��������, ��������� �ο��Ǿ� ���� ���� ��� ��ȣ  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2.06-end
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

IF EXIST C:\inetpub\scripts (
	cacls C:\inetpub\scripts                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cacls C:\inetpub\scripts                                                                 > %infosec%\result.txt
	echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) ELSE (
	echo C:\inetpub\scripts ���͸��� �������� ����.                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

IF EXIST C:\inetpub\cgi-bin (
	cacls C:\inetpub\cgi-bin                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cacls C:\inetpub\cgi-bin                                                                >> %infosec%\result.txt
) ELSE (
	echo C:\inetpub\cgi-bin ���͸��� �������� ����.                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type %infosec%\result.txt | find /i /v "(ID)R" | find /i "everyone" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

:2.06-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0206 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0207 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################          IIS ���� ���丮 ���� ����         ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : "���� ��� ���" �ɼ��� üũ�Ǿ� ���� ���� ��� ��ȣ                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : (asp enableParentPaths="false" �� ��� ��ȣ)                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-07-enable
) else (
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-07-end
)

:2-07-enable
echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [�⺻ ����]                                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" > nul
	IF NOT ERRORLEVEL 1 (
		%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%systemroot%\System32\inetsrv\appcmd list config /section:asp | find /i "enableParentPaths" > %infosec%\result.txt
	) ELSE (
		echo * ������ ���� * �⺻���� : enableParentPaths=false                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs get W3SVC/AspEnableParentPaths  | find /i /v "Microsoft"    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cscript %script%\adsutil.vbs get W3SVC/AspEnableParentPaths  | find /i /v "Microsoft"    > %infosec%\result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%i in (website-name.txt) do (
		%systemroot%\System32\inetsrv\appcmd list config %%i /section:asp | find /i "enableParentPaths" > nul
		echo [WebSite Name] %%i                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		if not errorlevel 1 (
			%systemroot%\System32\inetsrv\appcmd list config %%i /section:asp | find /i "enableParentPaths" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			%systemroot%\System32\inetsrv\appcmd list config %%i /section:asp | find /i "enableParentPaths" >> %infosec%\result.txt
			echo.                                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
			echo * ������ ���� * �⺻���� : enableParentPaths=false                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		cscript %script%\adsutil.vbs enum %%i/root | find /i "AspEnableParentPaths" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i/root | find /i "AspEnableParentPaths"     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			cscript %script%\adsutil.vbs enum %%i/root | find /i "AspEnableParentPaths"     >> %infosec%\result.txt
			echo.                                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
			echo AspEnableParentPaths : * �⺻ ������ ����Ǿ� ����.                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
	)
)



type result.txt | find /i "true" > nul
if %errorlevel% equ 0 (
echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=true												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=false												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:2-07-end
del %infosec%\result.txt 2>nul
echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0207 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0208 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################            IIS ���ʿ��� ���� ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : IISSamples, IISHelp ������͸��� �������� ���� ��� ��ȣ                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 		 (IIS 7.0 �̻� ���� �ش� ���� ����)						                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-08-enable
) else (
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-08-end
)

:2-08-enable
echo [���� ���͸� ���� ��Ȳ]                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	echo �� IIS 7.0 �̻� ���� �ش� ���� ����							                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

::20160114 ������(�ش���� �������� ������)
::if %iis_ver_major% geq 7 (
	::%systemroot%\System32\inetsrv\appcmd list config -section:system.applicationHost/sites | find /i "virtualdirectory" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
::)

::20160114 ������(IISSample �� ������ �Ǵܰ����ϰ� ������)
:: iis ver <= 6
::if %iis_ver_major% leq 6 (
	::%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
::)

if %iis_ver_major% leq 6 (
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots" | findstr "IISSamples IISHelp" >> %infosec%\sample-app.txt
	type sample-app.txt                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	findstr "IISSamples IISHelp" sample-app.txt > NUL
	IF ERRORLEVEL 1 (
		ECHO * ���˰��: IISSamples, IISHelp ������͸��� �������� ����.                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt		
	)	ELSE (
		ECHO * ���˰��: IISSamples, IISHelp ������͸��� ������.                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt				
	)
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:2-08-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0208 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0209 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################          IIS �� ���μ��� ���� ����           ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : IIS ���� ���� ������ ������ �������� ��ϵǾ� ���� ������ ��ȣ                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2.09-end
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [World Wide Web Publishing Service ���� ����]                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\ObjectName"                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\ObjectName"                 >> %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [IIS Admin Service ���� ����]                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\IISADMIN\ObjectName"              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\IISADMIN\ObjectName"              >> %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type %infosec%\result.txt | find "LocalSystem" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:2.09-end
del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0209 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0210 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################               IIS ��ũ ������              ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : �� ����Ʈ Ȩ���͸��� �ɺ��� ��ũ, aliases, *.lnk ������ �������� ������ ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-10-enable
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-10-end
)

:2-10-enable
echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:: iis ver >= 7
if %iis_ver_major% geq 7 (
	echo [Ȩ���丮 ���� - WEB/FTP ���п�]                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%systemroot%\System32\inetsrv\appcmd list config -section:system.applicationHost/sites | findstr /i "name protocol physicalpath" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *** ����Ʈ�� ���ʿ� ���� üũ                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
for /f "delims=" %%a in (website-physicalpath.txt) do (
	echo [Website HomeDir] %%a                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	call cd /d %%a			2>nul
	attrib /s | find /i ".lnk"                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	attrib /s | find /i ".lnk"                                                                >> %infosec%\%result.txt
	cd /d %infosec%
	echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��� ���� �������� ������ ��ȣ                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type %infosec%\result.txt | find ".lnk" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)


:2-10-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\result.txt 2>nul
echo 0210 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0211 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################       IIS ���� ���ε� �� �ٿ�ε� ����       ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : �� ������ ���� �ڿ������� ���� ���ε� �� �ٿ�ε� �뷮�� ������ ��� ��ȣ     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : 7.0�̻�(maxAllowedContentLength: ������ �뷮 ���� ���� /Default: 30MB)                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 7.0�̻�(MaxRequestEntityAllowed: ���� ���ε� �뷮 ���� ���� /Default: 200000 bytes)    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 7.0�̻�(bufferingLimit: ���� �ٿ�ε� �뷮 ���� ���� /Default: 4MB(4194304 bytes))     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 6.0����(AspMaxRequestEntityAllowed : ���ε� �뷮 ���� ���� /Default: 200KB(204800 byte)) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 6.0����(AspBufferingLimit : �ٿ�ε� �뷮 ���� ���� /Default: 4MB(4194304 byte)) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-11-enable
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	
	goto 2-11-end
)

:2-11-enable
echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [�⺻ ����]                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config | findstr /i "maxAllowedContentLength maxRequestEntityAllowed bufferingLimit" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs enum W3SVC | findstr /i "AspMaxRequestEntityAllowed AspBufferingLimit" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo * ���� ���� ��� �⺻ ������ ����Ǿ� ����.                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%a in (website-name.txt) do (
		echo [WebSite Name] %%a                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%systemroot%\System32\inetsrv\appcmd list config %%a | findstr /i "maxAllowedContentLength maxRequestEntityAllowed bufferingLimit" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo * ���� ���� ��� �⺻ ������ ����Ǿ� ����.                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		cscript %script%\adsutil.vbs enum %%i | find /i "AspMaxRequestEntityAllowed" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i | find /i "AspMaxRequestEntityAllowed"  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
			echo AspMaxRequestEntityAllowed : * �⺻ ������ ����Ǿ� ����.                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
		cscript %script%\adsutil.vbs enum %%i | find /i "AspBufferingLimit" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i | find /i "AspBufferingLimit"           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
			echo AspBufferingLimit          : * �⺻ ������ ����Ǿ� ����.                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
	)
)

echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:2-11-end
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0211 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0212 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################           IIS DB ���� ����� ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : 7.0�̻�- ��û ���͸����� .asa, .asax Ȯ���ڰ� False�� �����Ǿ� ������ ��ȣ     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo                   ��û ���͸����� .asa, .asax Ȯ���ڰ� True�� �����Ǿ� ���� ���        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo                   .asa, .asax ������ ��ϵǾ� �־�� ��ȣ                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo                   (����, Global.asa ������ ������� �ʴ� ��� �ش� ���� ����.)           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo                 > (1) fileExtension=".asa" allowed="false" �̸� ��ȣ                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo                 > (2) fileExtension=".asa" allowed="true" �̸�, .asa ���� Ȯ��           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo   	    : 6.0����- .asa ������ ������ ��� ��ȣ                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo                   (���� ��) ".asa,C:\WINDOWS\system32\inetsrv\asp.dll,5,GET,HEAD,POST,TRACE" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo                    GET,HEAD,POST,TRACE ����: �������� ����								 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-12-enable
) else (
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	
	goto 2-12-end
)

:2-12-enable
echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [�⺻ ����]                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\appcmd list config | find /i ".asa" | find /i /v "httpforbiddenhandler" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	cscript %script%\adsutil.vbs enum W3SVC | find /i ".asa"                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%a in (website-name.txt) do (
		echo [WebSite Name] %%a                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%systemroot%\System32\inetsrv\appcmd list config %%a | find /i ".asa" | find /i /v "httpforbiddenhandler" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		cscript %script%\adsutil.vbs enum %%i/root | find /i ".asa" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i/root | find /i ".asa"                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
			cscript %script%\adsutil.vbs enum %%i/root | find /i "ScriptMaps" > nul
			if not errorlevel 1 (
				echo .asa ������ ��ϵǾ� ���� ����. [���]                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
				echo.                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			) else (
				echo * �⺻ ������ ����Ǿ� ����.                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
				echo.                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			)
		)
	)
)
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	
:2-12-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0212 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0213 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################            IIS ���� ���丮 ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : �ش� ������Ʈ�� IIS Admin, IIS Adminpwd ���� ���͸��� �������� ���� ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo        : IIS 6.0 �̻� ���� �ش� ���� ���� 												 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-13-enable
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-13-end
)

:2-13-enable
echo [���� ���͸� ���� ��Ȳ]                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
rem ##########20160114 6.0 �̻� �ش� ���� �������� �ҽ� ���� ����##########
:: iis ver >= 6
if %iis_ver_major% geq 6 (
echo �� IIS 6.0 �̻� ���� �ش� ���� ���� 												 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2-13-end
)

:: iis ver < 5
if %iis_ver_major% lss 5 (
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots" >> %infosec%\result.txt
)
type %infosec%\result.txt | find /i "IIS" | findstr /I "Admin Adminpwd" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
rem ##########20160114 6.0 �̻� �ش� ���� �������� �ҽ� ���� ��##########


rem ##########20160114 6.0 �̻� �ش� ���� �������� �ҽ� ���� ����##########
:: iis ver >= 7
::if %iis_ver_major% geq 7 (
	::%systemroot%\System32\inetsrv\appcmd list config -section:system.applicationHost/sites | find /i "virtualdirectory" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
::)
:: iis ver <= 6
::if %iis_ver_major% leq 6 (
	::%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
::)
rem ##########20160114 6.0 �̻� �ش� ���� �������� �ҽ� ���� ��##########
del %infosec%\result.txt 2>nul
:2-13-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0213 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0214 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################           IIS ������ ���� ACL ����           ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : Ȩ ���͸� ���� �ִ� ���ϵ鿡 ���� Everyone ������ �������� ���� ��� ��ȣ   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : (��������Ʈ ������ Read ���Ѹ�)                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-14-enable
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-14-end
)

:2-14-enable
echo [��� ����Ʈ]                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *** ����Ʈ�� ���� Everyone ���� üũ                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo (exe, dll, cmd, pl, asp, inc, shtm, shtml, txt, gif, jpg, html)                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
for /f "delims=" %%a in (website-physicalpath.txt) do (
	echo [Website HomeDir] %%a                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	echo -----------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	call cd /d %%a 2> nul																				
	cd 2> nul
	cacls *.exe /t | find /i "everyone"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.dll /t | find /i "everyone"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.cmd /t | find /i "everyone"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.pl /t | find /i "everyone"                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.asp /t | find /i "everyone"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.inc /t | find /i "everyone"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.shtm /t | find /i "everyone"                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.shtml /t | find /i "everyone"                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.txt /t | find /i "everyone"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.gif /t | find /i "everyone"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.jpg /t | find /i "everyone"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.html /t | find /i "everyone"                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2> nul
	cacls *.exe /t | find /i "everyone"                                                      >> %infosec%\result.txt 2> nul
	cacls *.dll /t | find /i "everyone"                                                      >> %infosec%\result.txt 2> nul
	cacls *.cmd /t | find /i "everyone"                                                      >> %infosec%\result.txt 2> nul
	cacls *.pl /t | find /i "everyone"                                                       >> %infosec%\result.txt 2> nul
	cacls *.asp /t | find /i "everyone"                                                      >> %infosec%\result.txt 2> nul
	cacls *.inc /t | find /i "everyone"                                                      >> %infosec%\result.txt 2> nul
	cacls *.shtm /t | find /i "everyone"                                                     >> %infosec%\result.txt 2> nul
	cacls *.shtml /t | find /i "everyone"                                                    >> %infosec%\result.txt 2> nul
	cacls *.txt /t | find /i "everyone"                                                      >> %infosec%\result.txt 2> nul
	cacls *.gif /t | find /i "everyone"                                                      >> %infosec%\result.txt 2> nul
	cacls *.jpg /t | find /i "everyone"                                                      >> %infosec%\result.txt 2> nul
	cacls *.html /t | find /i "everyone"                                                     >> %infosec%\result.txt 2> nul
	cd /d %infosec% 2> nul
	echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) 2> nul
echo �� ��� ���� �������� ������ ��ȣ                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type %infosec%\result.txt | find /i "everyone" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:2-14-end
del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0214 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0215 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################         IIS �̻�� ��ũ��Ʈ ���� ����        ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : �Ʒ��� ���� ����� ������ �������� ���� ��� ��ȣ(Windows 20003 ���� ������ ��ġ�� �Ǿ� ��ȣ��)                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : (.htr .idc .stm .shtm .shtml .printer .htw .ida .idq)                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-15-enable
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-15-end
)

:2-15-enable
if %WinVer% geq 2 (
	echo �� Windows 2003 ���� ������ ��ġ�� �Ǿ� �ش���� ����							>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-15-end
) else (
	echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	:: iis ver >= 7
	if %iis_ver_major% geq 7 (
		type website-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	:: iis ver <= 6
	if %iis_ver_major% leq 6 (
		type website-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

	:: iis ver >= 7
	if %iis_ver_major% geq 7 (
		echo [�̻�� ��ũ��Ʈ ���� Ȯ��]                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%systemroot%\System32\inetsrv\appcmd list config | find /i "scriptprocessor" | findstr /i ".htr .idc .stm .shtm .shtml .printer .htw .ida .idq" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo �� ��� ���� �������� ������ ��ȣ                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)

	:: iis ver <= 6
	if %iis_ver_major% leq 6 (
		echo [�⺻ ����]                                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		cscript %script%\adsutil.vbs enum W3SVC | findstr /i ".htr .idc .stm .shtm .shtml .printer .htw .ida .idq" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		cscript %script%\adsutil.vbs enum W3SVC | findstr /i ".htr .idc .stm .shtm .shtml .printer .htw .ida .idq" >> %infosec%\result.txt
		echo �� ��� ���� �������� ������ ��ȣ                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

		echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo *** ����Ʈ�� ���� Ȯ��                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		for /f "tokens=1 delims=[]" %%i in (website-list.txt) do (
			echo [WebSite AppRoot] %%i                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo -----------------------------------------------------------------------        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			cscript %script%\adsutil.vbs enum %%i/root | findstr /i ".htr .idc .stm .shtm .shtml .printer .htw .ida .idq" > nul
			if not errorlevel 1 (
				cscript %script%\adsutil.vbs enum %%i/root | findstr /i ".htr .idc .stm .shtm .shtml .printer .htw .ida .idq" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
				cscript %script%\adsutil.vbs enum %%i/root | findstr /i ".htr .idc .stm .shtm .shtml .printer .htw .ida .idq" >> %infosec%\result.txt
				echo.                                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			) else (
				cscript %script%\adsutil.vbs enum %%i/root | find /i "ScriptMaps" > nul
				if not errorlevel 1 (
					echo * ����� ������ ��ϵǾ� ���� ����. [��ȣ]                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
					echo.                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
				) else (
					echo * �⺻ ������ ����Ǿ� ����.                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
					echo.                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
				)
			)
		)
	)
)

type %infosec%\result.txt | findstr /i ".htr .idc .stm .shtm .shtml .printer .htw .ida .idq" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)


del %infosec%\result.txt 2>nul
:2-15-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0215 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0216 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################         IIS Exec ��ɾ� �� ȣ�� ����         ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : �ش� ������ ������Ʈ�� ���� 0�� ��� ��ȣ                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : (����1) IIS 5.0 �������� �ش� ������Ʈ�� ���� ���� ��� ��ȣ                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : (����2) IIS 6.0 �̻� ��ȣ                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-16-enable
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-16-end
)

:2-16-enable
:: iis ver >= 6
if %iis_ver_major% geq 6 (
	echo �� IIS 6.0 �̻� ��ȣ			                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-16-end
)

:: iis ver < 6
if %iis_ver_major% lss 6 (
	echo [Registry ����] 			                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\SSIEnableCmdDirective" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\SSIEnableCmdDirective" >> %infosec%\result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)


type %infosec%\result.txt | find /V "0" | findstr /i "SSIEnableCmdDirective" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
del %infosec%\result.txt 2>nul

:2-16-end
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0216 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0217 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###################              IIS WebDAV ��Ȱ��ȭ              ##################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : ���� �� �� ������ �ش�Ǵ� ��� ��ȣ                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 1. IIS �� ������� ���� ���                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 2. DisableWebDAV ���� 1�� �����Ǿ� �������                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 3. Windows NT, 2000�� ������ 4 �̻��� ��ġ�Ǿ� ���� ���                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 4. Windows 2003, Windows 2008�� WebDAV �� ���� �Ǿ� ���� ���                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : "0,C:\WINDOWS\system32\inetsrv\httpext.dll,0,WEBDAV,WebDAV" (WebDAV ����-��ȣ) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : "1,C:\WINDOWS\system32\inetsrv\httpext.dll,0,WEBDAV,WebDAV" (WebDAV ���-���) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 2008 �̻��� ��� allowed="false"   (WebDAV ����-��ȣ) 						>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 2008 �̻��� ��� allowed="True"    (WebDAV ���-���) 						 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-17-enable
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-17-end
)

:2-17-enable

:: winver = 2000
if %WinVer% equ 1 (
	ECHO �� Win 2000�� ��� ������ 4 �̻� ��ȣ                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "kernel version"                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "service pack"                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "os version" | find /i /v "bios" | %script%\awk -F" " {print$6}	> %infosec%\result.txt
	goto 2.17-2000
	echo.
)

:: iis ver =< 6
if %iis_ver_major% leq 6 (
	echo [WebDAV ���� Ȯ��]                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\adsutil.vbs enum W3SVC | find /i "webdav" | find /v "WebDAV;WEBDAV"            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\adsutil.vbs enum W3SVC | find /i "webdav" | find /v "WebDAV;WEBDAV"            > %infosec%\result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2.17-2003
)


:: iis ver >=7
if %iis_ver_major% geq 6 (
	echo [WebDAV ���� Ȯ��]                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%systemroot%\System32\inetsrv\appcmd list config -section:isapiCgiRestriction | find /i "webdav" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%systemroot%\System32\inetsrv\appcmd list config -section:isapiCgiRestriction | find /i "webdav" > %infosec%\result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2.17-2008
)

:2.17-2003
type result.txt | find "1," >nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2-17-end
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2-17-end



:2.17-2008	
type result.txt | find /i "true" >nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2-17-end
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2-17-end


:2-17-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [���� - Registry ����(DisableWebDAV)]                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\registry\DisableWebDAV" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\DisableWebDAV"  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��� ���� �������� ���� ��� �ٸ� �������� ����                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [���� - OS Version, Service Pack]                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	type systeminfo.txt | find /i "kernel version"                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "service pack"                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

:: winver >= 2003
if %WinVer% geq 2 (
	type systeminfo.txt | find /i "os name"                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "os version" | find /i /v "bios"                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\result.txt 2>nul
echo 0217 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0218 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################         NetBIOS ���ε� ���� ���� ����       ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: TCP/IP�� NetBIOS ���� ���ε��� ���� �Ǿ��ִ� ��� ��ȣ                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (NetBIOS ��� ���� ����: NetbiosOptions 0x2 ��ȣ)                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (NetBIOS ��� ����: NetbiosOptions 0x1 ���)                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (�⺻ ��: NetbiosOptions 0x0 ���)                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (�������� ���) ���ͳ� ��������(TCP/IP)�� ������� �� ��� �� Wins ���� TCP/IP���� NetBIOS ��� ���� (139��Ʈ����) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" | findstr /iv "listing" > 2-18-netbios-list.txt
	for /f "tokens=1 delims=[" %%a in (2-18-netbios-list.txt) do echo %%a >> 2-18-netbios-list-1.txt
	for /f "tokens=1 delims=]" %%a in (2-18-netbios-list-1.txt) do echo %%a >> 2-18-netbios-list-2.txt
	FOR /F %%a IN (2-18-netbios-list-2.txt) do echo HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces\%%a\NetbiosOptions >> 2-18-netbios-query.txt
	FOR /F %%a IN (2-18-netbios-query.txt) do %script%\reg query %%a >> 2-18-netbios-result.txt
	echo [NetBIOS over TCP/IP ���� ��Ȳ]                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	TYPE 2-18-netbios-result.txt	                            							>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver >= 2003
if %WinVer% geq 2 (
	reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /s | findstr . >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2>nul
)
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0218 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0219 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #########################        FTP ���� ���� ����          ######################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : FTP ���񽺸� ������� �ʴ� ��� ��ȣ (�̿� ������ ��������ͺ�)                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist ftp-enable.txt (
	echo �� FTP Service Enable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	net start | findstr /i "ftp"                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-19-enable
) else (
	echo �� FTP Service Disable                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-19-end
)

:2-19-enable


echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ftp_ver_major% geq 7 (
	type ftpsite-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ftp_ver_major% leq 6 (
	type ftpsite-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:2-19-end
echo 0219 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0220 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #####################        FTP ���丮 ���ٱ��� ����          ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : FTP Ȩ ���͸��� Everyone�� ���� ������ �������� ������ ��ȣ				              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist ftp-enable.txt (
	echo �� FTP Service Enable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	net start | findstr /i "ftp"                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-20-enable
) else (
	echo �� FTP Service Disable                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-20-end
)


:2-20-enable
:: iis ver = 0
if %iis_ftp_ver_major%==0 (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� ������ �⺻ FTP�� Ÿ FTP ���� ����� (����Ȯ��^)                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-20-end
)
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [��� ����Ʈ]                                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ftp_ver_major% geq 7 (
	type ftpsite-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ftp_ver_major% leq 6 (
	type ftpsite-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:: iis ver >= 7
if %iis_ftp_ver_major% geq 7 (
	echo [Ȩ���丮 ���� - WEB/FTP ���п�]                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%systemroot%\System32\inetsrv\appcmd list config -section:system.applicationHost/sites | findstr /i "name protocol physicalpath" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *** ����Ʈ�� Ȩ���丮 ���ٱ��� Ȯ��                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
for /f "delims=" %%a in (ftpsite-physicalpath.txt) do (
	echo [FtpSite HomeDir] %%a                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	call cacls %%a                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	call cacls %%a                                                                          >> %infosec%\result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type %infosec%\result.txt | findstr /i "everyone" > nul
if %ERRORLEVEL% NEQ 0 (
 echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
if %ERRORLEVEL% EQU 0 (
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
del %infosec%\result.txt 2>nul



:2-20-end
echo 0220 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0221 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###########################         Anonymous FTP ����          ####################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : FTP�� ������� �ʰų� "�͸� ���� ���"�� üũ�Ǿ� ���� ���� ��� ��ȣ(Default : ��� �� ��)          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : metabase.xml ���� ���� ����        											 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : IIsFtpService	Location ="/LM/MSFTPSVC" �� FTP ����Ʈ �⺻ ����                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : FTP ����Ʈ�� ���� ���� �� �ش� �⺻ ������ ���� ����.							 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : IIsFtpServer	Location ="/LM/MSFTPSVC/ID"�� FTP ����Ʈ�� ��ϵ� ���� ����Ʈ ���� >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : ���� ����Ʈ�� AllowAnonymous ������ ������ FTP ����Ʈ �⺻ ������ ���� ����   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : IIsFtpServer	Location ="/LM/MSFTPSVC/~/Public FTP Site"�� ���� �� ������� ���� >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist ftp-enable.txt (
	echo �� FTP Service Enable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	net start | findstr /i "ftp"                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-21-enable
) else (
	echo �� FTP Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-21-end
)

:2-21-enable
:: iis ver = 0
if %iis_ftp_ver_major%==0 (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� ������ �⺻ FTP�� Ÿ FTP ���� �����                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-21-end
)

echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ftp_ver_major% geq 7 (


	type ftpsite-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo [FTP ���� ���� Ȯ��]                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%systemroot%\System32\inetsrv\appcmd list config -section:system.applicationHost/sites | findstr /i "name protocol anonymousAuthentication enabled" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%systemroot%\System32\inetsrv\appcmd list config -section:system.applicationHost/sites | findstr /i "name protocol anonymousAuthentication enabled" > %infosec%\result.txt
	echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-218-enable	
) 
	type ftpsite-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo [�⺻ ����]                                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cscript %script%\adsutil.vbs enum MSFTPSVC | find /i "AllowAnonymous"                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cscript %script%\adsutil.vbs enum MSFTPSVC | find /i "AllowAnonymous"                   > %infosec%\result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo *** ����Ʈ�� ���� Ȯ��                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	for /f "tokens=1 delims=[]" %%i in (ftpsite-list.txt) do (
		echo [FtpSite AppRoot] %%i                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		cscript %script%\adsutil.vbs enum %%i | find /i "AllowAnonymous" > nul
		if not errorlevel 1 (
			cscript %script%\adsutil.vbs enum %%i | find /i "AllowAnonymous"                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			cscript %script%\adsutil.vbs enum %%i | find /i "AllowAnonymous"                 > %infosec%\result.txt
			echo.                                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			goto 2-213-enable
		) 
			echo AllowAnonymous : �⺻ ������ ����Ǿ� ����.                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo AllowAnonymous : �⺻ ������ ����Ǿ� ����.                                 > %infosec%\result.txt
			echo.                                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 2-213-enable
	)


::7�̻�
:2-218-enable
type %infosec%\result.txt | find /i "anonymousAuthentication" | find /i "true" > nul
::echo %errorlevel%
if %errorlevel% neq 0 (
	echo Result=false												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-21-end
) else (
	echo Result=true												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-21-end
)



:2-213-enable
::6�̸�
type %infosec%\result.txt | find /i "AllowAnonymous" | find /i "True" > nul
if %errorlevel% neq 0 (
 echo Result=false												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-21-end
)
echo Result=true												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt



:2-21-end
del %infosec%\result.txt 2>nul
echo 0221 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0222 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###########################        FTP ���� ���� ����          ######################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : FTP ���񽺿� �������� ������ �Ǿ� �ִ� ��� ��ȣ				                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� : metabase.xml ���� ���� ����        												 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : IIsFtpService	Location ="/LM/MSFTPSVC" �� FTP ����Ʈ �⺻ ����               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : IIsFtpVirtualDir	Location ="/LM/MSFTPSVC/ID/ROOT"�� FTP ���� ����Ʈ ����      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : ���� ����Ʈ�� IPSecurity ������ ������ FTP ����Ʈ �⺻ ������ ���� ����       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : IPSecurity="" �������� ����, IPSecurity="0102~" �������� ���� ����.           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : �������� ����Ʈ���� ���� ���� ���� ������ ���˽� ��� ����.                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : 2008�̻� ipSecurity allowUnlisted ������ False�� �Ǿ�� ��ȣ                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��      : ipSecurity allowUnlisted True��� �׼��� ��� / False ��� �׼��� �ź�         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist ftp-enable.txt (
	echo �� FTP Service Enable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	net start | findstr /i "ftp"                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-22-enable
) else (
	echo �� FTP Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-22-end
)

:2-22-enable
:: iis ver = 0
if %iis_ftp_ver_major%==0 (
	echo �� ������ �⺻ FTP�� Ÿ FTP ���� ����� (����Ȯ��^)                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2-22-end
)
echo [��� ����Ʈ]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ftp_ver_major% geq 7 (
	type ftpsite-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ftp_ver_major% leq 6 (
	type ftpsite-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:: iis ver >= 7
if %iis_ftp_ver_major% geq 7 (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo *** ����Ʈ�� FTP �������� ���� Ȯ��                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	
	for /f "delims=" %%a in (ftpsite-name.txt) do (
		%systemroot%\System32\inetsrv\appcmd list config %%a /section:ipsecurity | find /i "ipAddress" > nul
		echo [FTP-Site Name] %%a                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		if not errorlevel 1 (
			%systemroot%\System32\inetsrv\appcmd list config %%a /section:ipsecurity | find /i "ipAddress" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			%systemroot%\System32\inetsrv\appcmd list config %%a /section:ipsecurity | find /i "ipAddress" >> %infosec%\result.txt
			%systemroot%\System32\inetsrv\appcmd list config %%a /section:ipsecurity | find /i "ipSecurity AllowUnlisted" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			%systemroot%\System32\inetsrv\appcmd list config %%a /section:ipsecurity | find /i "ipSecurity AllowUnlisted" >> %infosec%\result.txt
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
			echo * �������� ���� ����                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			)
		)
)
:: iis ver <= 6
if %iis_ftp_ver_major% leq 6 (
	echo [FTP �������� ����]                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo -----------------------------------------------------                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cscript %script%\ftp_ipsecurity.vbs >nul
	type ftp-ipsecurity.txt                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)



if %iis_ftp_ver_major% geq 7 (
	goto 2-227-enable
) 
if %iis_ftp_ver_major% leq 6 (
	goto 2-226-enable
)

:2-227-enable
type %infosec%\result.txt | find "ipSecurity allowUnlisted" | find "true" > nul
	if %ERRORLEVEL% NEQ 0 (
		echo Result=false												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
		echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	if %ERRORLEVEL% EQU 0 (
		echo Result=true												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
		echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)
del %infosec%\result.txt 2>nul	
goto 2-22-end

:2-226-enable
type ftp-ipsecurity.txt | find "SiteName" | find "Access Allow" > nul
		if %ERRORLEVEL% NEQ 0 (
			echo Result=false												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
		if %ERRORLEVEL% EQU 0 (
			echo Result=true												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
			echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)	
)
del %infosec%\ftp-ipsecurity.txt 2>nul

:2-22-end
echo 0222 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0223 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             DNS Zone Transfer ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: DNS ���� ������ �Ʒ� ���� �� �ϳ��� �ش�Ǵ� ��� ��ȣ(SecureSecondaries 2) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (1) DNS ���񽺸� ������� ���� ���                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (2) ���� ���� ����� ���� ���� ���                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (3) Ư�� �����θ� ���� ������ ����ϴ� ���                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : * ������Ʈ����(�������� ������:3, �ƹ������γ�:0, �̸������ǿ������� �����θ�:1, ���������θ�:2 ) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : [����]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : ��� ���� ���� ��� DNS ������ ��ϵ� ��/������ ��ȸ ������ ���� ������,      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : DNS ���񽺸� ������� ���� ��� ���񽺸� ������ ���� �ǰ�                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "DNS Server" > NUL
IF NOT ERRORLEVEL 1 (
	ECHO �� DNS Service Enable                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)	ELSE (
	ECHO �� DNS Service Disable                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
	goto 0223-end
	echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)


:: winver < 2008R2
if %WinVer% leq 3 (
goto 0223-2008
)

:: winver > 2008
if %WinVer% geq 4 (
 goto 0223-2008R2
)


:0223-2008
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr . | find /v "Listing of" | find /v "system was unable" >nul
	IF %ERRORLEVEL% NEQ 0 (
		reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find "SecureSecondaries" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find "SecureSecondaries" >> %infosec%\result.txt
	) else (
		%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find "SecureSecondaries" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find "SecureSecondaries" >> %infosec%\result.txt
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type %infosec%\result.txt | %script%\awk -F" " {print$3} | find "0" > nul
	if %ERRORLEVEL% NEQ 0 (
		echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
		echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 0223-end
	)
	if %ERRORLEVEL% EQU 0 (
		echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
		echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 0223-end
	)
)

:0223-2008R2
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr . | find /v "Listing of" | find /v "system was unable" >nul
	IF %ERRORLEVEL% NEQ 0 (
		reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find "SecureSecondaries" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find "SecureSecondaries" >> %infosec%\result.txt
	) else (
		%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find "SecureSecondaries" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | find "SecureSecondaries" >> %infosec%\result.txt
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type %infosec%\result.txt | find "0x0" > nul
	if %ERRORLEVEL% NEQ 0 (
		echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
		echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 0223-end
	)
	if %ERRORLEVEL% EQU 0 (
		echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
		echo.                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 0223-end
	)
)

:0223-end
del %infosec%\result.txt 2>nul	
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0223 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0224 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################         RDS (Remote Data Services) ����       ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ������ �� �Ѱ����� �ش�Ǵ� ��� ��ȣ                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (1) IIS �� ������� �ʴ� ���                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (2) Windows 2000 sp4, Windows 2003 sp2, Windows 2008 �̻� ��ȣ  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (3) ����Ʈ ������Ʈ�� MSADC ���� ���͸��� �������� ���� ���                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (4) �ش� ������Ʈ�� ���� �������� ���� ���                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

if exist iis-enable.txt (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2.24-end
)

:: OS Version, Service Pack ���� üũ
echo [OS Version Ȯ��]                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	
:: winver = 2000
if %WinVer% equ 1 (
	ECHO �� Win 2000�� ��� ������ 4 �̻� ��ȣ                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "kernel version"                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "service pack"                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "os version" | find /i /v "bios" | %script%\awk -F" " {print$6}	> %infosec%\result.txt
	goto 2.24-2000
	echo.
)

:: winver >= 2003
if %WinVer% geq 2 (
	ECHO �� Windows 2003 sp2 �̻�, Windows 2008 �̻� ��ȣ                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "os name"                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "os version" | find /i /v "bios"                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if %WinVer% EQU 2 (
	type systeminfo.txt | find /i "os version" | find /i /v "bios" | %script%\awk -F" " {print$6}     > %infosec%\result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2.24-2003
	)

if %WinVer% geq 3 (
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 2.24-end
	)

:2.24-2000
type systeminfo.txt | find /i /v "bios" | find /V "N/A" | find /i "os version" >nul
if %errorlevel% neq 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2.24-2003-0
)

for /f %%r in (result.txt) do set SP=%%r       
if %SP% geq 4 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2.24-end
)

:2.24-2003-0	
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots" | find /i "msadc" >> %infosec%\msadcdir.txt
	type msadcdir.txt                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	find /i "msadc" msadcdir.txt > NUL
	IF ERRORLEVEL 1 (
		ECHO * ���˰��: MSADC ������͸��� �������� ����.                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt		
		goto 2.24-end
)

%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch" /s | findstr /i "RDSServer.DataFactory AdvancedDataFactory VbBusObj.VbbusObjCls" >> %infosec%\RDSREG.txt
type %infosec%\RDSREG.txt                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	findstr /i "RDSServer.DataFactory AdvancedDataFactory VbBusObj.VbbusObjCls" RESREG.txt > NUL
	IF ERRORLEVEL 1 (
		ECHO * ���˰��: ��ϵ� REG���� �������� ����.                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt		
		goto 2.24-end
)

		echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt		
		goto 2.24-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:2.24-2003

type systeminfo.txt | find /i /v "bios" | find /V "N/A" | find /i "os version" >nul
if %errorlevel% neq 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2.24-2003-1
)

for /f %%r in (result.txt) do set SP=%%r       
if %SP% geq 2 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 2.24-end
)

:2.24-2003-1

%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots" | find /i "msadc" >> %infosec%\msadcdir.txt
	type msadcdir.txt                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	find /i "msadc" msadcdir.txt > NUL
	IF ERRORLEVEL 1 (
		ECHO * ���˰��: MSADC ������͸��� �������� ����.                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt		
		goto 2.24-end
)

%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\ADCLaunch" /s | findstr /i "RDSServer.DataFactory AdvancedDataFactory VbBusObj.VbbusObjCls" >> %infosec%\RDSREG.txt
type %infosec%\RDSREG.txt                                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	findstr /i "RDSServer.DataFactory AdvancedDataFactory VbBusObj.VbbusObjCls" RESREG.txt > NUL
	IF ERRORLEVEL 1 (
		ECHO * ���˰��: ��ϵ� REG���� �������� ����.                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt		
		goto 2.24-end
)

		echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt		
		goto 2.24-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	

	
:2.24-end	
del %infosec%\result.txt 2>nul
del %infosec%\msadcdir.txt 2>nul
del %infosec%\RDSREG.txt 2>nul

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0224 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0225 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################               �ֽ� ������ ����              ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ֽ� �������� ��ġ�Ǿ� ���� ��� ��ȣ                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (Windows NT 6a, Windows 2000 SP4, Windows 2003 SP2, Windows 2008 SP2)         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (Windows 2008R2 SP1, Windows 2012, 2012r2�� SP�� ����) 						 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type systeminfo.txt | find "Microsoft"                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type systeminfo.txt | find "Pack"                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [OS Version Ȯ��]                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	
:: winver = 2000
if %WinVer% equ 1 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type systeminfo.txt | find /i "service pack" | find /i /v "bios" | %script%\awk -F" " {print$6}		        > %infosec%\result.txt
	echo.
	goto 0225-2000
)

:: winver = 2003
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if %WinVer% EQU 2 (
	type systeminfo.txt | find /i "os version" | find /i /v "bios" | %script%\awk -F" " {print$6}		        > %infosec%\result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 0225-2003
	)

:: winver = 2008
if %WinVer% EQU 3 (
	type systeminfo.txt | find /i "os version" | find /i /v "bios" | %script%\awk -F" " {print$6}		        > %infosec%\result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 0225-2008
	)

:: winver = 2008R2
if %WinVer% EQU 4 (
	type systeminfo.txt | find /i "os version" | find /i /v "bios" | %script%\awk -F" " {print$6}		        > %infosec%\result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 0225-2008R2
	)
	
:: winver = 2012&2012R2
if %WinVer% GEQ 5 (
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 0225-end
	)

:0225-2000
type systeminfo.txt | find /i /v "bios" | find /V "N/A" | find /i "os version" >nul
if %errorlevel% neq 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end
)

for /f %%r in (result.txt) do set SP=%%r       
if %SP% geq 4 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end
)
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end

:0225-2003
type systeminfo.txt | find /i /v "bios" | find /V "N/A" | find /i "os version" >nul
if %errorlevel% neq 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end
)

for /f %%r in (result.txt) do set SP=%%r       
if %SP% geq 2 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end
)
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end

:0225-2008
type systeminfo.txt | find /i /v "bios" | find /V "N/A" | find /i "os version" >nul
if %errorlevel% neq 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end
)

for /f %%r in (result.txt) do set SP=%%r       
if %SP% geq 2 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end
)
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end

:0225-2008R2
type systeminfo.txt | find /i /v "bios" | find /V "N/A" | find /i "os version" >nul
if %errorlevel% neq 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end
)

for /f %%r in (result.txt) do set SP=%%r       
if %SP% geq 1 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end
)
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0225-end

:0225-end	
del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0225 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0226 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################         �͹̳� ���� ��ȣȭ ���� ����        ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �͹̳� ���񽺸� ������� �ʴ� ��� ��ȣ                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : �͹̳� ���񽺸� ��� �� ��ȣȭ ������ "Ŭ���̾�Ʈ�� ȣȯ����(�߰�)" �̻����� ������ ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (MinEncryptionLevel	2 �̻��̸� ��ȣ)                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver >= 2008_R2
if %WinVer% geq 4 (
	goto 2-262-enable
) else (
	goto 2-268-enable
)

:2-262-enable
net start | find /i "Remote Desktop Services" >nul
	IF NOT ERRORLEVEL 1 (
		echo �� Remote Desktop Services Enable                                          	>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo �� ���� �͹̳� ���� ��ȣȭ ���� ���� Ȯ��                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo --------------------------------------------------------------------------------- >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\MinEncryptionLevel" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\MinEncryptionLevel" | %script%\awk -F" " {print$3}	> %infosec%\result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                     
		)
	IF ERRORLEVEL 1 (
		echo �� Remote Desktop Services Disable                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=2												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)

goto 2-26-end

:2-268-enable
NET START | FIND "Terminal Service" > NUL
	IF NOT ERRORLEVEL 1 (
		echo �� Terminal Service Enable                                          			>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo �� ���� �͹̳� ���� ��ȣȭ ���� ���� Ȯ��                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo --------------------------------------------------------------------------------- >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\MinEncryptionLevel" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\MinEncryptionLevel" | %script%\awk -F" " {print$3}	> %infosec%\result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
	IF ERRORLEVEL 1 (
		echo �� Terminal Service Disable                                             		 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=2												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)

:2-26-end

	


del %infosec%\result.txt 2>nul

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0226 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0227 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             IIS ������ ���� ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ��ϵ� �� ����Ʈ�� [����� ���� ����] �ǿ���                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : 400, 401, 403, 404, 500 ������ ���� ������ �������� �����Ǿ� �ִ� ��� ��ȣ   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
::echo ��       : (��� ����) prefixLanguageFilePath="%SystemDrive%\inetpub\custerr" path="401.htm" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
rem �⺻ �����̱� ������ �� ������ �����.
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "World Wide Web Publishing Service" > NUL
IF NOT ERRORLEVEL 1 (
	ECHO �� IIS Service Enable                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 1-45-enable
)	ELSE (
	ECHO �� IIS Service Disable                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 46
)

:1-45-enable
echo [��� ����Ʈ]                                                                        	>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	type website-list.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: iis ver <= 6
if %iis_ver_major% leq 6 (
	type website-name.txt                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [�⺻ ����]                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo -----------------------------------------------------                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	%systemroot%\System32\inetsrv\APPCMD list config | findstr "<error"                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

:: iis ver <= 6
if %iis_ver_major% leq 6 (
cscript %script%\adsutil.vbs enum W3SVC | findstr "400, 401, 403, 404, 500,"                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *** ����Ʈ�� ���� Ȯ��                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: iis ver >= 7
if %iis_ver_major% geq 7 (
	for /f "delims=" %%i in (website-name.txt) do (
			echo [WebSite Name] %%i                                          						>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo ---------------------------------------------------------------                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			%systemroot%\System32\inetsrv\appcmd list config %%i | findstr "<error" 				>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)

:: iis ver <= 6
if %iis_ver_major% leq 6 (
	FOR /F "tokens=1 delims=[]" %%i in (website-list.txt) do (
		echo [WebSite AppRoot] %%i                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo -----------------------------------------------------------------------               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		cscript %script%\adsutil.vbs enum %%i/root | findstr "400, 401, 403, 404, 500," > nul
		IF NOT ERRORLEVEL 1 (
			cscript %script%\adsutil.vbs enum %%i/root | findstr "400, 401, 403, 404, 500,"          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) ELSE (
			echo �⺻ ������ ����Ǿ� ����.                                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
			echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
	)
)
echo.                                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:46
echo 0227 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0228 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             SNMP ���� ���� ����             ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: SNMP ���񽺸� ���ʿ��ϰ� ������� ������ ��ȣ                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : SNMP ���񽺴� �����ǰ� ������ SNMP ������ ���� ��� ���ʿ��ϰ� ���۵ǰ� �ִ� ������ �Ǵܵ�. >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "SNMP Service" > NUL
IF NOT ERRORLEVEL 1 (
	ECHO �� SNMP Service Enable                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)	ELSE (
	ECHO �� SNMP Service Disable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [SNMP ValidCommunities ����]                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" | findstr . >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [SNMP Trap ����]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\TrapConfiguration" /s | findstr . >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0228 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0229 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################    SNMP ���� Ŀ�´�Ƽ��Ʈ���� ���⼺ ����   ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: SNMP Community �̸��� public, private �� �ƴ� �����ϱ� ��ư� �����Ǿ� ������ ��� ��ȣ                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (����1) REG_DWORD Community String ����                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (����2) ����: 2=�˸�, 4=�б�����, 8=�б�� ����, 16=�б�� �����             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "SNMP Service" > NUL
IF NOT ERRORLEVEL 1 (
	ECHO �� SNMP Service Enable                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)	ELSE (
	ECHO �� SNMP Service Disable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 29-end
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [SNMP ValidCommunities ����]                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" | findstr . >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" | findstr . >> %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type result.txt | findstr /i "REG_DWORD" > nul
if %ERRORLEVEL% neq 0 (
	echo "string ���� �����Ǿ� ���� ����(N/A)"                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo "���� ���� �ǰ�"                                                						   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo [SNMP Trap Commnunities ����]                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\TrapConfiguration" /s | findstr . >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 29-end
	)


echo [SNMP Trap Commnunities ����]                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\TrapConfiguration" /s | findstr . >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


type result.txt | findstr /i "public private" > nul
	if %ERRORLEVEL% equ 0 (
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	if %ERRORLEVEL% neq 0 (
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	
	
	

:29-end
del %infosec%\result.txt 2>nul
echo 0229 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0230 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################            SNMP Access Control ����           ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: Ư�� ȣ��Ʈ�� SNMP ��Ŷ�� ���� �� �ֵ��� SNMP Access Control�� ������ ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (PermittedManagers ������ ������ ��ȣ)                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (PermittedManagers ������ ������ ��� ȣ��Ʈ���� SNMP ��Ŷ�� ���� �� �־� ���) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "SNMP Service" > NUL
IF NOT ERRORLEVEL 1 (
	ECHO �� SNMP Service Enable                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)	ELSE (
	ECHO �� SNMP Service Disable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 30-end
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [SNMP ValidCommunities ����]                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" | findstr . >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" | findstr . >> %infosec%\result.txt
type %infosec%\result.txt | findstr /i "REG_DWORD" > nul
if %ERRORLEVEL% neq 0 (
	echo "string ���� �����Ǿ� ���� ����(N/A)"                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo "���� ���� �ǰ�"                                                						   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 30-end
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [SNMP Access Control ����]                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" | findstr . >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" | findstr . > %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type %infosec%\result.txt | findstr /i "REG_SZ" > nul
	if %ERRORLEVEL% EQU 0 (
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	if %ERRORLEVEL% NEQ 0 (
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:30-end

del %infosec%\result.txt 2>nul
echo 0230 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0231 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################              DNS ���� ���� ����             ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: DNS ���񽺸� ��� ���� �ʰų� ���� ������Ʈ ������ "����"���� ������ ��� ��ȣ  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (AllowUpdate	0 �̸� ��ȣ)                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : [����]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : ��� ���� ���� ��� DNS ������ ��ϵ� ��/������ ��ȸ ������ ���� ������,      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : DNS ���񽺸� ������� ���� ��� ���񽺸� ������ ���� �ǰ�                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : ������2008�̻󿡼� ��� ���� ���� ��� ����Ʈ�� �������� ����                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "DNS Server" > NUL
IF NOT ERRORLEVEL 1 (
	ECHO �� DNS Service Enable                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto dns-enable
)	ELSE (
	ECHO �� DNS Service Disable                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto dns-end
)
:dns-enable
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr "AllowUpdate" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr "AllowUpdate" >> %infosec%\result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto dns-result1
	)


:: 2003 �̻� �˻�
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr . | find /v "Listing of" | find /v "system was unable" > nul
	IF %ERRORLEVEL% neq 0 (
		reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr "AllowUpdate" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr "AllowUpdate" >> %infosec%\result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) else (
		%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr "AllowUpdate" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones" /s | findstr "AllowUpdate" >> %infosec%\result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)

:dns-result
	type %infosec%\result.txt | findstr /i "AllowUpdate" > nul
	if %ERRORLEVEL% neq 0 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto dns-end
	)

:: winver < 2008R2
if %WinVer% leq 3 (
goto 0231-2008
)

:: winver > 2008
if %WinVer% geq 4 (
 goto 0231-2008R2
)


:0231-2008
type %infosec%\result.txt | findstr /i "AllowUpdate" | find "1" > nul
	if %ERRORLEVEL% neq 0 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto dns-end
	) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto dns-end
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:0231-2008R2
type %infosec%\result.txt | findstr /i "AllowUpdate" | findstr /i "0x1" > nul
	if %ERRORLEVEL% neq 0 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto dns-end
	) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto dns-end
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:dns-end
del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0231 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0232 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             HTTP/FTP/SMTP ��� ����           ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: HTTP/FTP/SMTP ��ʿ� �ý��� ������ ǥ�õ��� �ʴ� ��� ��ȣ                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "World Wide Web Publishing Service" > NUL
IF NOT ERRORLEVEL 1 (
echo ---------------------------------HTTP Banner-------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cscript %script%\http_banner.vbs >nul
	type http_banner.txt								>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2>nul
echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	del http_banner.txt 2>nul
)	ELSE (
	ECHO �� IIS Service Disable                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find /i "ftp" > NUL
IF NOT ERRORLEVEL 1 (
echo -----------------------------------FTP Banner------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cscript %script%\ftp_banner.vbs >nul
	type ftp_banner.txt								>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 2>nul
echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	del ftp_banner.txt 2>nul
)	ELSE (
	ECHO �� FTP Service Disable                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find /i "smtp" > NUL
IF NOT ERRORLEVEL 1 (
echo ---------------------------------SMTP Banner-------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cscript %script%\smtp_banner.vbs >nul
	type smtp_banner.txt								>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	del smtp_banner.txt 2>nul
)	ELSE (
	ECHO �� SMTP Service Disable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0232 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0233 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################                Telnet ���� ����               ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: Telnet ���񽺰� ���� �ǰ� ���� �ʰų�, ��������� NTLM �� ��� ��ȣ             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : [����]                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (SecurityMechanism 2. NTLM)                                            	 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (SecurityMechanism 6. NTLM, Password)                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (SecurityMechanism 4. Password)                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find /i "telnet" > NUL
IF NOT ERRORLEVEL 1 (
	ECHO �� TELNET Service Enable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto telnet-enable
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) ELSE (
	ECHO �� TELNET Service Disable 																	>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto telnet-end
)

:telnet-enable
	%script%\reg query "HKLM\Software\Microsoft\TelnetServer\1.0" /s | findstr . | find /v "Listing of" | find /v "system was unable" > nul
	IF %ERRORLEVEL% neq 0 (
		reg query "HKLM\Software\Microsoft\TelnetServer\1.0" /s | findstr /i "SecurityMechanism" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		reg query "HKLM\Software\Microsoft\TelnetServer\1.0" /s | findstr /i "SecurityMechanism" >> %infosec%\result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) else (
		%script%\reg query "HKLM\Software\Microsoft\TelnetServer\1.0" /s | findstr /i "SecurityMechanism" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKLM\Software\Microsoft\TelnetServer\1.0" /s | findstr /i "SecurityMechanism" >> %infosec%\result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	
:: winver < 2008R2
if %WinVer% leq 3 (
goto 0233-2008
)

:: winver > 2008
if %WinVer% geq 4 (
 goto 0233-2008R2
)


:0233-2008
type %infosec%\result.txt | findstr /i "REG_DWORD" | find "2" > nul
	if %ERRORLEVEL% neq 1 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto telnet-end
	) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto telnet-end
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:0233-2008R2
type %infosec%\result.txt | findstr /i "REG_DWORD" | findstr /i "0x2" > nul
	if %ERRORLEVEL% neq 1 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto telnet-end
	) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto telnet-end
	)
echo.  	
	
	
:telnet-end
del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0233 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0234 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ################# ���ʿ��� ODBC/OLE-DB ������ �ҽ��� ����̺� ���� #################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ý��� DSN �κ��� Data Source�� ���� ����ϰ� �ִ� ��� ��ȣ                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : �ý��� DSN �κ��� Data Source�� ������� �ʴµ� ��ϵǾ� ���� ��� ���       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources" | find "REG_SZ"           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
reg query "HKLM\SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources" | find "REG_SZ"                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��� ���� ���� ��� ���ʿ��� ODBC/OLE-DB�� �������� ���� 							               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0234 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0235 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################          �����͹̳� ���� Ÿ�Ӿƿ� ����        ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ���� �͹̳��� ������� �ʰų�, ��� �� Session Timeout�� �����Ǿ� �ִ� ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (MaxIdleTime ���� Ȯ�� ���: 60000=1��, 300000=5��)                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:: winver <= 2008
if %WinVer% leq 3 (
	goto 35-2008
)

:: winver = 2008_R2
if %WinVer% equ 4 (
	goto 35-2008r2
)

:: winver >= 2012
if %WinVer% geq 5 (
	goto 35-2012
)



:35-2008
NET START > netstart.txt
type netstart.txt | FIND "Terminal Service" > NUL
	IF %ERRORLEVEL% neq 1 (
		echo �� Terminal Service Enable                                          			>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo �� ���� �͹̳� Session Timeout ����                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /s | findstr "MaxIdleTime" > %infosec%\idletime.txt
		type idletime.txt | findstr /v "fInheritMaxIdleTime"                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		type %infosec%\idletime.txt | findstr /v "fInheritMaxIdleTime" | find "REG_DWORD" | %script%\awk -F" " {print$3}        > %infosec%\result.txt
		for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.
		) else (
		echo �� Terminal Service Disable                                             		 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=1												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 35-end		
		)
goto 35-end



:35-2008R2
net start > netstart.txt
type netstart.txt | find /i "Remote Desktop Services" > nul
	IF %ERRORLEVEL% neq 1 (
		echo �� Remote Desktop Services Enable                                          	>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo �� ���� �͹̳� Session Timeout ����                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /s | findstr "MaxIdleTime" > %infosec%\idletime.txt
		type idletime.txt | findstr /v "fInheritMaxIdleTime"                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		type %infosec%\idletime.txt | findstr /v "fInheritMaxIdleTime" | find "REG_DWORD" | %script%\awk -F" " {print$3}        > %infosec%\result.txt
		for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.        
		) else (
		echo �� Remote Desktop Services Disable                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=1												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 35-end		
		)
goto 35-end	


:35-2012
net start > netstart.txt
type netstart.txt | find /i "Remote Desktop Services" > nul
	IF %ERRORLEVEL% neq 1 (
		echo �� Remote Desktop Services Enable                                          	>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo �� ���� �͹̳� Session Timeout ����                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /s | findstr "MaxIdleTime" > %infosec%\idletime.txt
		type idletime.txt | findstr /v "fInheritMaxIdleTime"                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
		echo �� Remote Desktop Services Disable                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=1												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 35-end		
		)
		
	type %infosec%\idletime.txt | findstr /v "fInheritMaxIdleTime" | find "REG_DWORD"	
		if %ERRORLEVEL% neq 0 (
		echo IdleTime ������ �Ǿ� ���� �ʽ��ϴ�.					>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=0												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		) else (
		type %infosec%\idletime.txt | findstr /v "fInheritMaxIdleTime" | find "REG_DWORD" | %script%\awk -F" " {print$3}        > %infosec%\result.txt
		for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.											>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		)
		
goto 35-end	

		
		
:35-end
echo.     																								>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\result.txt 2>nul                                                                                   
del %infosec%\netstart.txt 2>nul                                                                                   
echo 0235 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0236 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ############### ����� �۾��� �ǽɽ����� ����� ��ϵǾ� �ִ��� ���� ################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ����� �۾��� �ǽɽ����� ����� ��ϵǾ� ���� ���� ��� ��ȣ                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver >= 2003
if %WinVer% geq 2 (
	echo �� ����� �۾� Ȯ��                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	schtasks | findstr [0-9][0-9][0-9][0-9]      	                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� at ��ɾ�� ����� �۾� Ȯ��                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
at                                                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver >= 2003
if %WinVer% geq 2 (
	echo [����] schtasks ��ü                                                      				 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	schtasks                 									                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0236 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0301 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################                �ֽ� HOT FIX ����              ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ֽ�Hotfix �Ǵ� PMS(Patch Management System) Agent�� ��ġ�Ǿ� ���� ��� ��ȣ    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type systeminfo.txt | findstr /i "hotfix kb"                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0301 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0302 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             ��� ���α׷� ������Ʈ            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ���̷��� ��� ���α׷��� �ֽ� ���� ������Ʈ�� ��ġ�Ǿ� �ִ� ��� ��ȣ           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� ���� (��� ������Ʈ ���� Ȯ��)                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0302 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0303 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################          ��å�� ���� �ý��� �α� ����         ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �̺�Ʈ ���� ������ �Ʒ��� ���� �����Ǿ� �ִ� ��� ��ȣ                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (1) �α׿� �̺�Ʈ, ���� �α׿� �̺�Ʈ, ��å ���� : ����/���� ����             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (2) ���� ����, ���͸� ���� �׼���, ���� ��� : ���� ����                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\auditpol  | findstr "Logon Policy Directory Management Privilege"                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\auditpol  | findstr "Logon Policy Directory Management Privilege"                   > %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

%script%\auditpol  | findstr "Logon Policy"  							                 > %infosec%\result1.txt
%script%\auditpol  | findstr "Directory Management Privilege"          			         > %infosec%\result2.txt



type %infosec%\result.txt | find "No" > nul
if %errorlevel% equ 0 (
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 3-03end
)


type %infosec%\result1.txt | find /V "Success and Failure" > nul
if %errorlevel% equ 0 (
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 3-03end
)

type %infosec%\result2.txt | find /V "Success and Failure" | find /V "Failure" > nul
if %errorlevel% equ 0 (
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)


:3-03end
del %infosec%\result.txt 2>nul
del %infosec%\result1.txt 2>nul
del %infosec%\result2.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0303 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0401 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################           �α��� ������ ���� �� ����          ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �αױ�Ͽ� ���� ������ ����, �м�, ����Ʈ �ۼ� �� ���� ���� ��ġ�� �̷������ ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� ���� (����� ���ͺ� ����)                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0401 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0402 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################   �������� �׼����� �� �ִ� ������Ʈ�� ���   ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: Remote Registry Service �� �����Ǿ� ���� ��� ��ȣ                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "Remote Registry" > NUL
IF NOT ERRORLEVEL 1 (
	ECHO �� Remote Registry Service Enable                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)	ELSE (
	ECHO �� Remote Registry Service Disable                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find "Remote Registry"                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0402 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0403 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################              �̺�Ʈ �α� ���� ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ִ� �α� ũ�� 10240KB (10MB) �̻��̰�, Retention 7776000(90��) �̻��̸� ��ȣ   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : "90�� ���� �̺�Ʈ ���"���� �����Ǿ� ���� ��� ��ȣ(Windows2008 �̻��� ����)                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (MaxSize 10485760 �̻�, Retention 7776000 �̻�)                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : Retention 0       = �ʿ��� ��� �̺�Ʈ �����                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : Retention 7776000 = �������� ������ �̺�Ʈ ����� (7776000 90��)            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : Retention -1      = �̺�Ʈ ����� ����(�������� �α� �����)                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [Application Log Size]                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\MaxSize"     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [Security Log Size]                                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security\MaxSize"        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [System Log Size]                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System\MaxSize"          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

::Win <= 2003
if %WinVer% leq 2 (
	echo [Application log Retention]                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Application\Retention"   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo [Security log Retention]                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\Security\Retention"      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo [System log Retention]                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Services\Eventlog\System\Retention"        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) ELSE (
		echo �� Windows2008 �̻��� ����� ��¥ ���� �Ұ�			   	     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0403 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0404 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################      ���ݿ��� �̺�Ʈ �α� ���� ���� ����      ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �α� ���͸��� ���ѿ� Everyone �� ���� ��� ��ȣ                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (1) �ý��� �α� ���͸�: %systemroot%\system32\config                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (2) IIS �α� ���͸�: %systemroot%\system32\LogFiles                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
cacls %systemroot%\system32\config                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
cacls %systemroot%\system32\config                                                           > %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
if exist iis-enable.txt (
	echo �� IIS Service Enable                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cacls %systemroot%\system32\logfiles                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	cacls %systemroot%\system32\logfiles                                                         >> %infosec%\result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
	echo �� IIS Service Disable                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 0404-end
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
type %infosec%\result.txt | find /I "everyone" > nul
	if %errorlevel% neq 0 (
	echo Everyone ������ �������� �ʽ��ϴ�.                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) else (
	echo 
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:0404-end

del %infosec%\result.txt 2>nul
echo 0404 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0501 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################               ��� ���α׷� ��ġ              ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ���̷��� ��� ���α׷��� ��ġ�Ǿ� �ִ� ��� ��ȣ                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
set vaccine="kaspersky norton bitdefender turbo avast v3"

echo �� Process List                                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
for %%a IN (%vaccine%) DO (
type tasklist.txt | findstr /i %%a 															>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type tasklist.txt | findstr /i %%b >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type tasklist.txt | findstr /i %%c >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type tasklist.txt | findstr /i %%d >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type tasklist.txt | findstr /i %%e >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type tasklist.txt | findstr /i %%f >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo. 																						 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� Service list                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
for %%a IN (%vaccine%) DO (
net start | findstr /i %%a >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | findstr /i %%b >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | findstr /i %%c >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | findstr /i %%d >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | findstr /i %%e >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | findstr /i %%f >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����� ���� ��� ���μ��� ��� �� ���ͺ並 ���� Ȯ�� �ʿ�                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0501 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0502 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################            SAM ���� ���� ���� ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: SAM ���� ���ٱ��ѿ� Administrator, System �׷츸 ���������� ��ϵ� ��� ��ȣ  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
cacls %systemroot%\system32\config\SAM							                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
cacls %systemroot%\system32\config\SAM							                             > %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type %infosec%\result.txt | find /V "NT AUTHORITY\SYSTEM" | find /V "BUILTIN\Administrators" | find "\" > nul
	if %errorlevel% neq 0 (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) 
	if %errorlevel% equ 0 (
	echo.                                                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
echo.                                                                              	     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\result.txt 2>nul
echo 0502 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0503 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################                ȭ�麸ȣ�� ����                ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ȭ�� ��ȣ�⸦ �����ϰ�, ��ȣ�� ����ϸ�, ��� �ð��� 10���� ��� ��ȣ            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ������Ʈ�� ���� ���� ��� AD �Ǵ� OS��ġ �� ������ ���� ���� �����             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaveActive"                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaverIsSecure"                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaveTimeOut"                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [AD(Active Directory)�� ��� ������]                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaverIsSecure" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaveTimeOut" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaveActive"                             > %infosec%\result.txt
%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaverIsSecure"                         >> %infosec%\result.txt
type %infosec%\result.txt | find /V "1" | find /I "REG_SZ" > nul
if %errorlevel% equ 0 (
	goto 5.03-start
	echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKCU\Control Panel\Desktop\ScreenSaveTimeOut"                           > %infosec%\result.txt
type result.txt | %script%\awk -F" " {print$3}      						                >> %infosec%\result1.txt
for /f %%r in (result1.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 5.03-end
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:5.03-start
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaverIsSecure" > %infosec%\result.txt

type %infosec%\result.txt | find /V "0" | find /V "unable to find" | find /I "REG_SZ" > nul
	if %errorlevel% neq 0 (
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 5.03-end
	)
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop\ScreenSaveTimeOut" > %infosec%\result.txt
	type result.txt | %script%\awk -F" " {print$3}      						                >> %infosec%\result1.txt
	for /f %%r in (result1.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

:5.03-end

del %infosec%\result.txt 2>nul
del %infosec%\result1.txt 2>nul
echo.                                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0503 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0504 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################        �α׿����� �ʰ� �ý��� ���� ���       ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "�α׿� ���� �ʰ� �ý��� ���� ���"�� "������"���� �����Ǿ� �ִ� ��� ��ȣ    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (ShutdownWithoutLogon	0 �̸� ��ȣ)                                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon" > nul
if %errorlevel% equ 0 (
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon" | %script%\awk -F" " {print$3}     >> %infosec%\result.txt
for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
del %infosec%\result.txt 2>nul
echo 0504 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0505 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################     ���� �ý��ۿ��� �ý��� ���� ���� ����     ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "���� �ý��ۿ��� ������ �ý��� ����" ��å�� "Administrators"�� ������ ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (Administrators = *S-1-5-32-544)                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "SeRemoteShutdownPrivilege"                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "SeRemoteShutdownPrivilege" | %script%\awk -F= {print$2} >> %infosec%\result.txt
for /F "delims=, tokens=1-26" %%a in (result.txt) do (
	echo %%a  >> result2.txt 2> nul
	echo %%b  >> result2.txt 2> nul
	echo %%c  >> result2.txt 2> nul
	echo %%d  >> result2.txt 2> nul
	echo %%e  >> result2.txt 2> nul
	echo %%f  >> result2.txt 2> nul
	echo %%g  >> result2.txt 2> nul
	echo %%h  >> result2.txt 2> nul
	echo %%i  >> result2.txt 2> nul
	echo %%j  >> result2.txt 2> nul
	echo %%k  >> result2.txt 2> nul
	echo %%l  >> result2.txt 2> nul
	echo %%m  >> result2.txt 2> nul
	echo %%n  >> result2.txt 2> nul
	echo %%o  >> result2.txt 2> nul
	echo %%p  >> result2.txt 2> nul
	echo %%q  >> result2.txt 2> nul
	echo %%r  >> result2.txt 2> nul
	echo %%s  >> result2.txt 2> nul
	echo %%t  >> result2.txt 2> nul
	echo %%u  >> result2.txt 2> nul
	echo %%v  >> result2.txt 2> nul
	echo %%w  >> result2.txt 2> nul
	echo %%x  >> result2.txt 2> nul
	echo %%y  >> result2.txt 2> nul
	echo %%z  >> result2.txt 2> nul
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type %infosec%\result2.txt | find /V "Administrators" | find /V "S-1-5-32-544" | find /V "ECHO is off" > nul
if %errorlevel% equ 0 (
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt			
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\result.txt 2>nul
del %infosec%\result2.txt 2>nul
echo 0505 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0506 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ################# ���� ���縦 �α��� �� ���� ��� ��� �ý��� ���� #################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "���� ���縦 �α��� �� ���� ��� ��� �ý��� ����" ��å�� "������"���� �����Ǿ� �ִ� ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (CrashOnAuditFail = 4,0 �̸� ��ȣ)                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt 
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "CrashOnAuditFail"                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "CrashOnAuditFail" | %script%\awk -F= {print$2}       >> %infosec%\result.txt
for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul
echo 0506 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0507 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################     SAM ������ ������ �͸� ���� ��� �� ��    ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "SAM ������ ������ �͸� ���� ��� ����" ��å�� "���"�̰�,                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : "SAM ������ �͸� ���� ��� ����" ��å�� "���"���� �����Ǿ� �ִ� ��� ��ȣ    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (restrictanonymous	1 �̰�, RestrictAnonymousSAM	1 �̸� ��ȣ)                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [SAM ������ ������ �͸� ���� ��� ���� ����]                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\LSA\restrictanonymous"             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [SAM ������ �͸� ���� ��� ���� ����]                                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM"	         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

%script%\reg query "HKLM\SYSTEM\CurrentControlSet\Control\LSA\restrictanonymous" | %script%\awk -F" " {print$3}       > %infosec%\result.txt
for /f %%r in (result.txt) do set restrict=%%r


%script%\reg query "HKLM\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM"	| %script%\awk -F" " {print$3}         > %infosec%\result.txt
for /f %%s in (result.txt) do echo Result=%restrict%:%%s												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\result.txt 2>nul
echo 0507 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0508 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################              Autologon ��� ����              ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: AutoAdminLogon ���� ���ų�, AutoAdminLogon 0���� �����Ǿ� �ִ� ��� ��ȣ        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (DefaultPassword ��Ʈ���� �����Ѵٸ� ������ ���� �ǰ�)                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo [AutoAdminLogon (1:Enable, 0:Disable, Default:Disable)]                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		reg export "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" AutoLogon_REG_Export.txt /Y > nul
		type %infosec%\AutoLogon_REG_Export.txt | findstr /i "AutoAdminLogon" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo. 																						>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [Username]                                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		reg export "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" AutoLogon_REG_Export.txt /Y > nul
		type %infosec%\AutoLogon_REG_Export.txt | findstr /i "DefaultUserName" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo. 																						>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [DefaultPassword]                                                                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		reg export "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" AutoLogon_REG_Export.txt /Y > nul
		type %infosec%\AutoLogon_REG_Export.txt | findstr /i "DefaultPassword" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type %infosec%\AutoLogon_REG_Export.txt | findstr /i "AutoAdminLogon" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type %infosec%\AutoLogon_REG_Export.txt | findstr /i "AutoAdminLogon" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0508-enable
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=0												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0508-end
)


:0508-enable

:: winver < 2008R2
if %WinVer% leq 3 (
goto 0508-2008
)

:: winver > 2008
if %WinVer% geq 4 (
 goto 0508-2008R2
)


:0508-2008
type %infosec%\result.txt | find "1" > nul
	if %ERRORLEVEL% neq 1 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=1												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 0508-end
	) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=0												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 0508-end
	)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:0508-2008R2
type %infosec%\result.txt | find "0" > nul
if %errorlevel% equ 0 (
	echo Result=0                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
	echo Result=1                                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 0508-end


:0508-end
::del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0508 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0509 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################       �̵��� �̵�� ���� �� ������ ���       ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "�̵��Ĺ̵�� ���� �� ������ ���" ��å�� "Administrators"���� �Ǿ� �ְų�, ����� ���� ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (����� ������ �ƹ� �׷쵵 ���ǵ��� ����: Default Administrators�� ��� ���� ��ȣ) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (AllocateDASD=1,"0" �̸� Administrators ��ȣ)                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (AllocateDASD=1,"1" �̸� Administrators �� Power Users)                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (AllocateDASD=1,"2" �̸� Administrators �� Interactive Users)                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "AllocateDASD"                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����� ���� ��� Default�� Administrators �� ��� ������ 							>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type Local_Security_Policy.txt | Find /I "AllocateDASD" > nul
if %errorlevel% neq 0 (
echo Result=0												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
type Local_Security_Policy.txt | Find /I "AllocateDASD" | %script%\awk -F, {print$2} | find "0" > nul
if %errorlevel% equ 0 (
echo Result=0												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
type Local_Security_Policy.txt | Find /I "AllocateDASD" | %script%\awk -F, {print$2} | find "1" > nul
if %errorlevel% equ 0 (
echo Result=1												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
type Local_Security_Policy.txt | Find /I "AllocateDASD" | %script%\awk -F, {print$2} | find "2" > nul
if %errorlevel% equ 0 (
echo Result=2												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0509 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0510 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             ��ũ���� ��ȣȭ ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "������ ��ȣ�� ���� ������ ��ȣȭ" ��å�� ���� �� ��� ��ȣ                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	FOR /F "tokens=1 delims=\" %%a IN ("%cd%") DO (
		echo %%a\ 																			 > %infosec%\inf_using_drv.txt
	)
	echo �� current using drive volume														 > %infosec%\inf_Encrypted_file_check.txt
	type inf_using_drv.txt 																	 >> %infosec%\inf_Encrypted_file_check.txt
	FOR /F "tokens=1" %%a IN (inf_using_drv.txt) DO (
		echo.								 												 >> %infosec%\inf_Encrypted_file_check.txt
		echo �� Search within the %%a drive...  											 >> %infosec%\inf_Encrypted_file_check.txt
		cipher /s:%%a | find "E "        												 	 >> %infosec%\inf_Encrypted_file_check.txt 2> nul
		if errorlevel 1 echo Encrypted file is not exist 									 >> %infosec%\inf_Encrypted_file_check.txt
		echo.								 												 >> %infosec%\inf_Encrypted_file_check.txt
	)
	type inf_Encrypted_file_check.txt 														 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver = 2003
if %WinVer% equ 2 (
	echo �� Current using drive volume 														 > %infosec%\inf_Encrypted_file_check.txt
	type inf_using_drv.txt 																	 >> %infosec%\inf_Encrypted_file_check.txt

	FOR /F "tokens=1" %%a IN (inf_using_drv.txt) DO (
		echo.								 												 >> %infosec%\inf_Encrypted_file_check.txt
		echo �� Search within the %%a drive...  											 >> %infosec%\inf_Encrypted_file_check.txt
		cipher /s:%%a | find "E " | findstr "^E"											 >> %infosec%\inf_Encrypted_file_check.txt 2> nul
		if errorlevel 1 echo Encrypted file is not exist 									 >> %infosec%\inf_Encrypted_file_check.txt
		echo.								 												 >> %infosec%\inf_Encrypted_file_check.txt
	)
	type inf_Encrypted_file_check.txt 														 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver <= 2008
if %WinVer% geq 3 (
	echo �� Windows 2008 �̻� �ش���� ���� 													 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0510 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0511 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################          Dos���� ��� ������Ʈ�� ����         ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: Dos ���ݿ� ���� ��� ������Ʈ���� �����Ǿ� �ִ� ��� ��ȣ                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (1) SynAttackProtect = REG_DWORD 0 �� 1 �� ���� �� ��ȣ                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (2) EnableDeadGWDetect = REG_DWORD 1(True) �� 0 ���� ���� �� ��ȣ             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (3) KeepAliveTime = REG_DWORD 7,200,000(2�ð�) �� 300,000(5��)���� ���� �� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (4) NoNameReleaseOnDemand = REG_DWORD 0(False) �� 1 �� ���� �� ��ȣ           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver >= 2008
if %WinVer% geq 3 (
	echo �� Windows 2008 �̻� �ش���� ����                             			 				>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 5.11-end
) else (
	echo [SynAttackProtect ����]                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\SynAttackProtect" /s >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo [EnableDeadGWDetect ����]                                                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\EnableDeadGWDetect" /s >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo [KeepAliveTime ����]                                                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\KeepAliveTime" /s >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo [NoNameReleaseOnDemand ����]                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo --------------------------------------------------------                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\NoNameReleaseOnDemand" /s >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\SynAttackProtect" /s > %infosec%\result.txt

type %infosec%\result.txt | findstr "0 unable" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 5.11-end
)
%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\EnableDeadGWDetect" /s > %infosec%\result.txt
type %infosec%\result.txt | findstr "1 unable" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 5.11-end
)
%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\NoNameReleaseOnDemand" /s > %infosec%\result.txt
type %infosec%\result.txt | findstr "0 unable" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
goto 5.11-end
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\KeepAliveTime" /s > %infosec%\result.txt
type %infosec%\result.txt | find "KeepAliveTime" > nul
if %errorlevel% equ 0 (
%script%\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\KeepAliveTime" /s | %script%\awk -F" " {print$3}       > %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

:5.11-end
del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0511 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0512 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################  ����ڰ� ������ ����̹��� ��ġ�� �� ���� �� ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "����ڰ� ������ ����̹��� ��ġ�� �� ���� ��" ��å�� "���"���� ������ ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (AddPrinterDrivers=4,1 �̸� ��ȣ)                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "AddPrinterDrivers"                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "AddPrinterDrivers" | %script%\awk -F= {print$2}       >> %infosec%\result.txt
for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

del %infosec%\result.txt 2>nul


echo 0512 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0513 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################   ���� ������ �ߴ��ϱ� ���� �ʿ��� ���޽ð�   ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "�α׿� �ð��� ����Ǹ� Ŭ���̾�Ʈ ���� ����" ��å�� "���"���� �����ϰ�,       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : "���� ������ �ߴ��ϱ� ���� �ʿ��� ���� �ð�" ��å�� "15��"���� ������ ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (EnableForcedLogOff	1 �̰�, AutoDisconnect	15 �̸� ��ȣ)                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\System\CurrentControlSet\Services\LanManServer\Parameters\EnableForcedLogOff" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\System\CurrentControlSet\Services\LanManServer\Parameters\AutoDisconnect" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


%script%\reg query "HKLM\System\CurrentControlSet\Services\LanManServer\Parameters\EnableForcedLogOff" > %infosec%\result.txt
type %infosec%\result.txt | find "EnableForcedLogOff" | find "1" > nul
if %errorlevel% neq 0 (
set Result01=0
) else (
set Result01=1
)

%script%\reg query "HKLM\System\CurrentControlSet\Services\LanManServer\Parameters\AutoDisconnect" | %script%\awk -F" " {print$3}       > %infosec%\result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
for /f %%r in (result.txt) do set Result02=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

if %Result01% equ 1 (
	if %Result02% geq 15 (
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=O                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)else (
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=F                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

	)
) else (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0513 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0514 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################                ��� �޽��� ����               ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ý����� �ҹ����� ��뿡 ���� ��� �޽���/������ �����Ǿ� �ִ� ��� ��ȣ        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [Win NT]                                                            					 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeCaption" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\LegalNoticeText" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [Win 2000�̻�]                                                            				>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticecaption" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\legalnoticetext" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0514 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0515 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################         ����ں� Ȩ ���͸� ���� ����        ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ����� ������ Ȩ ���͸��� Eveyone ������ ���� ��� ��ȣ                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo. > %infosec%\home-directory.txt
dir "C:\Users\*" | find "<DIR>" | findstr /V "All Defalt ."                                  >> %infosec%\home-directory.txt
FOR /F "tokens=5" %%i IN (home-directory.txt) DO cacls "C:\Users\%%i" | find /I "Everyone" > nul
IF %ERRORLEVEL% equ 1 (
echo �� Everyone ������ �Ҵ�� Ȩ���͸��� �߰ߵ��� �ʾ���.                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=O												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) ELSE (
	FOR /F "tokens=5" %%i IN (home-directory.txt) DO cacls "C:\Users\%%i" | find /I "Everyone" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0515 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0516 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################              LAN Manager ���� ����            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "LAN Manager ���� ����" ��å�� "NTLMv2 ���丸 ����"���� �����Ǿ� �ִ� ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����  : (LM NTML ���� ����: LmCompatibilityLevel=4,0)                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (LM NTML NTLMv2���� ���� ���(����� ���): LmCompatibilityLevel=4,1)         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (NTLM ���� ����: LmCompatibilityLevel=4,2)                                    >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (NTLMv2 ���丸 ����: LmCompatibilityLevel=4,3)                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (NTLMv2 ���丸 ����WLM�ź�: LmCompatibilityLevel=4,4)                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (NTLMv2 ���丸 ����WLM�ź� NTLM �ź�: LmCompatibilityLevel=4,5)               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : ���� ���� ��� �ƹ��͵� ������ �� �� ������                                   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �ش� ������ �����ϸ� Ŭ���̾�Ʈ�� ���� �Ǵ� ���� ���α׷����� ȣȯ���� ������ ��ĥ �� ����. >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "LmCompatibilityLevel"           					 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "LmCompatibilityLevel" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Find /I "LmCompatibilityLevel" | %script%\awk -F= {print$2}       >> %infosec%\result.txt
for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ���� ���� ���� ����                                                                     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0516 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0517 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################   ���� ä�� ������ ������ ��ȣȭ �Ǵ� ����    ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: �Ʒ� 3���� ��å�� "���" ���� �Ǿ� ���� ��� ��ȣ                               >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: (1) ������ ������: ���� ä�� �����͸� ������ ��ȣȭ �Ǵ� ����(�׻�)           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��     : (2) ������ ������: ���� ä�� �����͸� ������ ��ȣȭ(������ ���)              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��     : (3) ������ ������: ���� ä�� �����͸� ������ ����(������ ���)                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��     : (4,1)���, (4,0)��� �� ��                							  		 	>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
type Local_Security_Policy.txt | Findstr /I "RequireSignOrSeal SealSecureChannel SignSecureChannel" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

type Local_Security_Policy.txt | Findstr /I "RequireSignOrSeal SealSecureChannel SignSecureChannel" | findstr "4.0 unable" > nul
if %errorlevel% equ 0 (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=4,0												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) else (
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=4,1												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

echo 0517 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0518 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             ���� �� ���丮 ��ȣ             ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ���Ͻý����� ���� ����� ���� ���ִ� NTFS�� ��� ��ȣ                           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	fsutil fsinfo drives 																	 > %infosec%\inf_using_drv_temp1.txt
	type inf_using_drv_temp1.txt | find /i "\" 												 > %infosec%\inf_using_drv_temp2.txt
	echo.																					 > %infosec%\inf_using_drv_temp3.txt
	FOR /F "tokens=1-26" %%a IN (inf_using_drv_temp2.txt) DO (
		echo %%a >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%b >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%c >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%d >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%e >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%f >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%g >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%h >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%i >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%j >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%k >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%l >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%m >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%n >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%o >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%p >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%q >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%r >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%s >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%t >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%u >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%v >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%w >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%x >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%y >> %infosec%\inf_using_drv_temp3.txt 2> nul
		echo %%z >> %infosec%\inf_using_drv_temp3.txt 2> nul
	)
	type inf_using_drv_temp3.txt | find /i "\" | find /v "A:\" 								 > %infosec%\inf_using_drv.txt
	FOR /F "tokens=1" %%a IN (inf_using_drv.txt) DO (
		echo.                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo %%a                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		fsutil fsinfo drivetype %%a												 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		fsutil fsinfo volumeinfo %%a												 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		fsutil fsinfo drivetype %%a												 > %infosec%\result.txt
	type %infosec%\result.txt | find /I "Fixed Drive" > nul
	type %infosec%\result.txt | find /I "Fixed Drive" > nul
	if not errorlevel 1 (
	fsutil fsinfo volumeinfo %%a												 >> %infosec%\result1.txt
	)
)
	type %infosec%\result1.txt | find /I "File System Name" | find /i "fat" > nul
	if %errorlevel% equ 0 (
	echo.                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=FAT												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) else (
	echo.                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=NTFS												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
	
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo [����]                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo C: ����̺� ���� Ȯ��(NTFS�� ��� ������ ���� �ο� ������ ��µ�)                       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
cacls c:\ 																					 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


del %infosec%\result.txt 2>nul
del %infosec%\result1.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0518 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0519 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################        ��ǻ�� ���� ��ȣ �ִ� ��� �Ⱓ        ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: "��ǻ�� ���� ��ȣ ���� ��� ����" ��å "������"���� ���� �Ǿ� �ְ�,           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : "��ǻ�� ���� ��ȣ �ִ� ��� �Ⱓ" ��å�� "90��"�� �����Ǿ� �ִ� ��� ��ȣ     >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (DisablePasswordChange=4,0 �̰�, MaximumPasswordAge=4,90 �̸� ��ȣ)           >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	echo Win 2000 �ش���� ����                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 5.19-end
)
:: winver >= 2003
if %WinVer% geq 2 (
	type Local_Security_Policy.txt | Findstr /I "\MaximumPasswordAge disablepasswordchange"      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

type Local_Security_Policy.txt | Find /I "disablepasswordchange" | find "4,0" > nul
if %errorlevel% neq 0 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=F												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 5.19-end
) 
	
type Local_Security_Policy.txt | Find /I "disablepasswordchange" | find "4,0" > nul
if %errorlevel% equ 0 (
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	type Local_Security_Policy.txt | Find /I "\MaximumPasswordAge" | %script%\awk -F, {print$2}       > %infosec%\result.txt
	for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

:5.19-end
del %infosec%\result.txt 2>nul
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0519 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0520 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################             �������α׷� ��� �м�            ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: ���� ���α׷����� ���ʿ��� ���񽺰� ��ϵǾ� ���� �ʰ�, �ֱ������� �����ϴ� ��� ��ȣ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (����� ���ͺ� �� ���� ���α׷� ���˰��� ���� Ȯ��)                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� ���α׷� Ȯ��(HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run)  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	%script%\reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run"         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver >= 2003
if %WinVer% geq 2 (
	%script%\reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" | findstr . | find /v "Listing of" | find /v "system was unable" >nul
	IF NOT ERRORLEVEL 0 (
		reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) else (
		%script%\reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ���� ���α׷� Ȯ��(HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run) >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ---------------------------------------------------------------------------------       >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	%script%\reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run"        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
:: winver >= 2003
if %WinVer% geq 2 (
	%script%\reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" | findstr . | find /v "Listing of" | find /v "system was unable" >nul
	IF NOT ERRORLEVEL 0 (
		reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) else (
		%script%\reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo Result=M/T												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0520 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0601 START >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
SET /A item_count+=1
echo [+] %item_count%
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##################            Windows ���� ��� ���             ###################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ����: Windows ���� ���� �����Ǿ� �ִ� ��� ��ȣ (LoginMode 1 �̸� ��ȣ)             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (1) LoginMode 1 �̸� Windows ���� ���                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��       : (2) LoginMode 2 �̸� SQL Server �� Windows ���� ���                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �� ��Ȳ                                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	echo Win 2000 �ش���� ����                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	goto 6.01-end
)

:: winver >= 2003
if %WinVer% geq 2 (
	net start | find "SQL Server" > NUL
	IF NOT ERRORLEVEL 1 (
		ECHO �� SQL Server Enable                                                                  >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 6.01-start
		echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)	ELSE (
		ECHO �� SQL Server Disable                                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo Result=N/A												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		goto 6.01-end
	)
)


:6.01-start

%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server" /s | find "LoginMode" > nul
	IF %ERRORLEVEL% neq 0 (
		reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server" /s | find "LoginMode" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server" /s | find "LoginMode" | %script%\awk -F" " {print$3}       > %infosec%\result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	) else (
		%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server" /s | find "LoginMode" >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		%script%\reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server" /s | find "LoginMode" | %script%\awk -F" " {print$3} > %infosec%\result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		for /f %%r in (result.txt) do echo Result=%%r												>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
		echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
	)

:6.01-end
del %infosec%\result.txt 2>nul

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo 0601 END >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo @@FINISH>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

::�ý��� ���� ��� ����
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###############################  Interface Information  ############################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
ipconfig /all                                                                                >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###############################  System Information  ################################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


:: winver = 2000
if %WinVer% equ 1 (
	%script%\psinfo                                                                          > systeminfo.txt
	echo Hotfix:                                                                             >> systeminfo.txt
	%script%\reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\HotFix"            >> systeminfo.txt
	type systeminfo.txt                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)

:: winver >= 2003
if %WinVer% geq 2 (
	type %infosec%\systeminfo_ko.txt                                                         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###############################  tasklist Information  ################################ >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
:: winver = 2000
if %WinVer% equ 1 (
	%script%\pslist                                                                          > tasklist.txt
	type %infosec%\tasklist.txt	                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	
)

:: winver >= 2003
if %WinVer% geq 2 (
	tasklist																				 > %infosec%\tasklist.txt 2>nul
	type %infosec%\tasklist.txt	                                                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt	
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo #################################  Port Information  ################################## >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
netstat -an | find /v "TIME_WAIT"                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ############################  Service Daemon Information  ############################# >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net start | find /v "started" | find /v "completed"                                          >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ##########################  Environment Variable Information  ######################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
set											                                                 >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################  metabase.xml  ################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
IF EXIST C:\WINDOWS\system32\inetsrv\MetaBase.xml (
	type C:\WINDOWS\system32\inetsrv\MetaBase.xml                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
) ELSE (
	echo C:\WINDOWS\system32\inetsrv\MetaBase.xml �������� ����.                             >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
)
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ###############                      ���� ����                     #################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ####################################################################################### >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ****************************  User Accounts List  *****************************         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net user | find /V "successfully"                                                            >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ************************  Group List - net localgroup  ************************         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
net localgroup | find /V "successfully"                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo *****************************  Account Information  ***************************         >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
FOR /F "tokens=1,2,3 skip=4" %%i IN ('net user') DO (
net user %%i >> account.txt 2>nul
net user %%j >> account.txt 2>nul
net user %%k >> account.txt 2>nul
)
type account.txt>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt

::�ý��� ���� ��� ��



::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::: ���� �κ� ����2::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



echo.>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.>> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo END_RESULT                                                                              >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
del %infosec%\account.txt 2>nul
del %infosec%\account_temp1.txt 2>nul
del %infosec%\account_temp2.txt 2>nul
del %infosec%\admin-account.txt 2>nul
del %infosec%\service.txt 2>nul
del %infosec%\idletime.txt 2>nul
del %infosec%\home-directory.txt 2>nul
del %infosec%\home-directory-acl.txt 2>nul
del %infosec%\Local_Security_Policy.txt 2>nul
del %infosec%\net-accounts.txt 2>nul
del %infosec%\reg-website-list.txt 2>nul
del %infosec%\systeminfo.txt 2>nul
del %infosec%\systeminfo_ko.txt 2>nul
del %infosec%\tasklist.txt 2>nul
del %infosec%\real_ver.txt 2>nul
del %infosec%\inf_share_folder.txt 2>nul
del %infosec%\inf_share_folder_temp.txt 2>nul
del %infosec%\inf_share_folder_temp_sed.txt 2>nul
del %infosec%\inf_share_folder_temp_sed2.txt 2>nul
del %infosec%\inf_Encrypted_file_check.txt 2>nul
del %infosec%\AutoLogon_REG_Export.txt 2>nul


rem Netbios ����
del %infosec%\2-18-netbios-list-1.txt 2> nul
del %infosec%\2-18-netbios-list-2.txt 2> nul
del %infosec%\2-18-netbios-list.txt 2> nul
del %infosec%\2-18-netbios-query.txt 2> nul
del %infosec%\2-18-netbios-result.txt 2> nul


rem DB ���� ����
del %infosec%\unnecessary-user.txt 2>nul
del %infosec%\password-null.txt 2>nul


rem IIS ���� del
del %infosec%\iis-enable.txt 2>nul
del %infosec%\iis-version.txt 2>nul
del %infosec%\website-list.txt 2>nul
del %infosec%\website-name.txt 2>nul
del %infosec%\website-physicalpath.txt 2>nul
del %infosec%\sample-app.txt 2>nul


rem FTP ���� del
del %infosec%\ftp-enable.txt 2>nul
del %infosec%\ftpsite-list.txt 2>nul
del %infosec%\ftpsite-name.txt 2>nul
del %infosec%\ftpsite-physicalpath.txt 2>nul
del %infosec%\ftp-ipsecurity.txt 2>nul


rem ���� ����̺� ��� ���� del
del %infosec%\inf_using_drv_temp3.txt 2>nul
del %infosec%\inf_using_drv_temp2.txt 2>nul
del %infosec%\inf_using_drv_temp1.txt 2>nul
del %infosec%\inf_using_drv.txt 2>nul



echo.                                                                                        >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo �������������������������������������   END Time  �������������������������������������   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
date /t                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
time /t                                                                                      >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt


echo.
echo ��������������������������������������   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ����                                                              ����   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ����       Windows %WinVer_name% Security Check is Finished       ����   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ����                                                              ����   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo ��������������������������������������   >> %infosec%\%COMPUTERNAME%.WINDOWS.%WinVer_name%.result.txt
echo.
echo [+] Windows Security Check is Finished
pause

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::: ���� �κ� ��2::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

