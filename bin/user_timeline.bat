@echo off
set WASSR_MINUS=%CD%/..
perl -I%WASSR_MINUS%/lib/ ./user_timeline.pl win
pause
