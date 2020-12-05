
   include windows.inc
   include user32.inc
   include kernel32.inc
   
   includelib user32.lib
   includelib kernel32.lib


WinMain proto :DWORD,:DWORD,:DWORD,:DWORD


.data
   ClassName db "MainWinClass",0
   AppName  db "Main Window",0
   
   szEdit			db 'Edit',0		;стандартний клас вікна (стрічка вводу)
   szEdit_text		db 'My Text',0		; вміст вікна
   szButton		db 'Button',0		;стандартний клас вікна (кнопка)
   szButton_title		db 'Clik me',0		; вміст вікна
   szScroll db 'ScrollBar',0
   szTrack db 'msctls_trackbar32', 0
   szProgress db 'msctls_progress32', 0
   
   buf			db MAX_PATH dup(0)	; буфер куди ми будемо писати вміст вікна-стрічки
   szCaptin		db 'Title.....',0		; заголовок MessageBox'а


.data?
   hInstance HINSTANCE ?
   CommandLine LPSTR ?

   hEdit		dd ?
   hButton		dd ?
   hScroll		dd ?
   hTrack		dd ?
   hProgress	dd ?

