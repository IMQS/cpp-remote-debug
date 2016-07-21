# cpp-remote-debug
Helper scripts and documentation for remote debugging C++ code

Basic steps for debugging C++ code in production:

1. Install the Windows Debugging Tools, by installing the Windows SDK, and ticking just that option
2. Launch windbg as administrator
3. Set symbol server path to something like srv*c:\debug-symbols*\\tsclient\c\temp\DebugSymbols
	An alternative thing that might work, is when you connect to the machine via remote desktop, 
	you choose to map your network drive "O:", which is "Developer Data", and home of Development/DebugSymbols.
	If that works, then you don't need any of the scripts in here to help fetch debug symbols from the
	network onto your own PC.
	Also consider srv*c:\debug-symbols*\\tsclient\c\temp\DebugSymbols;srv*c:\debug-symbols*http://deploy.imqs.co.za/debug-symbols
5. Copy source files from your PC to the server, eg. robocopy /mir \\tsclient\c\dev\individual\otaku\proj\adb c:\jenkins\workspace\stable\otaku\proj\adb
6. Attach to process
7. Open source files. View callstack. Click buttons on call stack to show source, and show source args, etc.
8. Can use F9 to set breakpoints in source.
9. Remember you can use .reload to reload symbols.

The scripts inside this repo were built when I was using rsync to upload debug symbols to deploy.imqs.co.za. That also works.
With that scenario, you can use srv*c:\debug-symbols*https://deploy.imqs.co.za/debug-symbols. Some day we may decide
to automatically sync our symbol store to deploy.imqs.co.za, but this is rare enough that I'm not sure it's warranted.
