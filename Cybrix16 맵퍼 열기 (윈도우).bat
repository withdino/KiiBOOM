@echo off
rem Cybrix 16 Mapper - double-click to open in Chrome/Edge (Windows)
cd /d "%~dp0"
start "" powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0windows\serve.ps1"
