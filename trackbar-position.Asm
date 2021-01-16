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
	mov   wc.hbrBackground,COLOR_WINDOW+1
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
           CW_USEDEFAULT,740,500,NULL,NULL,\
           hInst,NULL
	mov   hwnd,eax
	
	
	invoke CreateWindowEx,NULL,addr szTrack,0,\
			WS_CHILD or WS_VISIBLE or TBS_AUTOTICKS,\
			10,10,700,50,hwnd,0,hInstance,0
	mov hTrack,eax	
	
	invoke CreateWindowEx,NULL,addr szProgress,0,\
			WS_CHILD or WS_VISIBLE or WS_BORDER,\
			10,70,700,50,hwnd,0,hInstance,0
	mov hProgress,eax
	
	invoke CreateWindowEx,NULL,addr szScroll,0,\
			WS_CHILD or WS_VISIBLE,\
			10,130,700,40,hwnd,0,hInstance,0
	mov hScroll,eax
	
	invoke SetScrollRange, hScroll, SB_CTL, 0, 100, TRUE
	invoke SendMessage, hTrack, TBM_SETTICFREQ, 100, 0
	
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
	
	mov eax,uMsg
	.IF eax == WM_DESTROY
		invoke PostQuitMessage,NULL
	.ELSEIF eax == WM_CREATE
	.ELSEIF eax == WM_COMMAND
	
	.ELSEIF eax==WM_KEYDOWN
		mov		eax,lParam
		shr		eax,16
		and		eax,7FFFh
		.if eax==014Dh
			;Right
			add pos, 1
			invoke SendMessage, hTrack, TBM_SETPOS, pos, TRUE
			invoke SendMessage, hProgress, PBM_SETPOS, pos, 0
			invoke SendMessage, hScroll, SBM_SETPOS, pos, TRUE
		.elseif eax==014Bh
			;Left
			sub pos, 1
			invoke SendMessage, hTrack, TBM_SETPOS, pos, TRUE
			invoke SendMessage, hProgress, PBM_SETPOS, pos, 0
			invoke SendMessage, hScroll, SBM_SETPOS, pos, TRUE
		.endif
	.ELSEIF eax == WM_HSCROLL

		invoke SendMessage, hTrack, TBM_GETPOS, 0, 0
		mov pos, eax
		
		invoke SendMessage, hProgress, PBM_SETPOS, pos, 0
		invoke SendMessage, hScroll, SBM_SETPOS, pos, TRUE
		
	.ELSE
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
		ret
	.ENDIF
	
	xor eax,eax
	ret
WndProc endp


end start
