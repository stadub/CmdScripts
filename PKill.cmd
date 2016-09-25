@echo off
set "App=%1"
taskkill /FI "IMAGENAME eq %App%"