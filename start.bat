@echo off
title Local Voice Assistant — Launcher

echo.
echo  ==========================================
echo   Local Voice Assistant ^| Ollama + Llama
echo  ==========================================
echo.

REM ── Find ollama.exe ──────────────────────────────────────────
set OLLAMA_EXE=ollama
where ollama >nul 2>&1
if %errorlevel% neq 0 (
    if exist "D:\Ollama\ollama.exe" (
        set OLLAMA_EXE=D:\Ollama\ollama.exe
    ) else if exist "C:\Program Files\Ollama\ollama.exe" (
        set OLLAMA_EXE=C:\Program Files\Ollama\ollama.exe
    ) else (
        echo  [ERROR] ollama.exe not found!
        echo  Please install Ollama from https://ollama.com
        echo  or set the correct path in this script.
        pause
        exit /b 1
    )
)

REM ── Check if Ollama is already running ───────────────────────
curl -s http://localhost:11434 >nul 2>&1
if %errorlevel% equ 0 (
    echo  [OK] Ollama is already running on port 11434
) else (
    echo  [..] Starting Ollama server...
    set OLLAMA_ORIGINS=*
    start "" /b "%OLLAMA_EXE%" serve
    timeout /t 3 /nobreak >nul
    echo  [OK] Ollama started
)

REM ── Check if model exists ────────────────────────────────────
echo.
echo  [..] Checking for llama3.2:1b model...
"%OLLAMA_EXE%" list | find "llama3.2:1b" >nul 2>&1
if %errorlevel% neq 0 (
    echo  [..] Model not found. Downloading llama3.2:1b (~1.3 GB)...
    echo       This only happens once. Please wait...
    echo.
    "%OLLAMA_EXE%" pull llama3.2:1b
    echo.
    echo  [OK] Model downloaded!
) else (
    echo  [OK] Model llama3.2:1b is ready
)

REM ── Open the voice assistant in browser ──────────────────────
echo.
echo  [..] Opening voice assistant in your browser...
start "" "%~dp0index.html"

echo.
echo  ==========================================
echo   Voice assistant is running!
echo   - Talk to it in your browser
echo   - Keep this window open (Ollama server)
echo   - Press Ctrl+C to stop
echo  ==========================================
echo.
pause
