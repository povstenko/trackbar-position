
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
   buf			db MAX_PATH dup(0)	; буфер куди ми будемо писати вміст вікна-стрічки
   szCaptin		db 'Title.....',0		; заголовок MessageBox'а


.data?
   hInstance HINSTANCE ?
   CommandLine LPSTR ?

   hEdit		dd ?				;змінна для хендлу рядка-стрічки
   hButton	dd ?				; змінна для хендлу кнопки


