
.data
class ways <>
var ways <>
code ways <>
.code

define proc,kind:dword,location:dword,NameDef:dword
	mov esi,NameDef
	mov ecx,sizeof NameDef
	ret

define endp

execute proc,funaddr:dword
	call ecx
	ret

execute endp

