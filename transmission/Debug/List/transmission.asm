
;CodeVisionAVR C Compiler V3.37 Evaluation
;(C) Copyright 1998-2019 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATtiny2313A
;Program type           : Application
;Clock frequency        : 8,000000 MHz
;Memory model           : Tiny
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 36 byte(s)
;Heap size              : 8 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_TINY_

	#pragma AVRPART ADMIN PART_NAME ATtiny2313A
	#pragma AVRPART MEMORY PROG_FLASH 2048
	#pragma AVRPART MEMORY EEPROM 128
	#pragma AVRPART MEMORY INT_SRAM SIZE 128
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU WDTCR=0x21
	.EQU WDTCSR=0x21
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SREG=0x3F
	.EQU GPIOR0=0x13
	.EQU GPIOR1=0x14
	.EQU GPIOR2=0x15

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x00DF
	.EQU __DSTACK_SIZE=0x0024
	.EQU __HEAP_SIZE=0x0008
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	RCALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOV  R26,R@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOV  R26,R@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	SUBI R26,-@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _CS_Port=R3
	.DEF _CS_Pin=R2

;GPIOR0-GPIOR2 INITIALIZATION VALUES
	.EQU __GPIOR0_INIT=0x00
	.EQU __GPIOR1_INIT=0x00
	.EQU __GPIOR2_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x6,0x32

;HEAP START MARKER INITIALIZATION
__HEAP_START_MARKER:
	.DW  0,0

_0x3:
	.DB  0x20,0x60,0x20,0x20,0x20,0x20,0x70
_0x4:
	.DB  0x70,0x88,0x10,0x20,0x40,0x80,0xF8
_0x5:
	.DB  0xF8,0x88,0x10,0x38,0x8,0x88,0x70
_0x6:
	.DB  0x30,0x50,0x90,0xF8,0x10,0x10,0x10
_0x7:
	.DB  0xF8,0x80,0xF0,0x8,0x8,0x88,0x70
_0x8:
	.DB  0xF0,0x88,0x88,0xF0,0xA0,0x90,0x88
_0x9:
	.DB  0x88,0x88,0xC8,0xA8,0x98,0x88,0x88
_0x40003:
	.DB  0x20,0x60,0x20,0x20,0x20,0x20,0x70
_0x40004:
	.DB  0x70,0x88,0x10,0x20,0x40,0x80,0xF8
_0x40005:
	.DB  0xF8,0x88,0x10,0x38,0x8,0x88,0x70
_0x40006:
	.DB  0x30,0x50,0x90,0xF8,0x10,0x10,0x10
_0x40007:
	.DB  0xF8,0x80,0xF0,0x8,0x8,0x88,0x70
_0x40008:
	.DB  0xF0,0x88,0x88,0xF0,0xA0,0x90,0x88
_0x40009:
	.DB  0x88,0x88,0xC8,0xA8,0x98,0x88,0x88
_0x80003:
	.DB  0x20,0x60,0x20,0x20,0x20,0x20,0x70
_0x80004:
	.DB  0x70,0x88,0x10,0x20,0x40,0x80,0xF8
_0x80005:
	.DB  0xF8,0x88,0x10,0x38,0x8,0x88,0x70
_0x80006:
	.DB  0x30,0x50,0x90,0xF8,0x10,0x10,0x10
_0x80007:
	.DB  0xF8,0x80,0xF0,0x8,0x8,0x88,0x70
_0x80008:
	.DB  0xF0,0x88,0x88,0xF0,0xA0,0x90,0x88
_0x80009:
	.DB  0x88,0x88,0xC8,0xA8,0x98,0x88,0x88
_0x8001F:
	.DB  0xFE
_0x80020:
	.DB  0xFE

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x02
	.DW  __REG_VARS*2

	.DW  0x04
	.DW  0xD8
	.DW  __HEAP_START_MARKER*2

	.DW  0x07
	.DW  _Symbol_ONE_G002
	.DW  _0x40003*2

	.DW  0x07
	.DW  _Symbol_TWO_G002
	.DW  _0x40004*2

	.DW  0x07
	.DW  _Symbol_THREE_G002
	.DW  _0x40005*2

	.DW  0x07
	.DW  _Symbol_FOUR_G002
	.DW  _0x40006*2

	.DW  0x07
	.DW  _Symbol_FIVE_G002
	.DW  _0x40007*2

	.DW  0x07
	.DW  _Symbol_R_G002
	.DW  _0x40008*2

	.DW  0x07
	.DW  _Symbol_N_G002
	.DW  _0x40009*2

	.DW  0x01
	.DW  _matrix_status_new_S0040005000
	.DW  _0x8001F*2

	.DW  0x01
	.DW  _matrix_status_S0040005000
	.DW  _0x80020*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,__CLEAR_SRAM_SIZE
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	;__GPIOR1_INIT = __GPIOR0_INIT
	OUT  GPIOR1,R30
	;__GPIOR2_INIT = __GPIOR0_INIT
	OUT  GPIOR2,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x84

	.CSEG
;#define F_CPU 8000000UL
;#include <tiny2313a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40
	.SET power_ctrl_reg=mcucr
	#endif
;#include <io.h>
;#include <delay.h>
;#include <stdbool.h>
;#include <stdint.h>
;#include <AVR_gpio.h>
;//#include <stdlib.h>
;#include <MAX7219.h>

	.DSEG
