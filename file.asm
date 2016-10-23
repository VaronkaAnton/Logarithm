;calculating logarithm of 2 using the formula
;log 2 = (sum{1/k(4k^2-1)}+ 1)/2

.686
PUBLIC _Iterations
.model flat
option casemap: none
.data
	iter	dd ?
	sum		dq ?
	tmp		dd ?
	two		dd 2
.code
_Iterations proc
	push ebp
	mov ebp, esp
	mov iter, 1
	fldz			;0 -> top
	fstp sum		;top->sum; top++
iteration:
	finit
	fild iter		;iter->top
	mov eax, iter
	mul iter
	mov ecx, 4
	mul ecx
	sub eax, 1		;4k^2-1
	mov tmp, eax
	fild tmp		;(4k^2 - 1) -> st(0), k -> st(1)
	fmul			;iter*tmp, remains in stack
	fist tmp		;k(4k^2-1)

	fld1
	fdivr			;1/k(4k^2-1)
	fld sum		
	fadd			;sum += 1/k(4k^2-1)

	fst sum
	fld1
	fadd
	fild two
	fdiv		;our value
	fldln2
	fsub
	fabs		;abs(ln2 - value)
	inc iter

	fld qword ptr [ebp + 8] ;eps->st(0)
	fcom
	fstsw ax		;flags -> ax
	sahf			;ax -> EFLAGS
	ja exit_		; if eps > abs(...)
	jmp iteration

exit_:
	dec iter
	mov eax, iter
	pop ebp
	ret
_Iterations endp
end