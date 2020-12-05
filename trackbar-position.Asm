.586
.model flat,stdcall
option casemap:none
include trackbar-position.Inc
.code

; ---------------------------------------------------------------------------


start:
	invoke GetModuleHandle, NULL
	mov    hInstance,eax
	
	invoke GetCommandLine
	mov    CommandLine,eax
	
	invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
	invoke ExitProcess,eax

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
	LOCAL wc:WNDCLASSEX
	LOCAL msg:MSG
	LOCAL hwnd:HWND
	
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInstance
	pop   wc.hInstance
	mov   wc.hbrBackground,COLOR_BTNFACE+1
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,OFFSET ClassName
	
	invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
	mov   wc.hIconSm,eax
	
	invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
	
	invoke RegisterClassEx, addr wc
	
	INVOKE CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
           WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,\
           CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,NULL,NULL,\
           hInst,NULL
	mov   hwnd,eax
	
	invoke CreateWindowEx,WS_EX_CLIENTEDGE,addr szEdit,addr szEdit_text,\ ; стрічка вводу
			ES_CENTER or WS_VISIBLE or WS_CHILD,\
			10,10,150,20,hwnd,0,hInstance,0
	mov hEdit,eax					; збережемо хендл в змінну
	invoke CreateWindowEx,NULL,addr szButton,addr szButton_title,\		; кнопка
			BS_BOTTOM or BS_CENTER or WS_CHILD or WS_VISIBLE,\
			10,60,70,20,hwnd,0,hInstance,0
	mov hButton,eax	

	
	invoke ShowWindow, hwnd,SW_SHOWNORMAL
	invoke UpdateWindow, hwnd
	
	.WHILE TRUE
		invoke GetMessage, ADDR msg,NULL,0,0
		.BREAK .IF (!eax)
		invoke TranslateMessage, ADDR msg
		invoke DispatchMessage, ADDR msg
	.ENDW
	
	mov     eax,msg.wParam
	ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
	
	mov eax,uMsg	; запишемо повідомлення  у регістр еах, для простоти
	.IF eax==WM_DESTROY
		invoke PostQuitMessage,NULL
	.ELSEIF eax==WM_CREATE
	.elseif eax == WM_COMMAND		; якщо виконання якась команда
		mov eax,hButton		
		.if lParam == eax			; перевіримо, якщо lParam  = хендлу кнопки (кнопка натиснута)
			invoke GetWindowText,hEdit,addr buf,MAX_PATH	; візьмемо текст з вікна-стрічки і запишемо у буфер buf
			invoke MessageBox,0,addr buf,addr szCaptin,MB_OK	; виведемо 
		.endif

	.ELSE
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
		ret
	.ENDIF
	
	xor eax,eax
	ret
WndProc endp


end start
