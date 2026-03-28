@echo off
DEL /F /A /Q \\?\%1
RD /S /Q \\?\%1
echo 尝试强制删除完成。
pause