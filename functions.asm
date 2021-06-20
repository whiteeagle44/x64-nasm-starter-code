section	.text
global _func, func		; '_func' for compatiility with NASM for Windows

_func:
func:
	; subroutine prologue
	sub rsp, 8     		; room for a 64-bit local var: rbx
	push rbx        	; save callee-save register
	mov	rax, rdi		; save address of *a (param 1) to rax

	; subroutine body
replace_loop:
	mov bl, [rax]		; move value at address rax into 8bit register bl
	cmp bl, 0			; check if reached end of string
	je exit_loop		; if yes, go to exit_loop
	cmp bl, 'a'			; check if current letter is 'a'
	jne increment_loop	; if not, go to increment_loop
	mov	BYTE [rax], '*'	; it is 'a' so change it to '*'

increment_loop:
    inc rax				; increment address of string by one byte
    jmp replace_loop	; go to replace_loop

exit_loop:
	; subroutine epilogue
	xor	rax, rax		; rax = 0
	pop rbx				; bring back the caller's value of rbx from the stack
	add rsp, 8			; deallocate local var: rbx
	ret