@echo off
rem Getting rsync setup:
rem Install cygwin 64-bit
rem Open a cygwin console, and do
rem   mkpasswd -l > /etc/passwd
rem   mkgroup -l > /etc/group
rem   mkpasswd -c >> /etc/passwd
rem   mkgroup -c >> /etc/group
rem Edit your cygwin/etc/passwd file and fix up your home directory to something like /cygdrive/c/Users/YOU
rem Do chmod 700 /cygdrive/c/Users/YOU/.ssh/id_rsa
rem Add your rsa key to authorized_keys on the "debugsym" user on deploy.imqs.co.za

rem NOTE: The source directory here is hardcoded to /cygdrive/c/temp/DebugSymbols/

setlocal
set path=c:\cygwin64\bin;c:\Windows\System32;c:\Windows
c:\cygwin64\bin\rsync -rzt --itemize-changes --no-p --no-g --chmod=ugo=rwX --delete --delete-delay --fuzzy /cygdrive/c/temp/DebugSymbols/ debugsym@deploy.imqs.co.za:symbols/

