@echo off
rmdir /s /q f:\important\back\coder\.deploy_git
rmdir /s /q f:\important\back\coder\public
rmdir /s /q f:\important\back\coder\source\_posts
xcopy C:\Users\Administrator\myblog F:\important\back\coder /d /y /e
echo. & pause
