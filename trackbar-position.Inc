
   include windows.inc
   include user32.inc
   include kernel32.inc
   
   includelib user32.lib
   includelib kernel32.lib


WinMain proto :DWORD,:DWORD,:DWORD,:DWORD


.data
   ClassName db "MainWinClass",0
   AppName  db "Main Window",0
   
   szEdit			db 'Edit',0		;����������� ���� ���� (������ �����)
   szEdit_text		db 'My Text',0		; ���� ����
   szButton		db 'Button',0		;����������� ���� ���� (������)
   szButton_title		db 'Clik me',0		; ���� ����
   szScroll db 'ScrollBar',0
   szTrack db 'msctls_trackbar32', 0
   szProgress db 'msctls_progress32', 0
   
   pos dd 0
   buf			db MAX_PATH dup(0)	; ����� ���� �� ������ ������ ���� ����-������
   szCaptin		db 'Title.....',0		; ��������� MessageBox'�


.data?
   hInstance HINSTANCE ?
   CommandLine LPSTR ?

   hScroll		dd ?
   hTrack		dd ?
   hProgress	dd ?

