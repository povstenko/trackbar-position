
   include windows.inc
   include user32.inc
   include kernel32.inc
   
   includelib user32.lib
   includelib kernel32.lib


WinMain proto :DWORD,:DWORD,:DWORD,:DWORD


.data
   ClassName db "MainWinClass",0
   AppName  db "Main Window",0

.data?
   hInstance HINSTANCE ?
   CommandLine LPSTR ?