;#include <USI_SPI.h>
;#include <transmisions.h>
;
;
;void initialize_defolt(void);
;
;
;void initialize_defolt(void)
; 0000 0012 {

	.CSEG
_initialize_defolt:
; .FSTART _initialize_defolt
; 0000 0013 	// Declare your local variables here
; 0000 0014 
; 0000 0015 	// Crystal Oscillator division factor: 1
; 0000 0016 	#pragma optsize-
; 0000 0017 	CLKPR=(1<<CLKPCE);
	LDI  R30,LOW(128)
	OUT  0x26,R30
; 0000 0018 	CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 0019 	#ifdef _OPTIMIZE_SIZE_
; 0000 001A 	#pragma optsize+
; 0000 001B 	#endif
; 0000 001C 
; 0000 001D 	// Input/Output Ports initialization
; 0000 001E 	// Port A initialization
; 0000 001F 	// Function: Bit2=In Bit1=In Bit0=In
; 0000 0020 	DDRA=(0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	OUT  0x1A,R30
; 0000 0021 	// State: Bit2=T Bit1=T Bit0=T
; 0000 0022 	PORTA=(0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 0023 
; 0000 0024 	// Port B initialization
; 0000 0025 	// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0026 	DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0027 	// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0028 	PORTB=(0<<PORTB7) | (0<<PORTB6) | (1<<PORTB5) | (0<<PORTB4) | (1<<PORTB3) | (1<<PORTB2) | (1<<PORTB1) | (1<<PORTB0);
	LDI  R30,LOW(47)
	OUT  0x18,R30
; 0000 0029 
; 0000 002A 	// Port D initialization
; 0000 002B 	// Function: Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 002C 	DDRD=(1<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(64)
	OUT  0x11,R30
; 0000 002D 	// State: Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 002E 	PORTD=(0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 002F 
; 0000 0030 	// Timer/Counter 0 initialization
; 0000 0031 	// Clock source: System Clock
; 0000 0032 	// Clock value: Timer 0 Stopped
; 0000 0033 	// Mode: Normal top=0xFF
; 0000 0034 	// OC0A output: Disconnected
; 0000 0035 	// OC0B output: Disconnected
; 0000 0036 	TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	OUT  0x30,R30
; 0000 0037 	TCCR0B=(0<<WGM02) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0038 	TCNT0=0x00;
	OUT  0x32,R30
; 0000 0039 	OCR0A=0x00;
	OUT  0x36,R30
; 0000 003A 	OCR0B=0x00;
	OUT  0x3C,R30
; 0000 003B 
; 0000 003C 	// Timer/Counter 1 initialization
; 0000 003D 	// Clock source: System Clock
; 0000 003E 	// Clock value: Timer1 Stopped
; 0000 003F 	// Mode: Normal top=0xFFFF
; 0000 0040 	// OC1A output: Disconnected
; 0000 0041 	// OC1B output: Disconnected
; 0000 0042 	// Noise Canceler: Off
; 0000 0043 	// Input Capture on Falling Edge
; 0000 0044 	// Timer1 Overflow Interrupt: Off
; 0000 0045 	// Input Capture Interrupt: Off
; 0000 0046 	// Compare A Match Interrupt: Off
; 0000 0047 	// Compare B Match Interrupt: Off
; 0000 0048 	TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0049 	TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 004A 	TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 004B 	TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 004C 	ICR1H=0x00;
	OUT  0x25,R30
; 0000 004D 	ICR1L=0x00;
	OUT  0x24,R30
; 0000 004E 	OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 004F 	OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0050 	OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0051 	OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0052 
; 0000 0053 	// Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0054 	TIMSK=(0<<TOIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<ICIE1) | (0<<OCIE0B) | (0<<TOIE0) | (0<<OCIE0A);
	OUT  0x39,R30
; 0000 0055 
; 0000 0056 	// External Interrupt(s) initialization
; 0000 0057 	// INT0: Off
; 0000 0058 	// INT1: Off
; 0000 0059 	// Interrupt on any change on pins PCINT0-7: Off
; 0000 005A 	// Interrupt on any change on pins PCINT8-10: Off
; 0000 005B 	// Interrupt on any change on pins PCINT11-17: Off
; 0000 005C 	MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 005D 	GIMSK=(0<<INT1) | (0<<INT0) | (0<<PCIE0) | (0<<PCIE2) | (0<<PCIE1);
	OUT  0x3B,R30
; 0000 005E 
; 0000 005F 	// USI initialization
; 0000 0060 	// Mode: Disabled
; 0000 0061 	// Clock source: Register & Counter=no clk.
; 0000 0062 	// USI Counter Overflow Interrupt: Off
; 0000 0063 	USICR=(0<<USISIE) | (0<<USIOIE) | (0<<USIWM1) | (0<<USIWM0) | (0<<USICS1) | (0<<USICS0) | (0<<USICLK) | (0<<USITC);
	OUT  0xD,R30
; 0000 0064 
; 0000 0065 	// USART initialization
; 0000 0066 	// USART disabled
; 0000 0067 	UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 0068 
; 0000 0069 	// Analog Comparator initialization
; 0000 006A 	// Analog Comparator: Off
; 0000 006B 	// The Analog Comparator's positive input is
; 0000 006C 	// connected to the AIN0 pin
; 0000 006D 	// The Analog Comparator's negative input is
; 0000 006E 	// connected to the AIN1 pin
; 0000 006F 	ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0070 	// Digital input buffer on AIN0: On
; 0000 0071 	// Digital input buffer on AIN1: On
; 0000 0072 	DIDR=(0<<AIN0D) | (0<<AIN1D);
	LDI  R30,LOW(0)
	OUT  0x1,R30
; 0000 0073 }
	RET
; .FEND
;
;
;void main(void)
; 0000 0077 {
_main:
; .FSTART _main
; 0000 0078 
; 0000 0079 	initialize_defolt();
	RCALL _initialize_defolt
; 0000 007A 	SPI_Init();
	RCALL _SPI_Init
; 0000 007B 	//GPIO_Set_Bits(GPIO_Pin_4);
; 0000 007C 
; 0000 007D 	InitLed();
	RCALL _InitLed
; 0000 007E 
; 0000 007F 	while (1)
_0xA:
; 0000 0080 	{
; 0000 0081 		Trans_Poll();
	RCALL _Trans_Poll
; 0000 0082 		delay_ms(10);
	LDI  R26,LOW(10)
	RCALL SUBOPT_0x0
; 0000 0083 	}
	RJMP _0xA
; 0000 0084 }
_0xD:
	RJMP _0xD
; .FEND
;#include <stdint.h>
;#include <AVR_gpio.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40
	.SET power_ctrl_reg=mcucr
	#endif
;#include <common.h>
;
;
;void GPIO_Set_Bits(uint8_t* port, uint8_t pins)
; 0001 0007 {

	.CSEG
; 0001 0008 	*port |= pins;
;	*port -> R16
;	pins -> R17
; 0001 0009 }
;
;void GPIO_Reset_Bits(uint8_t* port, uint8_t pins)
; 0001 000C {
; 0001 000D 	*port &= ~pins;
;	*port -> R16
;	pins -> R17
; 0001 000E }
;
;bool GPIO_Read_Bits(uint8_t* port, uint8_t pins)
; 0001 0011 {
; 0001 0012 	if(port == PA)
;	*port -> R16
;	pins -> R17
; 0001 0013 	{
; 0001 0014 		return (bool)(PINA & pins);
; 0001 0015 	}
; 0001 0016 	else if(port == PB)
; 0001 0017 	{
; 0001 0018 		return (bool)(PINB & pins);
; 0001 0019 	}
; 0001 001A 	else if(port == PD)
; 0001 001B 	{
; 0001 001C 		return (bool)(PIND & pins);
; 0001 001D 	}
; 0001 001E 	else
; 0001 001F 	{
; 0001 0020 		return false;
; 0001 0021 	}
; 0001 0022 }
;
;#include <MAX7219.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG
;#include <delay.h>
;//#include <symbols.h>
;#include <mem.h>
;
;
;#if defined __ATTINY2313A__ || defined __ATTINY2313__
;#include <USI_SPI.h>
;#else
;#include <SPI.h>
;#endif
;
;void SendLed(uint8_t adr, uint8_t data);
;void SetIntensity(uint8_t a);
;
;
;
;#define NO_OP				0x0000
;#define NO_DECODE_MODE		0x0900
;#define INTENSITY			0x0A00  // (ot 0 do F)
;#define SCAN_LIMIT			0x0B00	// (ot 0 do 7)
;#define SHUTDOWN			0x0C00	// (0 - shotdown, 1 - no shotdown)
;#define DISPLAY_TEST		0x0F00	// (1 - test)
;
;#define CS					PortB4
;#define MOSI				PortB5
;#define SCK					PortB7
;
;
;void InitLed(void)
; 0002 001F {

	.CSEG
_InitLed:
; .FSTART _InitLed
; 0002 0020 	SendLed((DISPLAY_TEST >> 8), (DISPLAY_TEST | 0x00));
	LDI  R30,LOW(15)
	RCALL SUBOPT_0x1
; 0002 0021 	SendLed((INTENSITY >> 8), (INTENSITY | 0x0f));
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R26,LOW(15)
	RCALL _SendLed
; 0002 0022 	SendLed((SCAN_LIMIT >> 8), (SCAN_LIMIT | 0x07));
	LDI  R30,LOW(11)
	ST   -Y,R30
	LDI  R26,LOW(7)
	RCALL _SendLed
; 0002 0023 	SendLed((NO_DECODE_MODE >> 8), (NO_DECODE_MODE | 0x00));
	LDI  R30,LOW(9)
	RCALL SUBOPT_0x1
; 0002 0024 	SendLed((SHUTDOWN >> 8), (SHUTDOWN | 0x01));
	LDI  R30,LOW(12)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _SendLed
; 0002 0025 	SetIntensity(0x0F);
	LDI  R26,LOW(15)
	RCALL _SetIntensity
; 0002 0026 	WriteNum(SYMBOL_EMTY);
	RCALL SUBOPT_0x2
; 0002 0027 }
	RET
; .FEND
;
;void SendLed(uint8_t adr, uint8_t data)
; 0002 002A {
_SendLed:
; .FSTART _SendLed
; 0002 002B 	SPI_CS_Down();
	RCALL __SAVELOCR2
	MOV  R17,R26
	LDD  R16,Y+2
;	adr -> R16
;	data -> R17
	RCALL _SPI_CS_Down
; 0002 002C 
; 0002 002D 	SPI_SendByte(adr);
	MOV  R26,R16
	RCALL _SPI_SendByte
; 0002 002E 	SPI_SendByte(data);
	MOV  R26,R17
	RCALL _SPI_SendByte
; 0002 002F 
; 0002 0030 	SPI_CS_Up();
	RCALL _SPI_CS_Up
; 0002 0031 }
	RCALL __LOADLOCR2
	RJMP _0x2060002
; .FEND
;
;void SetIntensity(uint8_t a)  // 0 down to 15
; 0002 0034 {
_SetIntensity:
; .FSTART _SetIntensity
; 0002 0035 	SendLed((INTENSITY >> 8), (SHUTDOWN | a));
	ST   -Y,R17
	MOV  R17,R26
;	a -> R17
	LDI  R30,LOW(10)
	ST   -Y,R30
	MOV  R30,R17
	MOV  R26,R30
	RCALL _SendLed
; 0002 0036 }
	RJMP _0x2060004
; .FEND
;
;void WriteNum(Matrix_Symbols num)
; 0002 0039 {
_WriteNum:
; .FSTART _WriteNum
; 0002 003A 	uint8_t* s_ptr = NULL;
; 0002 003B 	int i;
; 0002 003C 
; 0002 003D 	s_ptr = GetSymbols(num);
	RCALL __SAVELOCR4
	MOV  R16,R26
;	num -> R16
;	*s_ptr -> R17
;	i -> R18,R19
	LDI  R17,0
	RCALL _GetSymbols
	MOV  R17,R30
; 0002 003E 
; 0002 003F 	for(i = 0; i < 8; i++)
	__GETWRN 18,19,0
_0x4000B:
	__CPWRN 18,19,8
	BRGE _0x4000C
; 0002 0040 	{
; 0002 0041 		SendLed((i + 1), s_ptr[i]);
	MOV  R30,R18
	SUBI R30,-LOW(1)
	ST   -Y,R30
	MOV  R30,R18
	ADD  R30,R17
	LD   R26,Z
	RCALL _SendLed
; 0002 0042 	}
	__ADDWRN 18,19,1
	RJMP _0x4000B
_0x4000C:
; 0002 0043 }
	RJMP _0x2060006
; .FEND
;
;void WriteSymbol(uint8_t* num)
; 0002 0046 {
_WriteSymbol:
; .FSTART _WriteSymbol
; 0002 0047 	int i;
; 0002 0048 
; 0002 0049 	for(i = 0; i < 8; i++)
	RCALL __SAVELOCR4
	MOV  R19,R26
;	*num -> R19
;	i -> R16,R17
	__GETWRN 16,17,0
_0x4000E:
	__CPWRN 16,17,8
	BRGE _0x4000F
; 0002 004A 	{
; 0002 004B 		SendLed((i + 1), num[i]);
	MOV  R30,R16
	SUBI R30,-LOW(1)
	ST   -Y,R30
	MOV  R30,R16
	ADD  R30,R19
	LD   R26,Z
	RCALL _SendLed
; 0002 004C 	}
	__ADDWRN 16,17,1
	RJMP _0x4000E
_0x4000F:
; 0002 004D }
_0x2060006:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
;
;
;uint8_t *GetSymbols(Matrix_Symbols i)
; 0002 0051 {
_GetSymbols:
; .FSTART _GetSymbols
; 0002 0052 	//return symbols_ptr[i];
; 0002 0053 	switch (i)
	ST   -Y,R17
	MOV  R17,R26
;	i -> R17
	MOV  R30,R17
	LDI  R31,0
; 0002 0054 	{
; 0002 0055 		case SYMBOL_R:
	SBIW R30,0
	BRNE _0x40013
; 0002 0056 		{
; 0002 0057 			return Symbol_R;
	LDI  R30,LOW(_Symbol_R_G002)
	RJMP _0x2060004
; 0002 0058 		}
; 0002 0059 		case SYMBOL_ONE:
_0x40013:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x40014
; 0002 005A 		{
; 0002 005B 			return Symbol_ONE;
	LDI  R30,LOW(_Symbol_ONE_G002)
	RJMP _0x2060004
; 0002 005C 		}
; 0002 005D 		case SYMBOL_TWO:
_0x40014:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x40015
; 0002 005E 		{
; 0002 005F 			return Symbol_TWO;
	LDI  R30,LOW(_Symbol_TWO_G002)
	RJMP _0x2060004
; 0002 0060 		}
; 0002 0061 		case SYMBOL_THREE:
_0x40015:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x40016
; 0002 0062 		{
; 0002 0063 			return Symbol_THREE;
	LDI  R30,LOW(_Symbol_THREE_G002)
	RJMP _0x2060004
; 0002 0064 		}
; 0002 0065 		case SYMBOL_FOUR:
_0x40016:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x40017
; 0002 0066 		{
; 0002 0067 			return Symbol_FOUR;
	LDI  R30,LOW(_Symbol_FOUR_G002)
	RJMP _0x2060004
; 0002 0068 		}
; 0002 0069 		case SYMBOL_FIVE:
_0x40017:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x40018
; 0002 006A 		{
; 0002 006B 			return Symbol_FIVE;
	LDI  R30,LOW(_Symbol_FIVE_G002)
	RJMP _0x2060004
; 0002 006C 		}
; 0002 006D 		case SYMBOL_N:
_0x40018:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x4001A
; 0002 006E 		{
; 0002 006F 			return Symbol_N;
	LDI  R30,LOW(_Symbol_N_G002)
	RJMP _0x2060004
; 0002 0070 		}
; 0002 0071 		default: return Symbol_EMPTY;
_0x4001A:
	LDI  R30,LOW(_Symbol_EMPTY_G002)
	RJMP _0x2060004
; 0002 0072 	}
; 0002 0073 
; 0002 0074 	return 0;
; 0002 0075 }
; .FEND
;
;
;
;/*
; * USI_SPI.c
; *
; * Created: 11.10.2022 14:54:42
; *  Author: Evgeni
; */
;#include <USI_SPI.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40
	.SET power_ctrl_reg=mcucr
	#endif
;#include <common.h>
;
;typedef enum
;{
;	LSB,
;	MSB,
;	CPOL_0,
;	CPOL_1,
;
;}SPI_USI_Typedef;
;
;uint8_t *CS_Port = &PORTD;
;uint8_t CS_Pin = PORTD6;
;
;void SPI_CS_Up(void)
; 0003 0017 {

	.CSEG
_SPI_CS_Up:
; .FSTART _SPI_CS_Up
; 0003 0018 	*CS_Port |= (1<<CS_Pin);
	RCALL SUBOPT_0x3
	OR   R30,R1
	RJMP _0x2060005
; 0003 0019 }
; .FEND
;
;void SPI_CS_Down(void)
; 0003 001C {
_SPI_CS_Down:
; .FSTART _SPI_CS_Down
; 0003 001D 	*CS_Port &= ~(1<<CS_Pin);
	RCALL SUBOPT_0x3
	COM  R30
	AND  R30,R1
_0x2060005:
	MOV  R26,R22
	ST   X,R30
; 0003 001E }
	RET
; .FEND
;
;void SPI_Init(void)
; 0003 0021 {
_SPI_Init:
; .FSTART _SPI_Init
; 0003 0022 	DDRB|=((1<<PORTB6)|(1<<PORTB7));//Ножки USI на выход
	IN   R30,0x17
	ORI  R30,LOW(0xC0)
	OUT  0x17,R30
; 0003 0023 
; 0003 0024 	PORTB&=~((1<<PORTB6)|(1<<PORTB7));//Ножки USI в низкий уровень
	IN   R30,0x18
	ANDI R30,LOW(0x3F)
	OUT  0x18,R30
; 0003 0025 	DDRD |= (1<<PORTD6);
	SBI  0x11,6
; 0003 0026 	PORTD |= GPIO_Pin_6;
	SBI  0x12,6
; 0003 0027 	USICR |= (1<<USIWM0);
	SBI  0xD,4
; 0003 0028 }
	RET
; .FEND
;
;void SPI_SendByte(uint8_t byte)
; 0003 002B 
; 0003 002C {
_SPI_SendByte:
; .FSTART _SPI_SendByte
; 0003 002D 	USIDR = byte; //данные в регистр
	ST   -Y,R17
	MOV  R17,R26
;	byte -> R17
	OUT  0xF,R17
; 0003 002E 	USISR |= (1<<USIOIF);//установим флаг начала передачи
	SBI  0xE,6
; 0003 002F 	//SPI_CS_Down();
; 0003 0030 	while(!(USISR & (1<<USIOIF)))
_0x60003:
	SBIC 0xE,6
	RJMP _0x60005
; 0003 0031 
; 0003 0032 	{
; 0003 0033 		USICR |= ((1<<USIWM0)|(1<<USICS1)|(1<<USICLK)|(1<<USITC));//постепенно передаем байт
	IN   R30,0xD
	ORI  R30,LOW(0x1B)
	OUT  0xD,R30
; 0003 0034 		//delay_us(10);
; 0003 0035 	}
	RJMP _0x60003
_0x60005:
; 0003 0036 	//SPI_CS_Up();
; 0003 0037 }
_0x2060004:
	LD   R17,Y+
	RET
; .FEND
;/*
; * transmission.c
; *
; * Created: 20.10.2022 22:41:13
; *  Author: Evgeni
; */
;
;#include <transmisions.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x50
	.EQU __sm_powerdown=0x10
	.EQU __sm_standby=0x40
	.SET power_ctrl_reg=mcucr
	#endif
;#include <MAX7219.h>

	.DSEG
;//#include <symbols.h>
;#include <setjmp.h>
;
;typedef enum
;{
;	R = 0,
;	ONE = 1,
;	TWO = 2,
;	THREE = 3,
;	FOUR = 4,
;	FIVE = 5,
;	N = -1,
;	none = -2
;
;}Transmission_State;
;
;//bool Get_State_Transmision(uint8_t num_trans)
;//{
;	//return GPIO_Read_Bits(PD, num_trans);
;//}
;
;//uint8_t r[8] = {
;	//0xF0,
;	//0x88,
;	//0x88,
;	//0xF0,
;	//0xA0,
;	//0x90,
;	//0x88,
;	//0x00
;//};
;
;Transmission_State Transmission_Get_EN(void)
; 0004 002B {

	.CSEG
_Transmission_Get_EN:
; .FSTART _Transmission_Get_EN
; 0004 002C 	int i = 0;
; 0004 002D 	for(i = 0; i <= 5; i++)
	RCALL __SAVELOCR2
;	i -> R16,R17
	__GETWRN 16,17,0
	__GETWRN 16,17,0
_0x8000B:
	__CPWRN 16,17,6
	BRGE _0x8000C
; 0004 002E 	{
; 0004 002F 		if((PINB & (1<<i)) == 0)
	IN   R22,22
	MOV  R30,R16
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	RCALL __LSLW12
	MOV  R26,R22
	LDI  R27,0
	AND  R30,R26
	AND  R31,R27
	SBIW R30,0
	BRNE _0x8000D
; 0004 0030 		{
; 0004 0031 			return i;
	MOV  R30,R16
	RJMP _0x2060003
; 0004 0032 		}
; 0004 0033 	}
_0x8000D:
	__ADDWRN 16,17,1
	RJMP _0x8000B
_0x8000C:
; 0004 0034 	return N;
	LDI  R30,LOW(255)
_0x2060003:
	LD   R16,Y+
	LD   R17,Y+
	RET
; 0004 0035 }
; .FEND
;
;void Animation_HorizRows(Matrix_Symbols symbol)
; 0004 0038 {
_Animation_HorizRows:
; .FSTART _Animation_HorizRows
; 0004 0039 	uint8_t new_frame[8];
; 0004 003A 	uint8_t symbol_source[8];
; 0004 003B 	uint8_t i;
; 0004 003C 
; 0004 003D 	memset(new_frame, 0, 8);
	SBIW R28,16
	RCALL __SAVELOCR2
	MOV  R16,R26
;	symbol -> R16
;	new_frame -> Y+10
;	symbol_source -> Y+2
;	i -> R17
	MOV  R30,R28
	SUBI R30,-(10)
	RCALL SUBOPT_0x4
; 0004 003E 	memcpy(symbol_source, GetSymbols(symbol), 8);
	RCALL SUBOPT_0x5
; 0004 003F 
; 0004 0040 	for(i = 0; i < 7; i++)
	LDI  R17,LOW(0)
_0x8000F:
	CPI  R17,7
	BRSH _0x80010
; 0004 0041 	{
; 0004 0042 		memcpy(new_frame, symbol_source, i + 1);
	MOV  R30,R28
	SUBI R30,-(10)
	ST   -Y,R30
	MOV  R30,R28
	SUBI R30,-(3)
	RCALL SUBOPT_0x6
; 0004 0043 		WriteSymbol(new_frame);
	MOV  R26,R28
	SUBI R26,-(10)
	RCALL _WriteSymbol
; 0004 0044 		delay_ms(50);
	LDI  R26,LOW(50)
	RCALL SUBOPT_0x0
; 0004 0045 	}
	SUBI R17,-1
	RJMP _0x8000F
_0x80010:
; 0004 0046 }
	RCALL __LOADLOCR2
	ADIW R28,18
	RET
; .FEND
;
;void Animation_ProgressBar(Matrix_Symbols symbol)
; 0004 0049 {
; 0004 004A 	uint8_t new_frame[8];
; 0004 004B 	uint8_t symbol_source[8];
; 0004 004C 
; 0004 004D 
; 0004 004E 	memcpy(symbol_source, GetSymbols(symbol), 8);
;	symbol -> R17
;	new_frame -> Y+9
;	symbol_source -> Y+1
; 0004 004F 
; 0004 0050 
; 0004 0051 
; 0004 0052 	WriteSymbol(new_frame);
; 0004 0053 }
;
;void Animation_Cursor(Matrix_Symbols symbol)
; 0004 0056 {
_Animation_Cursor:
; .FSTART _Animation_Cursor
; 0004 0057 	uint8_t new_frame[8];
; 0004 0058 	uint8_t symbol_source[8];
; 0004 0059 	uint8_t row, column, mask = 0x80;
; 0004 005A 	uint8_t used_mask = 0UL;
; 0004 005B 
; 0004 005C 
; 0004 005D 	memset(new_frame, 0, 8);
	SBIW R28,16
	RCALL __SAVELOCR6
	MOV  R21,R26
;	symbol -> R21
;	new_frame -> Y+14
;	symbol_source -> Y+6
;	row -> R17
;	column -> R16
;	mask -> R19
;	used_mask -> R18
	LDI  R19,128
	LDI  R18,0
	MOV  R30,R28
	SUBI R30,-(14)
	RCALL SUBOPT_0x4
; 0004 005E 	memcpy(symbol_source, GetSymbols(symbol), 8);
	MOV  R30,R28
	SUBI R30,-(6)
	ST   -Y,R30
	MOV  R26,R21
	RCALL _GetSymbols
	ST   -Y,R30
	LDI  R26,LOW(8)
	RCALL _memcpy
; 0004 005F 
; 0004 0060 	for(row = 0; row < 7; row++)
	LDI  R17,LOW(0)
_0x80012:
	CPI  R17,7
	BRSH _0x80013
; 0004 0061 	{
; 0004 0062 		for(column = 0; column < 5; column++)
	LDI  R16,LOW(0)
_0x80015:
	CPI  R16,5
	BRSH _0x80016
; 0004 0063 		{
; 0004 0064 			memcpy(new_frame, symbol_source, row + 1);
	MOV  R30,R28
	SUBI R30,-(14)
	ST   -Y,R30
	MOV  R30,R28
	SUBI R30,-(7)
	RCALL SUBOPT_0x6
; 0004 0065 
; 0004 0066 			if(column == 0)
	CPI  R16,0
	BRNE _0x80017
; 0004 0067 			{
; 0004 0068 				used_mask = mask;
	MOV  R18,R19
; 0004 0069 			}
; 0004 006A 			else
	RJMP _0x80018
_0x80017:
; 0004 006B 			{
; 0004 006C 				used_mask += (64 / (1 << column-1));
	MOV  R30,R16
	LDI  R31,0
	SBIW R30,1
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	RCALL __LSLW12
	LDI  R26,LOW(64)
	LDI  R27,HIGH(64)
	RCALL __DIVW21U
	ADD  R18,R30
; 0004 006D 			}
_0x80018:
; 0004 006E 
; 0004 006F 			new_frame[row] &= used_mask;
	MOV  R26,R28
	SUBI R26,-(14)
	ADD  R26,R17
	LD   R30,X
	AND  R30,R18
	ST   X,R30
; 0004 0070 			new_frame[row] |= (0x80 >> column);
	MOV  R30,R17
	MOV  R26,R28
	SUBI R26,-(14)
	ADD  R30,R26
	MOV  R20,R30
	LD   R1,Z
	MOV  R30,R16
	LDI  R26,LOW(128)
	RCALL __LSRB12
	OR   R30,R1
	MOV  R26,R20
	ST   X,R30
; 0004 0071 			WriteSymbol(new_frame);
	MOV  R26,R28
	SUBI R26,-(14)
	RCALL _WriteSymbol
; 0004 0072 			delay_ms(30);
	LDI  R26,LOW(30)
	RCALL SUBOPT_0x0
; 0004 0073 		}
	SUBI R16,-1
	RJMP _0x80015
_0x80016:
; 0004 0074 	}
	SUBI R17,-1
	RJMP _0x80012
_0x80013:
; 0004 0075 	WriteSymbol(symbol_source);
	MOV  R26,R28
	SUBI R26,-(6)
	RCALL _WriteSymbol
; 0004 0076 }
	RCALL __LOADLOCR6
	ADIW R28,22
	RET
; .FEND
;
;void Animation_SlideShow(Matrix_Symbols symbol)
; 0004 0079 {
_Animation_SlideShow:
; .FSTART _Animation_SlideShow
; 0004 007A 	uint8_t symbol_source[8];
; 0004 007B 	int8_t row;
; 0004 007C 
; 0004 007D 	memcpy(symbol_source, GetSymbols(symbol), 8);
	SBIW R28,8
	RCALL __SAVELOCR2
	MOV  R16,R26
;	symbol -> R16
;	symbol_source -> Y+2
;	row -> R17
	RCALL SUBOPT_0x5
; 0004 007E 
; 0004 007F 	for(row = 7; row >= 0; row--)
	LDI  R17,LOW(7)
_0x8001A:
	CPI  R17,0
	BRLT _0x8001B
; 0004 0080 	{
; 0004 0081 		SendLed((row + 1), 0x00);
	MOV  R30,R17
	SUBI R30,-LOW(1)
	RCALL SUBOPT_0x1
; 0004 0082 		delay_ms(50);
	LDI  R26,LOW(50)
	RCALL SUBOPT_0x0
; 0004 0083 	}
	SUBI R17,1
	RJMP _0x8001A
_0x8001B:
; 0004 0084 
; 0004 0085 	for(row = 0; row <= 7; row++)
	LDI  R17,LOW(0)
_0x8001D:
	CPI  R17,8
	BRGE _0x8001E
; 0004 0086 	{
; 0004 0087 		SendLed(row + 1, symbol_source[row]);
	MOV  R30,R17
	SUBI R30,-LOW(1)
	ST   -Y,R30
	MOV  R26,R28
	SUBI R26,-(3)
	ADD  R26,R17
	LD   R26,X
	RCALL _SendLed
; 0004 0088 		delay_ms(50);
	LDI  R26,LOW(50)
	RCALL SUBOPT_0x0
; 0004 0089 	}
	SUBI R17,-1
	RJMP _0x8001D
_0x8001E:
; 0004 008A }
	RCALL __LOADLOCR2
	ADIW R28,10
	RET
; .FEND
;
;void Trans_Poll(void)
; 0004 008D {
_Trans_Poll:
; .FSTART _Trans_Poll
; 0004 008E 	static Transmission_State matrix_status_new = none;

	.DSEG

	.CSEG
; 0004 008F 	static Transmission_State matrix_status = none;

	.DSEG

	.CSEG
; 0004 0090 	static uint8_t count_delay = 0;
; 0004 0091 
; 0004 0092 	matrix_status_new = Transmission_Get_EN();
	RCALL _Transmission_Get_EN
	STS  _matrix_status_new_S0040005000,R30
; 0004 0093 
; 0004 0094 	if(matrix_status != matrix_status_new)
	LDS  R26,_matrix_status_S0040005000
	CP   R30,R26
	BREQ _0x80021
; 0004 0095 	{
; 0004 0096 		count_delay++;
	LDS  R30,_count_delay_S0040005000
	SUBI R30,-LOW(1)
	STS  _count_delay_S0040005000,R30
; 0004 0097 	}
; 0004 0098 
; 0004 0099 	if(count_delay == 6)
_0x80021:
	LDS  R26,_count_delay_S0040005000
	CPI  R26,LOW(0x6)
	BRNE _0x80022
; 0004 009A 	{
; 0004 009B 		switch(matrix_status_new)
	LDS  R30,_matrix_status_new_S0040005000
	LDI  R31,0
; 0004 009C 		{
; 0004 009D 			case R:
	SBIW R30,0
	BRNE _0x80026
; 0004 009E 			{
; 0004 009F 				WriteNum(SYMBOL_EMTY);
	RCALL SUBOPT_0x2
; 0004 00A0 				delay_ms(5);
	RCALL SUBOPT_0x7
; 0004 00A1 				Animation_HorizRows(SYMBOL_R);
	LDI  R26,LOW(0)
	RCALL _Animation_HorizRows
; 0004 00A2 				//WriteNum(SYMBOL_R);
; 0004 00A3 				break;
	RJMP _0x80025
; 0004 00A4 			}
; 0004 00A5 			case ONE:
_0x80026:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x80027
; 0004 00A6 			{
; 0004 00A7 				WriteNum(SYMBOL_EMTY);
	RCALL SUBOPT_0x2
; 0004 00A8 				delay_ms(5);
	RCALL SUBOPT_0x7
; 0004 00A9 				WriteNum(SYMBOL_ONE);
	LDI  R26,LOW(1)
	RJMP _0x8002D
; 0004 00AA 				break;
; 0004 00AB 			}
; 0004 00AC 			case TWO:
_0x80027:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x80028
; 0004 00AD 			{
; 0004 00AE 				WriteNum(SYMBOL_EMTY);
	RCALL SUBOPT_0x2
; 0004 00AF 				delay_ms(5);
	RCALL SUBOPT_0x7
; 0004 00B0 				WriteNum(SYMBOL_TWO);
	LDI  R26,LOW(2)
	RJMP _0x8002D
; 0004 00B1 				break;
; 0004 00B2 			}
; 0004 00B3 			case THREE:
_0x80028:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x80029
; 0004 00B4 			{
; 0004 00B5 				//WriteNum(SYMBOL_EMTY);
; 0004 00B6 				delay_ms(5);
	RCALL SUBOPT_0x7
; 0004 00B7 				Animation_SlideShow(SYMBOL_THREE);
	LDI  R26,LOW(3)
	RCALL _Animation_SlideShow
; 0004 00B8 				//WriteNum(SYMBOL_THREE);
; 0004 00B9 				break;
	RJMP _0x80025
; 0004 00BA 			}
; 0004 00BB 			case FOUR:
_0x80029:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x8002A
; 0004 00BC 			{
; 0004 00BD 				WriteNum(SYMBOL_EMTY);
	RCALL SUBOPT_0x2
; 0004 00BE 				delay_ms(5);
	RCALL SUBOPT_0x7
; 0004 00BF 				WriteNum(SYMBOL_FOUR);
	LDI  R26,LOW(4)
	RJMP _0x8002D
; 0004 00C0 				break;
; 0004 00C1 			}
; 0004 00C2 			case FIVE:
_0x8002A:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x8002C
; 0004 00C3 			{
; 0004 00C4 				WriteNum(SYMBOL_EMTY);
	RCALL SUBOPT_0x2
; 0004 00C5 				delay_ms(5);
	RCALL SUBOPT_0x7
; 0004 00C6 				Animation_Cursor(SYMBOL_FIVE);
	LDI  R26,LOW(5)
	RCALL _Animation_Cursor
; 0004 00C7 				//WriteNum(SYMBOL_FIVE);
; 0004 00C8 				break;
	RJMP _0x80025
; 0004 00C9 			}
; 0004 00CA 			default:
_0x8002C:
; 0004 00CB 			{
; 0004 00CC 				WriteNum(SYMBOL_EMTY);
	RCALL SUBOPT_0x2
; 0004 00CD 				delay_ms(5);
	RCALL SUBOPT_0x7
; 0004 00CE 				WriteNum(SYMBOL_N);
	LDI  R26,LOW(6)
_0x8002D:
	RCALL _WriteNum
; 0004 00CF 				break;
; 0004 00D0 			}
; 0004 00D1 		}
_0x80025:
; 0004 00D2 		count_delay = 0;
	LDI  R30,LOW(0)
	STS  _count_delay_S0040005000,R30
; 0004 00D3 		matrix_status = matrix_status_new;
	LDS  R30,_matrix_status_new_S0040005000
	STS  _matrix_status_S0040005000,R30
; 0004 00D4 	}
; 0004 00D5 }
_0x80022:
	RET
; .FEND
;

	.CSEG
_memcpy:
; .FSTART _memcpy
	ST   -Y,R26
    ld   r24,y
    tst  r24
    breq memcpy1
    clr  r27
    ldd  r26,y+2
    clr  r31
    ldd  r30,y+1
memcpy0:
    ld   r22,z+
    st   x+,r22
    dec  r24
    brne memcpy0
memcpy1:
    ldd  r30,y+2
	RJMP _0x2060001
; .FEND
_memset:
; .FSTART _memset
	ST   -Y,R26
    ld   r26,y
    tst  r26
    breq memset1
    clr  r31
    ldd  r30,y+2
    ldd  r22,y+1
memset0:
    st   z+,r22
    dec  r26
    brne memset0
memset1:
    ldd  r30,y+2
_0x2060001:
_0x2060002:
	ADIW R28,3
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_Symbol_ONE_G002:
	.BYTE 0x8
_Symbol_TWO_G002:
	.BYTE 0x8
_Symbol_THREE_G002:
	.BYTE 0x8
_Symbol_FOUR_G002:
	.BYTE 0x8
_Symbol_FIVE_G002:
	.BYTE 0x8
_Symbol_R_G002:
	.BYTE 0x8
_Symbol_N_G002:
	.BYTE 0x8
_Symbol_EMPTY_G002:
	.BYTE 0x8
_matrix_status_new_S0040005000:
	.BYTE 0x1
_matrix_status_S0040005000:
	.BYTE 0x1
_count_delay_S0040005000:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x0:
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1:
	ST   -Y,R30
	LDI  R26,LOW(0)
	RJMP _SendLed

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2:
	LDI  R26,LOW(7)
	RJMP _WriteNum

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	MOV  R30,R3
	MOV  R22,R30
	LD   R1,Z
	MOV  R30,R2
	LDI  R26,LOW(1)
	RCALL __LSLB12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(8)
	RJMP _memset

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5:
	MOV  R30,R28
	SUBI R30,-(2)
	ST   -Y,R30
	MOV  R26,R16
	RCALL _GetSymbols
	ST   -Y,R30
	LDI  R26,LOW(8)
	RJMP _memcpy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	ST   -Y,R30
	MOV  R26,R17
	SUBI R26,-LOW(1)
	RJMP _memcpy

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x7:
	LDI  R26,LOW(5)
	RJMP SUBOPT_0x0

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSRB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSRB12R
__LSRB12L:
	LSR  R30
	DEC  R0
	BRNE __LSRB12L
__LSRB12R:
	RET

__LSLW12:
	TST  R30
	MOV  R0,R30
	LDI  R30,8
	MOV  R1,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12S8:
	CP   R0,R1
	BRLO __LSLW12L
	MOV  R31,R30
	LDI  R30,0
	SUB  R0,R1
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7D0
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
