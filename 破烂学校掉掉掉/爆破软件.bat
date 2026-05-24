@echo off
chcp 65001 >nul
color 4F
title 希沃(Seewo) 全盘斩首
cls

echo.
echo ╔══════════════════════════════════════════════════════╗
echo ║  希沃(Seewo) 全盘斩首 · 文件级详细清除              ║
echo ╚══════════════════════════════════════════════════════╝
echo.

:: ===== 获取脚本目录 =====
set SCRIPT_DIR=%~dp0
echo [INFO] 脚本目录：%SCRIPT_DIR%
echo.

:: ===== 查找壁纸 =====
for %%e in (jpg jpeg png bmp) do (
    for %%i in ("%SCRIPT_DIR%\*.%%e") do (
        set WALLPAPER=%%i
        goto :found_wall
    )
)

:found_wall
if not defined WALLPAPER (
    echo [WARN] 未检测到壁纸图片，跳过换壁纸
) else (
    echo [INFO] 发现壁纸文件：%WALLPAPER%
)
echo.

:: ===== STEP 1 =====
echo [STEP 1] 终止希沃相关进程...
taskkill /f /im EasiNote*.exe >nul 2>&1
taskkill /f /im SeewoService.exe >nul 2>&1
taskkill /f /im SeewoGuard.exe >nul 2>&1
taskkill /f /im SeewoManager.exe >nul 2>&1
taskkill /f /im SeewoIot*.exe >nul 2>&1
taskkill /f /im SeewoCampus*.exe >nul 2>&1

sc stop SeewoService >nul 2>&1
sc stop SeewoGuard >nul 2>&1
sc config SeewoService start= disabled >nul 2>&1
sc config SeewoGuard start= disabled >nul 2>&1

echo.
echo   [OK] 希沃进程已全部终止
echo.
color 2F
echo Copyright (c) 2023, The LAOLIPEF.NT Open Source Project
echo.
echo   Licensed under the Apache License, Version 2.0 (the "License");
echo   you may not use this file except in compliance with the License.
echo.
echo   Unless required by applicable law or agreed to in writing, software
echo   distributed under the License is distributed on an "AS IS" BASIS,
echo   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
echo   See the License for the specific language governing permissions and
echo   limitations under the License.
echo.
color 4F

:: ===== STEP 2 =====
echo.
echo [STEP 2] 全盘扫描并删除 Seewo / 希沃（显示详细信息）...
echo ════════════════════════════════════════════════════════

for /r C:\ %%i in (*seewo* *Seewo* *希沃*) do (
    if exist "%%i" (
        forfiles /p "%%~dpi" /m "%%~nxi" /c "cmd /c echo 删除时间：%time% && echo 文件大小：@fsize 字节 && echo 文件路径：@path && echo 文件名：@file"
        del /f /q "%%i" >nul 2>&1
        rd /s /q "%%i" >nul 2>&1
    )
)

echo ════════════════════════════════════════════════════════
echo.
echo   [OK] 全盘 Seewo / 希沃 清除完成
echo.
color 2F
echo Copyright (c) 2023, The LAOLIPEF.NT Open Source Project
echo.
echo   Licensed under the Apache License, Version 2.0 (the "License");
echo   you may not use this file except in compliance with the License.
echo.
echo   Unless required by applicable law or agreed to in writing, software
echo   distributed under the License is distributed on an "AS IS" BASIS,
echo   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
echo   See the License for the specific language governing permissions and
echo   limitations under the License.
echo.
color 4F

:: ===== STEP 3 =====
echo.
echo [STEP 3] 清理注册表残留...
reg delete "HKCU\Software\Seewo" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Seewo" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Seewo" /f >nul 2>&1
schtasks /delete /tn "Seewo*" /f >nul 2>&1

echo.
echo   [OK] 注册表 & 计划任务清理完成
echo.
color 2F
echo Copyright (c) 2023, The LAOLIPEF.NT Open Source Project
echo.
echo   Licensed under the Apache License, Version 2.0 (the "License");
echo   you may not use this file except in compliance with the License.
echo.
echo   Unless required by applicable law or agreed to in writing, software
echo   distributed under the License is distributed on an "AS IS" BASIS,
echo   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
echo   See the License for the specific language governing permissions and
echo   limitations under the License.
echo.
color 4F

:: ===== STEP 4 =====
if defined WALLPAPER (
    echo.
    echo [STEP 4] 强制设置桌面壁纸...
    reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%WALLPAPER%" /f >nul
    reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 2 /f >nul
    reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d 0 /f >nul
    rundll32.exe user32.dll,UpdatePerUserSystemParameters
    echo.
    echo   [OK] 壁纸已强制更换
    echo.
    color 2F
    echo Copyright (c) 2023, The LAOLIPEF.NT Open Source Project
    echo.
    echo   Licensed under the Apache License, Version 2.0 (the "License");
    echo   you may not use this file except in compliance with the License.
    echo.
    echo   Unless required by applicable law or agreed to in writing, software
    echo   distributed under the License is distributed on an "AS IS" BASIS,
    echo   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    echo   See the License for the specific language governing permissions and
    echo   limitations under the License.
    echo.
    color 4F
)

:: ===== STEP 5 =====
echo.
echo [STEP 5] 阉割注册表编辑器 & 任务管理器...
echo.

set REGEDIT=C:\Windows\regedit.exe
set TASKMGR=C:\Windows\System32\taskmgr.exe
set RECYCLE=%USERPROFILE%\AppData\Local\Microsoft\Windows\Recycle Bin

move /y "%REGEDIT%" "%RECYCLE%" >nul 2>&1
move /y "%TASKMGR%" "%RECYCLE%" >nul 2>&1

if not exist "%REGEDIT%" (
    echo   x regedit.exe 已移入回收站
) else (
    echo   x regedit.exe 移动失败
)

if not exist "%TASKMGR%" (
    echo   x taskmgr.exe 已移入回收站
) else (
    echo   x taskmgr.exe 移动失败
)

echo.
echo   [OK] 系统管理工具已阉割
echo.
color 2F
echo Copyright (c) 2023, The LAOLIPEF.NT Open Source Project
echo.
echo   Licensed under the Apache License, Version 2.0 (the "License");
echo   you may not use this file except in compliance with the License.
echo.
echo   Unless required by applicable law or agreed to in writing, software
echo   distributed under the License is distributed on an "AS IS" BASIS,
echo   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
echo   See the License for the specific language governing permissions and
echo   limitations under the License.
echo.
color 4F

:: ===== 最后5秒 =====
echo.
echo ╔══════════════════════════════════════════════════════╗
echo ║  希沃清除完成 · 系统阉割完成 · 即将重启             ║
echo ╚══════════════════════════════════════════════════════╝

for /l %%i in (5,-1,1) do (
    color 2F
    echo.
    echo   COM.LAOLIPEF.PE_END已完成使命！
    echo   一切事物的末与末终成其首
    echo   本代码开源网站将放在：
    echo   https://github.com/XiaoGuanJi/LTX
    echo.
    color 4F
    echo   [REBOOT] %%i 秒后重启...
    timeout /t 1 >nul
)

echo.
echo [ACTION] 正在重启系统...
shutdown /r /t 0

