cseg	segment	public	para	'CODE'
org	100h
assume	cs:cseg,ds:cseg
;bx=hl
;al=a
;dx=de
;_cx=bc
start:
	mov	cl,64h
	call	_332
	mov	cl,64h
	call	_332
	mov	al,_c038
	cmp	al,40
	mov	dl,'N'
	jc	_ds
	mov	dl,'D'
_ds:	mov	ah,6
	int	21h
	mov	dl,32
	mov	ah,6
	int	21h
	mov	cx,10
lup:	push	cx
	mov	cl,32h
	call	_332
	mov	cl,4
	call	_332
	push	word ptr _c038
	mov	cl,0dh
	call	_332
	mov	bx,offset carti
	xlat
	mov	dl,al
	mov	ah,6
	int	21h
	pop	ax
	mov	bx,offset tabel
	xlat
	mov	dl,al
	mov	ah,6
	int	21h
	pop	cx
	loop	lup
;	mov	ax,_c036
;	mov	bl,_c038
;	int	3
	ret


_332:	mov	bx,_c036
	test	bl,2
	mov	dh,0
	jnz	_34c
	inc	dh
_34c:	test	bh,128
	mov	al,0
	jnz	_354
	inc	ax
_354:	xor	al,dh
	shr	al,1
	rcr	bx,1

	and	bl,254
	mov	_c036,bx
	shr	bx,1
	mov	dl,0
	mov	dh,cl
	mov	ch,8

_36b:	inc	ch
	shl	dh,1
	jnc	_36b
	shr	dh,1
	or	dh,128

_372:	sbb	bx,dx
	jnc	_377
	add	bx,dx
_377:	shr	dx,1
	dec	ch
	jnz	_372

	mov	al,bl
	mov	_c038,al
	ret

tabel	db	'RVDT'
carti	db	'23456789ZJQKA'
_r	db	0
_c036	dw	0f5dah
_c038	db	?
cseg	ends
end	start