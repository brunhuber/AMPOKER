cseg	segment	public	para	'CODE'
org	100h
assume	cs:cseg,ds:cseg
;bx=hl
;al=a
;dx=de
;_cx=bc
start:
	mov	dx,offset file1
	xor	cx,cx
	mov	ax,4301h
	int	21h
	mov	ah,3ch
	int	21h
	mov	h1,ax
	mov	bx,1000h
	mov	ah,4ah
	int	21h
	mov	bx,2000h
	mov	ah,48h
	int	21h
	cld
	mov	es,ax
	mov	_seg,ax
	mov	index,0
	xor	di,di
_s0:	mov	cl,1
	call	_332
	mov	ax,_c036
	stosw
	call	_w1
	inc	contor
	cmp	di,65530
	jc	_s1
	mov	ax,es
	add	ax,800h
	mov	es,ax
	sub	di,8000h
	inc	index
_s1:	cmp	contor,2
	jc	_s0
	xor	si,si
	mov	cx,contor
	dec	cx
	push	ds
	mov	ds,cs:_seg
_s2:	lodsw
	cmp	ax,cs:_c036
	jz	_c00
	cmp	si,65530
	jc	_s3
	mov	ax,ds
	add	ax,800h
	mov	ds,ax
	sub	si,8000h
_s3:	loop	_s2
	pop	ds
	jmp	_s0
_c00:	pop	ds
	mov	bx,h1
	mov	ah,3eh
	int	21h
	ret

_w1:	push	ax bx cx dx di es cs
	pop	es
	mov	di,offset buf1
	mov	al,byte ptr _c036
	call	_hex
	mov	al,byte ptr _c036+1
	call	_hex
	mov	dx,offset buf1
	mov	cx,7
	mov	bx,h1
	mov	ah,40h
	int	21h
	pop	es di dx cx bx ax
	ret
_hex:	mov	ah,al
	and	ax,0ff0h
	shr	al,4
	or	ax,3030h
	cmp	al,'9'+1
	jc	_h1
	add	al,7
_h1:	cmp	ah,'9'+1
	jc	_h2
	add	ah,7
_h2:	stosw
	inc	di
	ret


_332:	mov	bx,_c036
	or	bx,bx
	jnz	_344
	mov	bl,_r
	mov	bh,_r
	add	bh,3
	mov	_c036,bx
	jmp	_332
_344:	mov	bx,_c036
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

h1	dw	?
file1	db	'siruri.txt',0
buf1	db	?,?,',',?,?,13,10
_seg	dw	?
index	dw	?
contor	dw	?
tabel	db	'RVDT'
carti	db	'23456789ZJQKA'
_r	db	0
_c036	dw	05639h
_c038	db	?
cseg	ends
end	start