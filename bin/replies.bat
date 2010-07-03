@echo off
set WASSR_MINUS=%CD%/..
perl -I%WASSR_MINUS%/lib/ ./replies.pl win
pause
