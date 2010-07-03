@echo off
set WASSR_MINUS=%CD%/..
perl -I%WASSR_MINUS%/lib/ ./public_timeline.pl win
pause
