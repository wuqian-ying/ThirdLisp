
.386
.model stdcall,flat
option casemap:none
	
include the_lisp.inc

include fileParse.asm
include functions.asm
include processfile.asm
;--------------------------------------------------------------------------------
.data
outf dd ?
inf dd ?
split proto,sizes:dword,strs:dword,char:byte

stdin dd ?
stdout dd ?
stdbuff byte 256 dup(?)
stdinpoint dword ?
databuf db 4096 dup(?)
codebuf db 4096 dup(?)
.code
start proc
	invoke GetStdHandle,STD_INPUT_HANDLE
	mov stdin,eax
	invoke GetStdHandle,STD_OUTPUT_HANDLE
	mov stdout,eax
	invoke ReadConsoleInput,stdin,stdbuff,sizeof stdbuff,stdinpoint
	invoke split,stdinpoint,stdin,20h
	;;params parse
		
	invoke CreateFile,edi,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL
	mov inf,eax
	
start endp
;;ebp was number of reward all of reward  in stack
split proc,sizes:dword,strs:dword,char:byte
	mov edi,strs
	mov al,char
	looop:
	repne scasb	
	mov byte ptr [edi],0h
	repe scasb
	loop looop
	ret
split endp
end start