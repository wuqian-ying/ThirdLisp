.386
.model flat,stdcall
	option casemap:none
include windows.inc
include kernel32.inc
includelib kernel32.lib
include user32.inc
includelib user32.lib
;--------------------------------------------------------------------------------

.data
walloc proto object:dword,muls:dword
func struct
;;filebuf offset and length 
;;length mov to ecx
	way dd ?
	len dw 0	
func ends
pros struct
	;;func array offset
	master dd ? 
	where dd ?
	sizes dd 0
pros ends
;--------------------------------------------------------------------------------
;easy to understand but have many trouble
ways struct
	;;handle of funcs;;
	;;max memory size 946716 may i have
	;;increate the max size to tackle 4Gb file
	;;lost some performance
	a dd 1024,4096,8192,32768,32768
	way dd 5 dup (?)
	apoint dd 0
	max dd 0
	nowaddr dd ?
ways ends
way ways <>
path ways <>
heaps dd ?
count byte 0
spaceFlag byte 0
;--------------------------------------------------------------------------------
.code
read proc,fbuf:dword,len:dword
;;function better than this
	invoke GetProcessHeap
	mov heaps,eax	
	mov ebp,esp
	push ebx
	push edi
	invoke walloc,addr path,12
	push path.nowaddr
	invoke walloc,addr way,6
	mov way.max,eax
	mov ecx,sizeof fbuf
	mov esi,fbuf
	shr ecx,1	
	looop:
	mov eax,$

	cmp ecx,0
	jne [12]
	dec ecx
	mov ax,[esi]
	add esi,2
	;;
	.if al==28h
	;;addr
	mov ebx,[esp]		
	mov eax,way.nowaddr
	mov (pros ptr [ebx]).where,eax
	mov eax,[esp+8]
	inc count
	mov (pros ptr [ebx]).master,eax	
	add ebx,12
	;;alloc memory
	.if ebx ==path.max
	invoke walloc,addr path,12
	mov ebx,eax
	.endif
	push edi
	push ebx
	;;pass futility character
	.elseif count==0
	jmp looop
	.elseif al==29h
	pop ebx
	dec count
	mov (pros ptr [ebx]).sizes,edi
	add [esp],edi
	pop edi
	
	
	
	;;separate here copy it to your separator
	.elseif al == 20h
	;;can move to al>20h that seem will get better
	.if spaceFlag>0
		mov spaceFlag,0
		add way.nowaddr,6
	.endif
	.elseif al>20h
	mov ebx,way.nowaddr
	cmp spaceFlag,0
	inc (func ptr [ebx]).len
	jne looop
	
	;;alloc memory
	.if ebx==way.max
	invoke walloc,addr way,6
	mov way.max,eax
	.endif
	lea eax,[esi-2]
	inc spaceFlag
	mov (func ptr [ebx]).way,eax
	inc edi
	.endif
	
	cmp ecx,0
	
	jne looop
	mov esp,ebp
	ret

read endp
;; dynamic memory alloc
walloc proc,object:dword,muls:dword
	mov edx,(ways ptr [object]).apoint
	mov ebx,[(ways ptr [object]).a+edx*4]
	mov eax,muls	
	mul ebx	
	inc (ways ptr [object]).apoint	
	mov ebx,eax
	invoke HeapAlloc,heaps,HEAP_GENERATE_EXCEPTIONS,eax		
	mov [(ways ptr [object]).way+edx*4],eax	
	mov (ways ptr [object]).nowaddr,eax
	add eax,ebx
	ret
walloc endp