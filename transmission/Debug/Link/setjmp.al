
	.CSEG
;PCODE: $00000000 VOL: 0
;PCODE: $00000001 VOL: 0
;PCODE: $00000002 VOL: 0
;PCODE: $00000003 VOL: 0
    ld   r26,y
;PCODE: $00000004 VOL: 0
    clr  r27
;PCODE: $00000005 VOL: 0
;PCODE: $00000006 VOL: 0
;PCODE: $00000007 VOL: 0
    clr  r30
;PCODE: $00000008 VOL: 0
    clr  r31
;PCODE: $00000009 VOL: 0
_setjmp_entry:
;PCODE: $0000000A VOL: 0
    sbiw r30,0
;PCODE: $0000000B VOL: 0
    brne _setjmp1
;PCODE: $0000000C VOL: 0
    ldi  r24,low(_setjmp_entry)
;PCODE: $0000000D VOL: 0
    st   x+,r24  ;save ret_addr
;PCODE: $0000000E VOL: 0
    ldi  r24,high(_setjmp_entry)
;PCODE: $0000000F VOL: 0
    st   x+,r24
;PCODE: $00000010 VOL: 0
    st   x+,r28  ;data_sp=Y
;PCODE: $00000011 VOL: 0
    st   x+,r29
;PCODE: $00000012 VOL: 0

;PCODE: $00000013 VOL: 0
    in   r24,spl
;PCODE: $00000014 VOL: 0
    in   r25,sph
;PCODE: $00000015 VOL: 0
    adiw r24,2   ;when saving SP skip past return address, 18112014_1
;PCODE: $00000016 VOL: 0
    st   x+,r24
;PCODE: $00000017 VOL: 0
    st   x+,r25
;PCODE: $00000018 VOL: 0

;PCODE: $00000019 VOL: 0
    pop  r25     ;get the 16-bit return address in R24, R25
;PCODE: $0000001A VOL: 0
    pop  r24
;PCODE: $0000001B VOL: 0
    push r24
;PCODE: $0000001C VOL: 0
    push r25
;PCODE: $0000001D VOL: 0
    st   x+,r24  ;save the 16-bit return address
;PCODE: $0000001E VOL: 0
    st   x+,r25
;PCODE: $0000001F VOL: 0
    in   r24,sreg
;PCODE: $00000020 VOL: 0
    st   x,r24   ;status=SREG
;PCODE: $00000021 VOL: 0
    rjmp _setjmp_exit
;PCODE: $00000022 VOL: 0
_setjmp1:
;PCODE: $00000023 VOL: 0
    cli
;PCODE: $00000024 VOL: 0
    ld   r28,x+  ;restore Y
;PCODE: $00000025 VOL: 0
    ld   r29,x+
;PCODE: $00000026 VOL: 0
    ld   r24,x+  ;restore SP
;PCODE: $00000027 VOL: 0
    out  spl,r24
;PCODE: $00000028 VOL: 0
    ld   r24,x+
;PCODE: $00000029 VOL: 0
    out  sph,r24
;PCODE: $0000002A VOL: 0
    ld   r24,x+  ;preload the hardware stack with the 16-bit return address
;PCODE: $0000002B VOL: 0
    push r24
;PCODE: $0000002C VOL: 0
    ld   r24,x+
;PCODE: $0000002D VOL: 0
    push r24
;PCODE: $0000002E VOL: 0
    ld   r24,x   ;restore SREG
;PCODE: $0000002F VOL: 0
    out  sreg,r24
;PCODE: $00000030 VOL: 0
_setjmp_exit:
;PCODE: $00000031 VOL: 0
;PCODE: $00000032 VOL: 0
;PCODE: $00000033 VOL: 0
;PCODE: $00000034 VOL: 0
;PCODE: $00000035 VOL: 0
;PCODE: $00000036 VOL: 0
;PCODE: $00000037 VOL: 0
;PCODE: $00000038 VOL: 0
;PCODE: $00000039 VOL: 0
    ldd  r26,y+2
;PCODE: $0000003A VOL: 0
    clr  r27
;PCODE: $0000003B VOL: 0
;PCODE: $0000003C VOL: 0
;PCODE: $0000003D VOL: 0
    ld   r30,y
;PCODE: $0000003E VOL: 0
    ldd  r31,y+1
;PCODE: $0000003F VOL: 0
    sbiw r30,0
;PCODE: $00000040 VOL: 0
    brne _longjmp1
;PCODE: $00000041 VOL: 0
    ldi  r30,1
;PCODE: $00000042 VOL: 0
    clr  r31
;PCODE: $00000043 VOL: 0
_longjmp1:
;PCODE: $00000044 VOL: 0
    ld   r24,x+  ;preload the hardware stack with the 16-bit return address
;PCODE: $00000045 VOL: 0
    push r24
;PCODE: $00000046 VOL: 0
    ld   r24,x+
;PCODE: $00000047 VOL: 0
    push r24
;PCODE: $00000048 VOL: 0
;PCODE: $00000049 VOL: 0
;PCODE: $0000004A VOL: 0
;PCODE: $0000004B VOL: 0
;PCODE: $0000004C VOL: 0
