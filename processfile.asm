
.data
exe dd 0

.code
porcess proc
	
	
	looop2:
	mov ebx,path.nowaddr
	mov eax,(pros ptr [ebx]).where
	mov cx,(func ptr [eax]).len
	looop3:
	loop looop3
	
	loop looop2
	
	ret

porcess endp

execute proc,funaddr:dword
	mov eax,funaddr
	call eax
	ret

execute endp