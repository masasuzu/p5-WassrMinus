@echo off
set WASSR_MINUS=%CD%/..
set /p INPUT=
perl -I%WASSR_MINUS%/lib/ ./update.pl win %INPUT%
pause
