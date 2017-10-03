
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega164A
;Program type             : Application
;Clock frequency          : 11.059200 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega164A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1279
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

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

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x04FF
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
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
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
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
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
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
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
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

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _countDataRFID=R3
	.DEF _counter=R5
	.DEF _i=R7
	.DEF _j=R9
	.DEF _k=R11
	.DEF _noUser=R13

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart1_rx_isr
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x59:
	.DB  LOW(_0x58),HIGH(_0x58),LOW(_0x58+17),HIGH(_0x58+17),LOW(_0x58+34),HIGH(_0x58+34),LOW(_0x58+51),HIGH(_0x58+51)
	.DB  LOW(_0x58+68),HIGH(_0x58+68)
_0x5B:
	.DB  LOW(_0x5A),HIGH(_0x5A),LOW(_0x5A+4),HIGH(_0x5A+4),LOW(_0x5A+8),HIGH(_0x5A+8),LOW(_0x5A+12),HIGH(_0x5A+12)
	.DB  LOW(_0x5A+16),HIGH(_0x5A+16)
_0x5C:
	.DB  0x0,0x6,0x0,0x0,0x7,0x5,0x6,0xF
	.DB  0x9,0x0,0x8,0xC
_0x5D:
	.DB  0x0,0x6,0x0,0x0,0x7,0x5,0x8,0xA
	.DB  0x9,0xB,0x6,0x2
_0x5E:
	.DB  0x0,0x6,0x0,0x0,0x7,0x5,0x4,0x8
	.DB  0x6,0x5,0x5,0xE
_0x5F:
	.DB  0x0,0x6,0x0,0x0,0x7,0x5,0x5,0x8
	.DB  0x0,0x2,0x2,0x9
_0x60:
	.DB  0x0,0x6,0x0,0x0,0x7,0x5,0xA,0xD
	.DB  0x3,0x5,0xE,0xB
_0xD0:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_0x0:
	.DB  0x50,0x49,0x4E,0x20,0x3A,0x20,0x0,0x4A
	.DB  0x6F,0x6B,0x6F,0x20,0x53,0x65,0x74,0x79
	.DB  0x61,0x77,0x61,0x6E,0x20,0x20,0x20,0x0
	.DB  0x52,0x69,0x7A,0x6B,0x79,0x20,0x47,0x75
	.DB  0x6D,0x69,0x6C,0x61,0x6E,0x67,0x20,0x20
	.DB  0x0,0x42,0x6F,0x6E,0x20,0x4A,0x6F,0x76
	.DB  0x69,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x0,0x54,0x6F,0x6D,0x20,0x43,0x72
	.DB  0x75,0x69,0x73,0x65,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x0,0x53,0x75,0x73,0x61,0x6E
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x0,0x30,0x32,0x34,0x0
	.DB  0x30,0x33,0x32,0x0,0x31,0x32,0x33,0x0
	.DB  0x32,0x33,0x34,0x0,0x35,0x34,0x31,0x0
	.DB  0x52,0x46,0x49,0x44,0x20,0x52,0x65,0x61
	.DB  0x64,0x65,0x72,0x20,0x20,0x20,0x20,0x20
	.DB  0x0,0x4D,0x61,0x73,0x75,0x6B,0x6B,0x61
	.DB  0x6E,0x20,0x50,0x49,0x4E,0x20,0x20,0x20
	.DB  0x20,0x0,0x4A,0x6F,0x6B,0x6F,0x20,0x53
	.DB  0x65,0x74,0x79,0x61,0x77,0x61,0x6E,0x7C
	.DB  0x7B,0x30,0x78,0x30,0x30,0x2C,0x20,0x30
	.DB  0x78,0x30,0x36,0x2C,0x20,0x30,0x78,0x30
	.DB  0x30,0x2C,0x20,0x30,0x78,0x30,0x30,0x2C
	.DB  0x20,0x30,0x78,0x30,0x37,0x2C,0x20,0x30
	.DB  0x78,0x30,0x35,0x2C,0x20,0x30,0x78,0x30
	.DB  0x36,0x2C,0x20,0x30,0x78,0x30,0x46,0x2C
	.DB  0x20,0x30,0x78,0x30,0x39,0x2C,0x20,0x30
	.DB  0x78,0x30,0x30,0x2C,0x20,0x30,0x78,0x30
	.DB  0x38,0x2C,0x20,0x30,0x78,0x30,0x43,0x7D
	.DB  0xD,0xA,0x0,0x53,0x69,0x6C,0x61,0x68
	.DB  0x6B,0x61,0x6E,0x20,0x4D,0x61,0x73,0x75
	.DB  0x6B,0x20,0x20,0x0,0x50,0x49,0x4E,0x20
	.DB  0x53,0x61,0x6C,0x61,0x68,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x0,0x52,0x69,0x7A
	.DB  0x6B,0x79,0x20,0x47,0x75,0x6D,0x69,0x6C
	.DB  0x61,0x6E,0x67,0x7C,0x7B,0x30,0x78,0x30
	.DB  0x30,0x2C,0x20,0x30,0x78,0x30,0x36,0x2C
	.DB  0x20,0x30,0x78,0x30,0x30,0x2C,0x20,0x30
	.DB  0x78,0x30,0x30,0x2C,0x20,0x30,0x78,0x30
	.DB  0x37,0x2C,0x20,0x30,0x78,0x30,0x35,0x2C
	.DB  0x20,0x30,0x78,0x30,0x38,0x2C,0x20,0x30
	.DB  0x78,0x30,0x41,0x2C,0x20,0x30,0x78,0x30
	.DB  0x39,0x2C,0x20,0x30,0x78,0x30,0x42,0x2C
	.DB  0x20,0x30,0x78,0x30,0x36,0x2C,0x20,0x30
	.DB  0x78,0x30,0x32,0x7D,0xD,0xA,0x0,0x42
	.DB  0x6F,0x6E,0x20,0x4A,0x6F,0x76,0x69,0x7C
	.DB  0x7B,0x30,0x78,0x30,0x30,0x2C,0x20,0x30
	.DB  0x78,0x30,0x36,0x2C,0x20,0x30,0x78,0x30
	.DB  0x30,0x2C,0x20,0x30,0x78,0x30,0x30,0x2C
	.DB  0x20,0x30,0x78,0x30,0x37,0x2C,0x20,0x30
	.DB  0x78,0x30,0x35,0x2C,0x20,0x30,0x78,0x30
	.DB  0x34,0x2C,0x20,0x30,0x78,0x30,0x38,0x2C
	.DB  0x20,0x30,0x78,0x30,0x36,0x2C,0x20,0x30
	.DB  0x78,0x30,0x35,0x2C,0x20,0x30,0x78,0x30
	.DB  0x35,0x2C,0x20,0x30,0x78,0x30,0x45,0x7D
	.DB  0xD,0xA,0x0,0x54,0x6F,0x6D,0x20,0x43
	.DB  0x72,0x75,0x69,0x73,0x65,0x7C,0x7B,0x30
	.DB  0x78,0x30,0x30,0x2C,0x20,0x30,0x78,0x30
	.DB  0x36,0x2C,0x20,0x30,0x78,0x30,0x30,0x2C
	.DB  0x20,0x30,0x78,0x30,0x30,0x2C,0x20,0x30
	.DB  0x78,0x30,0x37,0x2C,0x20,0x30,0x78,0x30
	.DB  0x35,0x2C,0x20,0x30,0x78,0x30,0x35,0x2C
	.DB  0x20,0x30,0x78,0x30,0x38,0x2C,0x20,0x30
	.DB  0x78,0x30,0x30,0x2C,0x20,0x30,0x78,0x30
	.DB  0x32,0x2C,0x20,0x30,0x78,0x30,0x32,0x2C
	.DB  0x20,0x30,0x78,0x30,0x39,0x7D,0xD,0xA
	.DB  0x0,0x53,0x75,0x73,0x61,0x6E,0x7C,0x7B
	.DB  0x30,0x78,0x30,0x30,0x2C,0x20,0x30,0x78
	.DB  0x30,0x36,0x2C,0x20,0x30,0x78,0x30,0x30
	.DB  0x2C,0x20,0x30,0x78,0x30,0x30,0x2C,0x20
	.DB  0x30,0x78,0x30,0x37,0x2C,0x20,0x30,0x78
	.DB  0x30,0x35,0x2C,0x20,0x30,0x78,0x30,0x41
	.DB  0x2C,0x20,0x30,0x78,0x30,0x44,0x2C,0x20
	.DB  0x30,0x78,0x30,0x33,0x2C,0x20,0x30,0x78
	.DB  0x30,0x35,0x2C,0x20,0x30,0x78,0x30,0x45
	.DB  0x2C,0x20,0x30,0x78,0x30,0x42,0x7D,0xD
	.DB  0xA,0x0,0x54,0x69,0x64,0x61,0x6B,0x20
	.DB  0x54,0x65,0x72,0x64,0x61,0x66,0x74,0x61
	.DB  0x72,0x20,0x0
_0x2040003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x07
	.DW  _0x7
	.DW  _0x0*2

	.DW  0x11
	.DW  _0x58
	.DW  _0x0*2+7

	.DW  0x11
	.DW  _0x58+17
	.DW  _0x0*2+24

	.DW  0x11
	.DW  _0x58+34
	.DW  _0x0*2+41

	.DW  0x11
	.DW  _0x58+51
	.DW  _0x0*2+58

	.DW  0x11
	.DW  _0x58+68
	.DW  _0x0*2+75

	.DW  0x0A
	.DW  _namaUser
	.DW  _0x59*2

	.DW  0x04
	.DW  _0x5A
	.DW  _0x0*2+92

	.DW  0x04
	.DW  _0x5A+4
	.DW  _0x0*2+96

	.DW  0x04
	.DW  _0x5A+8
	.DW  _0x0*2+100

	.DW  0x04
	.DW  _0x5A+12
	.DW  _0x0*2+104

	.DW  0x04
	.DW  _0x5A+16
	.DW  _0x0*2+108

	.DW  0x0A
	.DW  _nomorPin
	.DW  _0x5B*2

	.DW  0x0C
	.DW  _id1
	.DW  _0x5C*2

	.DW  0x0C
	.DW  _id2
	.DW  _0x5D*2

	.DW  0x0C
	.DW  _id3
	.DW  _0x5E*2

	.DW  0x0C
	.DW  _id4
	.DW  _0x5F*2

	.DW  0x0C
	.DW  _id5
	.DW  _0x60*2

	.DW  0x11
	.DW  _0x85
	.DW  _0x0*2+112

	.DW  0x11
	.DW  _0x85+17
	.DW  _0x0*2+129

	.DW  0x11
	.DW  _0x85+34
	.DW  _0x0*2+235

	.DW  0x11
	.DW  _0x85+51
	.DW  _0x0*2+252

	.DW  0x11
	.DW  _0x85+68
	.DW  _0x0*2+235

	.DW  0x11
	.DW  _0x85+85
	.DW  _0x0*2+252

	.DW  0x11
	.DW  _0x85+102
	.DW  _0x0*2+235

	.DW  0x11
	.DW  _0x85+119
	.DW  _0x0*2+252

	.DW  0x11
	.DW  _0x85+136
	.DW  _0x0*2+235

	.DW  0x11
	.DW  _0x85+153
	.DW  _0x0*2+252

	.DW  0x11
	.DW  _0x85+170
	.DW  _0x0*2+235

	.DW  0x11
	.DW  _0x85+187
	.DW  _0x0*2+252

	.DW  0x11
	.DW  _0x85+204
	.DW  _0x0*2+610

	.DW  0x0A
	.DW  0x03
	.DW  _0xD0*2

	.DW  0x02
	.DW  __base_y_G102
	.DW  _0x2040003*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
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

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x200

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 7/16/2012
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega164A
;Program type            : Application
;AVR Core Clock frequency: 11.059200 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
;
;#include <mega164a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;#include <stdio.h>
;#include <delay.h>
;#include <string.h>
;
;#define  LED_IND  PORTD.5
;#define  BUZZER   PORTD.6
;#define  SOLENOID PORTD.7
;
;// Alphanumeric LCD Module functions
;#include <alcd.h>
;
;#ifndef RXB8
;#define RXB8 1
;#endif
;
;#ifndef TXB8
;#define TXB8 0
;#endif
;
;#ifndef UPE
;#define UPE 2
;#endif
;
;#ifndef DOR
;#define DOR 3
;#endif
;
;#ifndef FE
;#define FE 4
;#endif
;
;#ifndef UDRE
;#define UDRE 5
;#endif
;
;#ifndef RXC
;#define RXC 7
;#endif
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;
;char kata1[16], kata2[16];
;
;//// USART0 Receiver interrupt service routine
;//interrupt [USART0_RXC] void usart0_rx_isr(void) {
;//   char status,data;
;//   status=UCSR0A;
;//   data=UDR0;
;//   if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0) {
;//
;//   }
;//}
;
;// USART1 Receiver interrupt service routine
;
;unsigned int countDataRFID = 0;
;bit dataComplete = 0;
;unsigned char dataSerial[17];
;unsigned char dataRFID[12];
;unsigned char dataAsciiRFID[12];
;interrupt [USART1_RXC] void usart1_rx_isr(void) {
; 0000 0059 interrupt [29] void usart1_rx_isr(void) {

	.CSEG
_usart1_rx_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 005A    char status,data;
; 0000 005B    status=UCSR1A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,200
; 0000 005C    data=UDR1;
	LDS  R16,206
; 0000 005D    if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0) {
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x3
; 0000 005E       dataSerial[countDataRFID]=data;
	__GETW1R 3,4
	SUBI R30,LOW(-_dataSerial)
	SBCI R31,HIGH(-_dataSerial)
	ST   Z,R16
; 0000 005F       countDataRFID++;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 3,4,30,31
; 0000 0060    }
; 0000 0061    if(countDataRFID>=16) {
_0x3:
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CP   R3,R30
	CPC  R4,R31
	BRLO _0x4
; 0000 0062       dataComplete=1;
	SBI  0x1E,0
; 0000 0063       countDataRFID=0;
	CLR  R3
	CLR  R4
; 0000 0064    }
; 0000 0065 }
_0x4:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;
;char password[5];
;int counter=0;
;void scanKeypad() {
; 0000 0069 void scanKeypad() {
_scanKeypad:
; 0000 006A    lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x0
; 0000 006B    lcd_puts("PIN : ");
	__POINTW1MN _0x7,0
	CALL SUBOPT_0x1
; 0000 006C    PORTC=0b01111111;
	LDI  R30,LOW(127)
	CALL SUBOPT_0x2
; 0000 006D    delay_ms(30);
; 0000 006E    if(PINC.0==0) {
	SBIC 0x6,0
	RJMP _0x8
; 0000 006F       password[counter]='*';
	CALL SUBOPT_0x3
	LDI  R30,LOW(42)
	CALL SUBOPT_0x4
; 0000 0070       lcd_gotoxy(counter+6,1);
; 0000 0071       //lcd_putchar(password[counter]);
; 0000 0072       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 0073       counter++;
; 0000 0074       BUZZER=1;
; 0000 0075       delay_ms(100);
; 0000 0076       BUZZER=0;
; 0000 0077    }
; 0000 0078    if(PINC.1==0) {
_0x8:
	SBIC 0x6,1
	RJMP _0xD
; 0000 0079       password[counter]='7';
	CALL SUBOPT_0x3
	LDI  R30,LOW(55)
	CALL SUBOPT_0x4
; 0000 007A       lcd_gotoxy(counter+6,1);
; 0000 007B       //lcd_putchar(password[counter]);
; 0000 007C       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 007D       counter++;
; 0000 007E       BUZZER=1;
; 0000 007F       delay_ms(100);
; 0000 0080       BUZZER=0;
; 0000 0081    }
; 0000 0082    if(PINC.2==0) {
_0xD:
	SBIC 0x6,2
	RJMP _0x12
; 0000 0083       password[counter]='4';
	CALL SUBOPT_0x3
	LDI  R30,LOW(52)
	CALL SUBOPT_0x4
; 0000 0084       lcd_gotoxy(counter+6,1);
; 0000 0085       //lcd_putchar(password[counter]);
; 0000 0086       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 0087       counter++;
; 0000 0088       BUZZER=1;
; 0000 0089       delay_ms(100);
; 0000 008A       BUZZER=0;
; 0000 008B    }
; 0000 008C    if(PINC.3==0) {
_0x12:
	SBIC 0x6,3
	RJMP _0x17
; 0000 008D       password[counter]='1';
	CALL SUBOPT_0x3
	LDI  R30,LOW(49)
	CALL SUBOPT_0x4
; 0000 008E       lcd_gotoxy(counter+6,1);
; 0000 008F       //lcd_putchar(password[counter]);
; 0000 0090       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 0091       counter++;
; 0000 0092       BUZZER=1;
; 0000 0093       delay_ms(100);
; 0000 0094       BUZZER=0;
; 0000 0095    }
; 0000 0096    PORTC=0b10111111;
_0x17:
	LDI  R30,LOW(191)
	CALL SUBOPT_0x2
; 0000 0097    delay_ms(30);
; 0000 0098    if(PINC.0==0) {
	SBIC 0x6,0
	RJMP _0x1C
; 0000 0099       password[counter]='0';
	CALL SUBOPT_0x3
	LDI  R30,LOW(48)
	CALL SUBOPT_0x4
; 0000 009A       lcd_gotoxy(counter+6,1);
; 0000 009B       //lcd_putchar(password[counter]);
; 0000 009C       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 009D       counter++;
; 0000 009E       BUZZER=1;
; 0000 009F       delay_ms(100);
; 0000 00A0       BUZZER=0;
; 0000 00A1    }
; 0000 00A2    if(PINC.1==0) {
_0x1C:
	SBIC 0x6,1
	RJMP _0x21
; 0000 00A3       password[counter]='8';
	CALL SUBOPT_0x3
	LDI  R30,LOW(56)
	CALL SUBOPT_0x4
; 0000 00A4       lcd_gotoxy(counter+6,1);
; 0000 00A5       //lcd_putchar(password[counter]);
; 0000 00A6       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00A7       counter++;
; 0000 00A8       BUZZER=1;
; 0000 00A9       delay_ms(100);
; 0000 00AA       BUZZER=0;
; 0000 00AB    }
; 0000 00AC    if(PINC.2==0) {
_0x21:
	SBIC 0x6,2
	RJMP _0x26
; 0000 00AD       password[counter]='5';
	CALL SUBOPT_0x3
	LDI  R30,LOW(53)
	CALL SUBOPT_0x4
; 0000 00AE       lcd_gotoxy(counter+6,1);
; 0000 00AF       //lcd_putchar(password[counter]);
; 0000 00B0       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00B1       counter++;
; 0000 00B2       BUZZER=1;
; 0000 00B3       delay_ms(100);
; 0000 00B4       BUZZER=0;
; 0000 00B5    }
; 0000 00B6    if(PINC.3==0) {
_0x26:
	SBIC 0x6,3
	RJMP _0x2B
; 0000 00B7       password[counter]='2';
	CALL SUBOPT_0x3
	LDI  R30,LOW(50)
	CALL SUBOPT_0x4
; 0000 00B8       lcd_gotoxy(counter+6,1);
; 0000 00B9       //lcd_putchar(password[counter]);
; 0000 00BA       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00BB       counter++;
; 0000 00BC       BUZZER=1;
; 0000 00BD       delay_ms(100);
; 0000 00BE       BUZZER=0;
; 0000 00BF    }
; 0000 00C0    PORTC=0b11011111;
_0x2B:
	LDI  R30,LOW(223)
	CALL SUBOPT_0x2
; 0000 00C1    delay_ms(30);
; 0000 00C2    if(PINC.0==0) {
	SBIC 0x6,0
	RJMP _0x30
; 0000 00C3       password[counter]='#';
	CALL SUBOPT_0x3
	LDI  R30,LOW(35)
	CALL SUBOPT_0x4
; 0000 00C4       lcd_gotoxy(counter+6,1);
; 0000 00C5       //lcd_putchar(password[counter]);
; 0000 00C6       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00C7       counter++;
; 0000 00C8       BUZZER=1;
; 0000 00C9       delay_ms(100);
; 0000 00CA       BUZZER=0;
; 0000 00CB    }
; 0000 00CC    if(PINC.1==0) {
_0x30:
	SBIC 0x6,1
	RJMP _0x35
; 0000 00CD       password[counter]='9';
	CALL SUBOPT_0x3
	LDI  R30,LOW(57)
	CALL SUBOPT_0x4
; 0000 00CE       lcd_gotoxy(counter+6,1);
; 0000 00CF       //lcd_putchar(password[counter]);
; 0000 00D0       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00D1       counter++;
; 0000 00D2       BUZZER=1;
; 0000 00D3       delay_ms(100);
; 0000 00D4       BUZZER=0;
; 0000 00D5    }
; 0000 00D6    if(PINC.2==0) {
_0x35:
	SBIC 0x6,2
	RJMP _0x3A
; 0000 00D7       password[counter]='6';
	CALL SUBOPT_0x3
	LDI  R30,LOW(54)
	CALL SUBOPT_0x4
; 0000 00D8       lcd_gotoxy(counter+6,1);
; 0000 00D9       //lcd_putchar(password[counter]);
; 0000 00DA       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00DB       counter++;
; 0000 00DC       BUZZER=1;
; 0000 00DD       delay_ms(100);
; 0000 00DE       BUZZER=0;
; 0000 00DF    }
; 0000 00E0    if(PINC.3==0) {
_0x3A:
	SBIC 0x6,3
	RJMP _0x3F
; 0000 00E1       password[counter]='3';
	CALL SUBOPT_0x3
	LDI  R30,LOW(51)
	CALL SUBOPT_0x4
; 0000 00E2       lcd_gotoxy(counter+6,1);
; 0000 00E3       //lcd_putchar(password[counter]);
; 0000 00E4       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00E5       counter++;
; 0000 00E6       BUZZER=1;
; 0000 00E7       delay_ms(100);
; 0000 00E8       BUZZER=0;
; 0000 00E9    }
; 0000 00EA    PORTC=0b11101111;
_0x3F:
	LDI  R30,LOW(239)
	CALL SUBOPT_0x2
; 0000 00EB    delay_ms(30);
; 0000 00EC    if(PINC.0==0) {
	SBIC 0x6,0
	RJMP _0x44
; 0000 00ED       password[counter]='D';
	CALL SUBOPT_0x3
	LDI  R30,LOW(68)
	CALL SUBOPT_0x4
; 0000 00EE       lcd_gotoxy(counter+6,1);
; 0000 00EF       //lcd_putchar(password[counter]);
; 0000 00F0       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00F1       counter++;
; 0000 00F2       BUZZER=1;
; 0000 00F3       delay_ms(100);
; 0000 00F4       BUZZER=0;
; 0000 00F5    }
; 0000 00F6    if(PINC.1==0) {
_0x44:
	SBIC 0x6,1
	RJMP _0x49
; 0000 00F7       password[counter]='C';
	CALL SUBOPT_0x3
	LDI  R30,LOW(67)
	CALL SUBOPT_0x4
; 0000 00F8       lcd_gotoxy(counter+6,1);
; 0000 00F9       //lcd_putchar(password[counter]);
; 0000 00FA       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 00FB       counter++;
; 0000 00FC       BUZZER=1;
; 0000 00FD       delay_ms(100);
; 0000 00FE       BUZZER=0;
; 0000 00FF    }
; 0000 0100    if(PINC.2==0) {
_0x49:
	SBIC 0x6,2
	RJMP _0x4E
; 0000 0101       password[counter]='B';
	CALL SUBOPT_0x3
	LDI  R30,LOW(66)
	CALL SUBOPT_0x4
; 0000 0102       lcd_gotoxy(counter+6,1);
; 0000 0103       //lcd_putchar(password[counter]);
; 0000 0104       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 0105       counter++;
; 0000 0106       BUZZER=1;
; 0000 0107       delay_ms(100);
; 0000 0108       BUZZER=0;
; 0000 0109    }
; 0000 010A    if(PINC.3==0) {
_0x4E:
	SBIC 0x6,3
	RJMP _0x53
; 0000 010B       password[counter]='A';
	CALL SUBOPT_0x3
	LDI  R30,LOW(65)
	CALL SUBOPT_0x4
; 0000 010C       lcd_gotoxy(counter+6,1);
; 0000 010D       //lcd_putchar(password[counter]);
; 0000 010E       lcd_putchar('*');
	CALL SUBOPT_0x5
; 0000 010F       counter++;
; 0000 0110       BUZZER=1;
; 0000 0111       delay_ms(100);
; 0000 0112       BUZZER=0;
; 0000 0113    }
; 0000 0114 }
_0x53:
	RET

	.DSEG
_0x7:
	.BYTE 0x7
;
;// Standard Input/Output functions
;#include <stdio.h>
;int i=0, j=0, k=0;
;
;// Declare your global variables here
;// 3F 66 0A E6 E6 26 A6 OA E6 E6 A6 A6 0A
;unsigned char* namaUser[] = {"Joko Setyawan   ","Rizky Gumilang  ","Bon Jovi        ","Tom Cruise      ","Susan           "};
_0x58:
	.BYTE 0x55
;unsigned char* nomorPin[] = {"024","032","123","234","541"};
_0x5A:
	.BYTE 0x14
;unsigned char id1[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x06, 0x0F, 0x09, 0x00, 0x08, 0x0C};
;unsigned char id2[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x08, 0x0A, 0x09, 0x0B, 0x06, 0x02};
;unsigned char id3[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x04, 0x08, 0x06, 0x05, 0x05, 0x0E};
;unsigned char id4[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x05, 0x08, 0x00, 0x02, 0x02, 0x09};
;unsigned char id5[] = {0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x0A, 0x0D, 0x03, 0x05, 0x0E, 0x0B};
;
;int bandingkanData() {
; 0000 0124 int bandingkanData() {

	.CSEG
_bandingkanData:
	PUSH R15
; 0000 0125    int hasil;
; 0000 0126    bit sama;
; 0000 0127    bit selesai=0;
; 0000 0128    if(selesai==0) {
	ST   -Y,R17
	ST   -Y,R16
;	hasil -> R16,R17
;	sama -> R15.0
;	selesai -> R15.1
	CLR  R15
	SBRC R15,1
	RJMP _0x61
; 0000 0129       sama=1;
	CALL SUBOPT_0x6
; 0000 012A       for(i=0;i<12;i++) {
_0x63:
	CALL SUBOPT_0x7
	BRGE _0x64
; 0000 012B          if(dataAsciiRFID[i]!=id1[i]){
	CALL SUBOPT_0x8
	LDI  R26,LOW(_id1)
	LDI  R27,HIGH(_id1)
	CALL SUBOPT_0x9
	BREQ _0x65
; 0000 012C             sama=0;
	CLT
	BLD  R15,0
; 0000 012D             break;
	RJMP _0x64
; 0000 012E          }
; 0000 012F       }
_0x65:
	CALL SUBOPT_0xA
	RJMP _0x63
_0x64:
; 0000 0130       if(sama==1) {
	SBRS R15,0
	RJMP _0x66
; 0000 0131          selesai = 1;
	SET
	BLD  R15,1
; 0000 0132          hasil = 1;
	__GETWRN 16,17,1
; 0000 0133       }
; 0000 0134    }
_0x66:
; 0000 0135    if(selesai==0) {
_0x61:
	SBRC R15,1
	RJMP _0x67
; 0000 0136       sama=1;
	CALL SUBOPT_0x6
; 0000 0137       for(i=0;i<12;i++) {
_0x69:
	CALL SUBOPT_0x7
	BRGE _0x6A
; 0000 0138          if(dataAsciiRFID[i]!=id2[i]){
	CALL SUBOPT_0x8
	LDI  R26,LOW(_id2)
	LDI  R27,HIGH(_id2)
	CALL SUBOPT_0x9
	BREQ _0x6B
; 0000 0139             sama=0;
	CLT
	BLD  R15,0
; 0000 013A             break;
	RJMP _0x6A
; 0000 013B          }
; 0000 013C       }
_0x6B:
	CALL SUBOPT_0xA
	RJMP _0x69
_0x6A:
; 0000 013D       if(sama==1) {
	SBRS R15,0
	RJMP _0x6C
; 0000 013E          selesai = 1;
	SET
	BLD  R15,1
; 0000 013F          hasil = 2;
	__GETWRN 16,17,2
; 0000 0140       }
; 0000 0141    }
_0x6C:
; 0000 0142    if(selesai==0) {
_0x67:
	SBRC R15,1
	RJMP _0x6D
; 0000 0143       sama=1;
	CALL SUBOPT_0x6
; 0000 0144       for(i=0;i<12;i++) {
_0x6F:
	CALL SUBOPT_0x7
	BRGE _0x70
; 0000 0145          if(dataAsciiRFID[i]!=id3[i]){
	CALL SUBOPT_0x8
	LDI  R26,LOW(_id3)
	LDI  R27,HIGH(_id3)
	CALL SUBOPT_0x9
	BREQ _0x71
; 0000 0146             sama=0;
	CLT
	BLD  R15,0
; 0000 0147             break;
	RJMP _0x70
; 0000 0148          }
; 0000 0149       }
_0x71:
	CALL SUBOPT_0xA
	RJMP _0x6F
_0x70:
; 0000 014A       if(sama==1) {
	SBRS R15,0
	RJMP _0x72
; 0000 014B          selesai = 1;
	SET
	BLD  R15,1
; 0000 014C          hasil = 3;
	__GETWRN 16,17,3
; 0000 014D       }
; 0000 014E    }
_0x72:
; 0000 014F    if(selesai==0) {
_0x6D:
	SBRC R15,1
	RJMP _0x73
; 0000 0150       sama=1;
	CALL SUBOPT_0x6
; 0000 0151       for(i=0;i<12;i++) {
_0x75:
	CALL SUBOPT_0x7
	BRGE _0x76
; 0000 0152          if(dataAsciiRFID[i]!=id4[i]){
	CALL SUBOPT_0x8
	LDI  R26,LOW(_id4)
	LDI  R27,HIGH(_id4)
	CALL SUBOPT_0x9
	BREQ _0x77
; 0000 0153             sama=0;
	CLT
	BLD  R15,0
; 0000 0154             break;
	RJMP _0x76
; 0000 0155          }
; 0000 0156       }
_0x77:
	CALL SUBOPT_0xA
	RJMP _0x75
_0x76:
; 0000 0157       if(sama==1) {
	SBRS R15,0
	RJMP _0x78
; 0000 0158          selesai = 1;
	SET
	BLD  R15,1
; 0000 0159          hasil = 4;
	__GETWRN 16,17,4
; 0000 015A       }
; 0000 015B    }
_0x78:
; 0000 015C    if(selesai==0) {
_0x73:
	SBRC R15,1
	RJMP _0x79
; 0000 015D       sama=1;
	CALL SUBOPT_0x6
; 0000 015E       for(i=0;i<12;i++) {
_0x7B:
	CALL SUBOPT_0x7
	BRGE _0x7C
; 0000 015F          if(dataAsciiRFID[i]!=id5[i]){
	CALL SUBOPT_0x8
	LDI  R26,LOW(_id5)
	LDI  R27,HIGH(_id5)
	CALL SUBOPT_0x9
	BREQ _0x7D
; 0000 0160             sama=0;
	CLT
	BLD  R15,0
; 0000 0161             break;
	RJMP _0x7C
; 0000 0162          }
; 0000 0163       }
_0x7D:
	CALL SUBOPT_0xA
	RJMP _0x7B
_0x7C:
; 0000 0164       if(sama==1) {
	SBRS R15,0
	RJMP _0x7E
; 0000 0165          selesai = 1;
	SET
	BLD  R15,1
; 0000 0166          hasil = 5;
	__GETWRN 16,17,5
; 0000 0167       }
; 0000 0168    }
_0x7E:
; 0000 0169    if(selesai==0) {
_0x79:
	SBRC R15,1
	RJMP _0x7F
; 0000 016A       hasil=0;
	__GETWRN 16,17,0
; 0000 016B    }
; 0000 016C    return hasil;
_0x7F:
	MOVW R30,R16
	LD   R16,Y+
	LD   R17,Y+
	POP  R15
	RET
; 0000 016D }
;
;int noUser;
;
;void main(void) {
; 0000 0171 void main(void) {
_main:
; 0000 0172 // Declare your local variables here
; 0000 0173 
; 0000 0174 // Crystal Oscillator division factor: 1
; 0000 0175 #pragma optsize-
; 0000 0176 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0177 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0178 #ifdef _OPTIMIZE_SIZE_
; 0000 0179 #pragma optsize+
; 0000 017A #endif
; 0000 017B 
; 0000 017C // Input/Output Ports initialization
; 0000 017D // Port A initialization
; 0000 017E // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 017F // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0180 PORTA=0x00;
	OUT  0x2,R30
; 0000 0181 DDRA=0x00;
	OUT  0x1,R30
; 0000 0182 
; 0000 0183 // Port B initialization
; 0000 0184 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0185 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0186 PORTB=0x00;
	OUT  0x5,R30
; 0000 0187 DDRB=0x00;
	OUT  0x4,R30
; 0000 0188 
; 0000 0189 // Port C initialization
; 0000 018A // Func7=Out Func6=Out Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In
; 0000 018B // State7=1 State6=1 State5=1 State4=1 State3=P State2=P State1=P State0=P
; 0000 018C PORTC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x8,R30
; 0000 018D DDRC=0xF0;
	LDI  R30,LOW(240)
	OUT  0x7,R30
; 0000 018E 
; 0000 018F // Port D initialization
; 0000 0190 // Func7=Out Func6=Out Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0191 // State7=0 State6=0 State5=0 State4=T State3=T State2=T State1=T State0=T
; 0000 0192 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 0193 DDRD=0xE0;
	LDI  R30,LOW(224)
	OUT  0xA,R30
; 0000 0194 
; 0000 0195 // Timer/Counter 0 initialization
; 0000 0196 // Clock source: System Clock
; 0000 0197 // Clock value: Timer 0 Stopped
; 0000 0198 // Mode: Normal top=0xFF
; 0000 0199 // OC0A output: Disconnected
; 0000 019A // OC0B output: Disconnected
; 0000 019B TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 019C TCCR0B=0x00;
	OUT  0x25,R30
; 0000 019D TCNT0=0x00;
	OUT  0x26,R30
; 0000 019E OCR0A=0x00;
	OUT  0x27,R30
; 0000 019F OCR0B=0x00;
	OUT  0x28,R30
; 0000 01A0 
; 0000 01A1 // Timer/Counter 1 initialization
; 0000 01A2 // Clock source: System Clock
; 0000 01A3 // Clock value: Timer1 Stopped
; 0000 01A4 // Mode: Normal top=0xFFFF
; 0000 01A5 // OC1A output: Discon.
; 0000 01A6 // OC1B output: Discon.
; 0000 01A7 // Noise Canceler: Off
; 0000 01A8 // Input Capture on Falling Edge
; 0000 01A9 // Timer1 Overflow Interrupt: Off
; 0000 01AA // Input Capture Interrupt: Off
; 0000 01AB // Compare A Match Interrupt: Off
; 0000 01AC // Compare B Match Interrupt: Off
; 0000 01AD TCCR1A=0x00;
	STS  128,R30
; 0000 01AE TCCR1B=0x00;
	STS  129,R30
; 0000 01AF TCNT1H=0x00;
	STS  133,R30
; 0000 01B0 TCNT1L=0x00;
	STS  132,R30
; 0000 01B1 ICR1H=0x00;
	STS  135,R30
; 0000 01B2 ICR1L=0x00;
	STS  134,R30
; 0000 01B3 OCR1AH=0x00;
	STS  137,R30
; 0000 01B4 OCR1AL=0x00;
	STS  136,R30
; 0000 01B5 OCR1BH=0x00;
	STS  139,R30
; 0000 01B6 OCR1BL=0x00;
	STS  138,R30
; 0000 01B7 
; 0000 01B8 // Timer/Counter 2 initialization
; 0000 01B9 // Clock source: System Clock
; 0000 01BA // Clock value: Timer2 Stopped
; 0000 01BB // Mode: Normal top=0xFF
; 0000 01BC // OC2A output: Disconnected
; 0000 01BD // OC2B output: Disconnected
; 0000 01BE ASSR=0x00;
	STS  182,R30
; 0000 01BF TCCR2A=0x00;
	STS  176,R30
; 0000 01C0 TCCR2B=0x00;
	STS  177,R30
; 0000 01C1 TCNT2=0x00;
	STS  178,R30
; 0000 01C2 OCR2A=0x00;
	STS  179,R30
; 0000 01C3 OCR2B=0x00;
	STS  180,R30
; 0000 01C4 
; 0000 01C5 // External Interrupt(s) initialization
; 0000 01C6 // INT0: Off
; 0000 01C7 // INT1: Off
; 0000 01C8 // INT2: Off
; 0000 01C9 // Interrupt on any change on pins PCINT0-7: Off
; 0000 01CA // Interrupt on any change on pins PCINT8-15: Off
; 0000 01CB // Interrupt on any change on pins PCINT16-23: Off
; 0000 01CC // Interrupt on any change on pins PCINT24-31: Off
; 0000 01CD EICRA=0x00;
	STS  105,R30
; 0000 01CE EIMSK=0x00;
	OUT  0x1D,R30
; 0000 01CF PCICR=0x00;
	STS  104,R30
; 0000 01D0 
; 0000 01D1 // Timer/Counter 0 Interrupt(s) initialization
; 0000 01D2 TIMSK0=0x00;
	STS  110,R30
; 0000 01D3 
; 0000 01D4 // Timer/Counter 1 Interrupt(s) initialization
; 0000 01D5 TIMSK1=0x00;
	STS  111,R30
; 0000 01D6 
; 0000 01D7 // Timer/Counter 2 Interrupt(s) initialization
; 0000 01D8 TIMSK2=0x00;
	STS  112,R30
; 0000 01D9 
; 0000 01DA // USART0 initialization
; 0000 01DB // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 01DC // USART0 Receiver: On
; 0000 01DD // USART0 Transmitter: On
; 0000 01DE // USART0 Mode: Asynchronous
; 0000 01DF // USART0 Baud Rate: 9600
; 0000 01E0 UCSR0A=0x00;
	STS  192,R30
; 0000 01E1 UCSR0B=0x98;
	LDI  R30,LOW(152)
	STS  193,R30
; 0000 01E2 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
; 0000 01E3 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0000 01E4 UBRR0L=0x47;
	LDI  R30,LOW(71)
	STS  196,R30
; 0000 01E5 
; 0000 01E6 // USART1 initialization
; 0000 01E7 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 01E8 // USART1 Receiver: On
; 0000 01E9 // USART1 Transmitter: On
; 0000 01EA // USART1 Mode: Asynchronous
; 0000 01EB // USART1 Baud Rate: 9600
; 0000 01EC UCSR1A=0x00;
	LDI  R30,LOW(0)
	STS  200,R30
; 0000 01ED UCSR1B=0x98;
	LDI  R30,LOW(152)
	STS  201,R30
; 0000 01EE UCSR1C=0x06;
	LDI  R30,LOW(6)
	STS  202,R30
; 0000 01EF UBRR1H=0x00;
	LDI  R30,LOW(0)
	STS  205,R30
; 0000 01F0 UBRR1L=0x47;
	LDI  R30,LOW(71)
	STS  204,R30
; 0000 01F1 
; 0000 01F2 // Analog Comparator initialization
; 0000 01F3 // Analog Comparator: Off
; 0000 01F4 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 01F5 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 01F6 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 01F7 DIDR1=0x00;
	STS  127,R30
; 0000 01F8 
; 0000 01F9 // ADC initialization
; 0000 01FA // ADC disabled
; 0000 01FB ADCSRA=0x00;
	STS  122,R30
; 0000 01FC 
; 0000 01FD // SPI initialization
; 0000 01FE // SPI disabled
; 0000 01FF SPCR=0x00;
	OUT  0x2C,R30
; 0000 0200 
; 0000 0201 // TWI initialization
; 0000 0202 // TWI disabled
; 0000 0203 TWCR=0x00;
	STS  188,R30
; 0000 0204 
; 0000 0205 // Alphanumeric LCD initialization
; 0000 0206 // Connections specified in the
; 0000 0207 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 0208 // RS - PORTA Bit 0
; 0000 0209 // RD - PORTA Bit 1
; 0000 020A // EN - PORTA Bit 2
; 0000 020B // D4 - PORTA Bit 4
; 0000 020C // D5 - PORTA Bit 5
; 0000 020D // D6 - PORTA Bit 6
; 0000 020E // D7 - PORTA Bit 7
; 0000 020F // Characters/line: 16
; 0000 0210 lcd_init(16);
	LDI  R30,LOW(16)
	ST   -Y,R30
	CALL _lcd_init
; 0000 0211 lcd_clear();
	CALL _lcd_clear
; 0000 0212 LED_IND = 1;
	SBI  0xB,5
; 0000 0213 // Global enable interrupts
; 0000 0214 #asm("sei")
	sei
; 0000 0215 while (1) {
_0x82:
; 0000 0216       bit pinSalah = 0;
; 0000 0217       lcd_gotoxy(0,0);
;	pinSalah -> R15.0
	MOV  R30,R15
	ANDI R30,LOW(0xFE)
	MOV  R15,R30
	CALL SUBOPT_0xB
; 0000 0218       lcd_puts("RFID Reader     ");
	__POINTW1MN _0x85,0
	CALL SUBOPT_0x1
; 0000 0219       while(!dataComplete);
_0x86:
	SBIS 0x1E,0
	RJMP _0x86
; 0000 021A       dataComplete=0;
	CBI  0x1E,0
; 0000 021B       // Tampilkan ke Serial
; 0000 021C //      printf("Data Serial : ");
; 0000 021D //      for(i=0;i<strlen(dataSerial);i++){
; 0000 021E //         putchar(dataSerial[i]);
; 0000 021F //      }
; 0000 0220 
; 0000 0221 //      printf("Data RFID : ");
; 0000 0222       // Ambil data RFID
; 0000 0223       for(i=1;i<=12;i++) {
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__PUTW1R 7,8
_0x8C:
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	CP   R30,R7
	CPC  R31,R8
	BRLT _0x8D
; 0000 0224          dataRFID[i-1]=dataSerial[i];
	__GETW1R 7,8
	SBIW R30,1
	SUBI R30,LOW(-_dataRFID)
	SBCI R31,HIGH(-_dataRFID)
	MOVW R0,R30
	LDI  R26,LOW(_dataSerial)
	LDI  R27,HIGH(_dataSerial)
	ADD  R26,R7
	ADC  R27,R8
	LD   R30,X
	MOVW R26,R0
	ST   X,R30
; 0000 0225 //         putchar(dataRFID[i-1]);
; 0000 0226 //         putchar(' ');
; 0000 0227       }
	CALL SUBOPT_0xA
	RJMP _0x8C
_0x8D:
; 0000 0228       // Konvert Ke ASCII
; 0000 0229       for(i=0;i<12;i++) {
	CLR  R7
	CLR  R8
_0x8F:
	CALL SUBOPT_0x7
	BRGE _0x90
; 0000 022A          if ((dataRFID[i] >= '0') && (dataRFID[i] <= '9')) {
	CALL SUBOPT_0xC
	CPI  R26,LOW(0x30)
	BRLO _0x92
	CALL SUBOPT_0xC
	CPI  R26,LOW(0x3A)
	BRLO _0x93
_0x92:
	RJMP _0x91
_0x93:
; 0000 022B             dataAsciiRFID[i] = dataRFID[i] - '0';
	CALL SUBOPT_0xD
	SBIW R30,48
	RJMP _0xCA
; 0000 022C          } else if ((dataRFID[i] >= 'A') && (dataRFID[i] <= 'F')) {
_0x91:
	CALL SUBOPT_0xC
	CPI  R26,LOW(0x41)
	BRLO _0x96
	CALL SUBOPT_0xC
	CPI  R26,LOW(0x47)
	BRLO _0x97
_0x96:
	RJMP _0x95
_0x97:
; 0000 022D             dataAsciiRFID[i] = 10 + dataRFID[i] - 'A';
	CALL SUBOPT_0xD
	ADIW R30,10
	SUBI R30,LOW(65)
	SBCI R31,HIGH(65)
_0xCA:
	MOVW R26,R0
	ST   X,R30
; 0000 022E          }
; 0000 022F       }
_0x95:
	CALL SUBOPT_0xA
	RJMP _0x8F
_0x90:
; 0000 0230 //      printf("\r\nHasil ASCII : ");
; 0000 0231 //      for(i=0;i<12;i++) {
; 0000 0232 //         putchar(dataAsciiRFID[i]);
; 0000 0233 //      }
; 0000 0234       noUser = bandingkanData();
	RCALL _bandingkanData
	__PUTW1R 13,14
; 0000 0235       if(noUser!=0) {
	MOV  R0,R13
	OR   R0,R14
	BRNE PC+3
	JMP _0x98
; 0000 0236       lcd_gotoxy(0,0);
	CALL SUBOPT_0xB
; 0000 0237       lcd_puts(namaUser[noUser-1]);
	__GETW1R 13,14
	SBIW R30,1
	LDI  R26,LOW(_namaUser)
	LDI  R27,HIGH(_namaUser)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	CALL SUBOPT_0x1
; 0000 0238       delay_ms(2000);
	CALL SUBOPT_0xE
; 0000 0239       lcd_gotoxy(0,0);
	CALL SUBOPT_0xB
; 0000 023A       lcd_puts("Masukkan PIN    ");
	__POINTW1MN _0x85,17
	CALL SUBOPT_0x1
; 0000 023B       while(counter<3) {
_0x99:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R5,R30
	CPC  R6,R31
	BRGE _0x9B
; 0000 023C          scanKeypad();
	RCALL _scanKeypad
; 0000 023D       }
	RJMP _0x99
_0x9B:
; 0000 023E       password[4]='\0';
	LDI  R30,LOW(0)
	__PUTB1MN _password,4
; 0000 023F       lcd_clear();
	CALL _lcd_clear
; 0000 0240       switch(noUser) {
	__GETW1R 13,14
; 0000 0241          case 1:  if(strcmp(nomorPin[0],password)==0) {
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x9F
	LDS  R30,_nomorPin
	LDS  R31,_nomorPin+1
	CALL SUBOPT_0xF
	BRNE _0xA0
; 0000 0242                      SOLENOID = 1;
	SBI  0xB,7
; 0000 0243                      printf("Joko Setyawan|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x06, 0x0F, 0x09, 0x00, 0x08, 0x0C}\r\n");
	__POINTW1FN _0x0,146
	CALL SUBOPT_0x10
; 0000 0244                      lcd_gotoxy(0,0);
; 0000 0245                      lcd_puts("Silahkan Masuk  ");
	__POINTW1MN _0x85,34
	RJMP _0xCB
; 0000 0246                   }
; 0000 0247                   else{
_0xA0:
; 0000 0248                      pinSalah = 1;
	CALL SUBOPT_0x11
; 0000 0249                      LED_IND = 0;
; 0000 024A                      lcd_gotoxy(0,0);
; 0000 024B                      lcd_puts("PIN Salah       ");
	__POINTW1MN _0x85,51
_0xCB:
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_puts
; 0000 024C                   }
; 0000 024D                   break;
	RJMP _0x9E
; 0000 024E          case 2:  if(strcmp(nomorPin[1],password)==0) {
_0x9F:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xA6
	__GETW1MN _nomorPin,2
	CALL SUBOPT_0xF
	BRNE _0xA7
; 0000 024F                      SOLENOID = 1;
	SBI  0xB,7
; 0000 0250                      printf("Rizky Gumilang|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x08, 0x0A, 0x09, 0x0B, 0x06, 0x02}\r\n");
	__POINTW1FN _0x0,269
	CALL SUBOPT_0x10
; 0000 0251                      lcd_gotoxy(0,0);
; 0000 0252                      lcd_puts("Silahkan Masuk  ");
	__POINTW1MN _0x85,68
	RJMP _0xCC
; 0000 0253                   }
; 0000 0254                   else{
_0xA7:
; 0000 0255                      pinSalah = 1;
	CALL SUBOPT_0x11
; 0000 0256                      LED_IND = 0;
; 0000 0257                      lcd_gotoxy(0,0);
; 0000 0258                      lcd_puts("PIN Salah       ");
	__POINTW1MN _0x85,85
_0xCC:
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_puts
; 0000 0259                   }
; 0000 025A                   break;
	RJMP _0x9E
; 0000 025B          case 3:  if(strcmp(nomorPin[2],password)==0) {
_0xA6:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0xAD
	__GETW1MN _nomorPin,4
	CALL SUBOPT_0xF
	BRNE _0xAE
; 0000 025C                      SOLENOID = 1;
	SBI  0xB,7
; 0000 025D                      printf("Bon Jovi|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x04, 0x08, 0x06, 0x05, 0x05, 0x0E}\r\n");
	__POINTW1FN _0x0,359
	CALL SUBOPT_0x10
; 0000 025E                      lcd_gotoxy(0,0);
; 0000 025F                      lcd_puts("Silahkan Masuk  ");
	__POINTW1MN _0x85,102
	RJMP _0xCD
; 0000 0260                   }
; 0000 0261                   else{
_0xAE:
; 0000 0262                      pinSalah = 1;
	CALL SUBOPT_0x11
; 0000 0263                      LED_IND = 0;
; 0000 0264                      lcd_gotoxy(0,0);
; 0000 0265                      lcd_puts("PIN Salah       ");
	__POINTW1MN _0x85,119
_0xCD:
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_puts
; 0000 0266                   }
; 0000 0267                   break;
	RJMP _0x9E
; 0000 0268          case 4:  if(strcmp(nomorPin[3],password)==0) {
_0xAD:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xB4
	__GETW1MN _nomorPin,6
	CALL SUBOPT_0xF
	BRNE _0xB5
; 0000 0269                      SOLENOID = 1;
	SBI  0xB,7
; 0000 026A                      printf("Tom Cruise|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x05, 0x08, 0x00, 0x02, 0x02, 0x09}\r\n");
	__POINTW1FN _0x0,443
	CALL SUBOPT_0x10
; 0000 026B                      lcd_gotoxy(0,0);
; 0000 026C                      lcd_puts("Silahkan Masuk  ");
	__POINTW1MN _0x85,136
	RJMP _0xCE
; 0000 026D                   }
; 0000 026E                   else{
_0xB5:
; 0000 026F                      pinSalah = 1;
	CALL SUBOPT_0x11
; 0000 0270                      LED_IND = 0;
; 0000 0271                      lcd_gotoxy(0,0);
; 0000 0272                      lcd_puts("PIN Salah       ");
	__POINTW1MN _0x85,153
_0xCE:
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_puts
; 0000 0273                   }
; 0000 0274                   break;
	RJMP _0x9E
; 0000 0275          case 5:  if(strcmp(nomorPin[4],password)==0) {
_0xB4:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x9E
	__GETW1MN _nomorPin,8
	CALL SUBOPT_0xF
	BRNE _0xBC
; 0000 0276                      SOLENOID = 1;
	SBI  0xB,7
; 0000 0277                      printf("Susan|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x0A, 0x0D, 0x03, 0x05, 0x0E, 0x0B}\r\n");
	__POINTW1FN _0x0,529
	CALL SUBOPT_0x10
; 0000 0278                      lcd_gotoxy(0,0);
; 0000 0279                      lcd_puts("Silahkan Masuk  ");
	__POINTW1MN _0x85,170
	RJMP _0xCF
; 0000 027A                   }
; 0000 027B                   else{
_0xBC:
; 0000 027C                      pinSalah = 1;
	CALL SUBOPT_0x11
; 0000 027D                      LED_IND = 0;
; 0000 027E                      lcd_gotoxy(0,0);
; 0000 027F                      lcd_puts("PIN Salah       ");
	__POINTW1MN _0x85,187
_0xCF:
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_puts
; 0000 0280                   }
; 0000 0281                   break;
; 0000 0282       }
_0x9E:
; 0000 0283       counter=0;
	CLR  R5
	CLR  R6
; 0000 0284       }
; 0000 0285       else{
	RJMP _0xC2
_0x98:
; 0000 0286          lcd_gotoxy(0,0);
	CALL SUBOPT_0xB
; 0000 0287          lcd_puts("Tidak Terdaftar ");
	__POINTW1MN _0x85,204
	CALL SUBOPT_0x1
; 0000 0288       }
_0xC2:
; 0000 0289       if(pinSalah) {
	SBRS R15,0
	RJMP _0xC3
; 0000 028A          delay_ms(2000);
	CALL SUBOPT_0xE
; 0000 028B          LED_IND = 1;
	SBI  0xB,5
; 0000 028C       }
; 0000 028D       else {
	RJMP _0xC6
_0xC3:
; 0000 028E          delay_ms(4000);
	LDI  R30,LOW(4000)
	LDI  R31,HIGH(4000)
	CALL SUBOPT_0x12
; 0000 028F          SOLENOID = 0;
	CBI  0xB,7
; 0000 0290       }
_0xC6:
; 0000 0291    }
	RJMP _0x82
; 0000 0292 }
_0xC9:
	RJMP _0xC9

	.DSEG
_0x85:
	.BYTE 0xDD
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_putchar:
_0x2000006:
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BREQ _0x2000006
	LD   R30,Y
	STS  198,R30
	JMP  _0x2080001
_put_usart_G100:
	LDD  R30,Y+2
	ST   -Y,R30
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	JMP  _0x2080002
__print_G100:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x200001C:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x200001E
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x2000022
	CPI  R18,37
	BRNE _0x2000023
	LDI  R17,LOW(1)
	RJMP _0x2000024
_0x2000023:
	CALL SUBOPT_0x13
_0x2000024:
	RJMP _0x2000021
_0x2000022:
	CPI  R30,LOW(0x1)
	BRNE _0x2000025
	CPI  R18,37
	BRNE _0x2000026
	CALL SUBOPT_0x13
	RJMP _0x20000CF
_0x2000026:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000027
	LDI  R16,LOW(1)
	RJMP _0x2000021
_0x2000027:
	CPI  R18,43
	BRNE _0x2000028
	LDI  R20,LOW(43)
	RJMP _0x2000021
_0x2000028:
	CPI  R18,32
	BRNE _0x2000029
	LDI  R20,LOW(32)
	RJMP _0x2000021
_0x2000029:
	RJMP _0x200002A
_0x2000025:
	CPI  R30,LOW(0x2)
	BRNE _0x200002B
_0x200002A:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x200002C
	ORI  R16,LOW(128)
	RJMP _0x2000021
_0x200002C:
	RJMP _0x200002D
_0x200002B:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x2000021
_0x200002D:
	CPI  R18,48
	BRLO _0x2000030
	CPI  R18,58
	BRLO _0x2000031
_0x2000030:
	RJMP _0x200002F
_0x2000031:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x2000021
_0x200002F:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2000035
	CALL SUBOPT_0x14
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x15
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x73)
	BRNE _0x2000038
	CALL SUBOPT_0x14
	CALL SUBOPT_0x16
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000039
_0x2000038:
	CPI  R30,LOW(0x70)
	BRNE _0x200003B
	CALL SUBOPT_0x14
	CALL SUBOPT_0x16
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000039:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x200003C
_0x200003B:
	CPI  R30,LOW(0x64)
	BREQ _0x200003F
	CPI  R30,LOW(0x69)
	BRNE _0x2000040
_0x200003F:
	ORI  R16,LOW(4)
	RJMP _0x2000041
_0x2000040:
	CPI  R30,LOW(0x75)
	BRNE _0x2000042
_0x2000041:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x2000043
_0x2000042:
	CPI  R30,LOW(0x58)
	BRNE _0x2000045
	ORI  R16,LOW(8)
	RJMP _0x2000046
_0x2000045:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x2000077
_0x2000046:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x2000043:
	SBRS R16,2
	RJMP _0x2000048
	CALL SUBOPT_0x14
	CALL SUBOPT_0x17
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000049
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000049:
	CPI  R20,0
	BREQ _0x200004A
	SUBI R17,-LOW(1)
	RJMP _0x200004B
_0x200004A:
	ANDI R16,LOW(251)
_0x200004B:
	RJMP _0x200004C
_0x2000048:
	CALL SUBOPT_0x14
	CALL SUBOPT_0x17
_0x200004C:
_0x200003C:
	SBRC R16,0
	RJMP _0x200004D
_0x200004E:
	CP   R17,R21
	BRSH _0x2000050
	SBRS R16,7
	RJMP _0x2000051
	SBRS R16,2
	RJMP _0x2000052
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x2000053
_0x2000052:
	LDI  R18,LOW(48)
_0x2000053:
	RJMP _0x2000054
_0x2000051:
	LDI  R18,LOW(32)
_0x2000054:
	CALL SUBOPT_0x13
	SUBI R21,LOW(1)
	RJMP _0x200004E
_0x2000050:
_0x200004D:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x2000055
_0x2000056:
	CPI  R19,0
	BREQ _0x2000058
	SBRS R16,3
	RJMP _0x2000059
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x200005A
_0x2000059:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x200005A:
	CALL SUBOPT_0x13
	CPI  R21,0
	BREQ _0x200005B
	SUBI R21,LOW(1)
_0x200005B:
	SUBI R19,LOW(1)
	RJMP _0x2000056
_0x2000058:
	RJMP _0x200005C
_0x2000055:
_0x200005E:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x2000060:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2000062
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x2000060
_0x2000062:
	CPI  R18,58
	BRLO _0x2000063
	SBRS R16,3
	RJMP _0x2000064
	SUBI R18,-LOW(7)
	RJMP _0x2000065
_0x2000064:
	SUBI R18,-LOW(39)
_0x2000065:
_0x2000063:
	SBRC R16,4
	RJMP _0x2000067
	CPI  R18,49
	BRSH _0x2000069
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000068
_0x2000069:
	RJMP _0x20000D0
_0x2000068:
	CP   R21,R19
	BRLO _0x200006D
	SBRS R16,0
	RJMP _0x200006E
_0x200006D:
	RJMP _0x200006C
_0x200006E:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x200006F
	LDI  R18,LOW(48)
_0x20000D0:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2000070
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x15
	CPI  R21,0
	BREQ _0x2000071
	SUBI R21,LOW(1)
_0x2000071:
_0x2000070:
_0x200006F:
_0x2000067:
	CALL SUBOPT_0x13
	CPI  R21,0
	BREQ _0x2000072
	SUBI R21,LOW(1)
_0x2000072:
_0x200006C:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x200005F
	RJMP _0x200005E
_0x200005F:
_0x200005C:
	SBRS R16,0
	RJMP _0x2000073
_0x2000074:
	CPI  R21,0
	BREQ _0x2000076
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x15
	RJMP _0x2000074
_0x2000076:
_0x2000073:
_0x2000077:
_0x2000036:
_0x20000CF:
	LDI  R17,LOW(0)
_0x2000021:
	RJMP _0x200001C
_0x200001E:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_usart_G100)
	LDI  R31,HIGH(_put_usart_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,8
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G100
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET

	.CSEG
_strcmp:
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
strcmp0:
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    brne strcmp1
    tst  r22
    brne strcmp0
strcmp3:
    clr  r30
    ret
strcmp1:
    sub  r22,r23
    breq strcmp3
    ldi  r30,1
    brcc strcmp2
    subi r30,2
strcmp2:
    ret
_strlen:
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G102:
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x2040004
	SBI  0x2,4
	RJMP _0x2040005
_0x2040004:
	CBI  0x2,4
_0x2040005:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x2040006
	SBI  0x2,5
	RJMP _0x2040007
_0x2040006:
	CBI  0x2,5
_0x2040007:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2040008
	SBI  0x2,6
	RJMP _0x2040009
_0x2040008:
	CBI  0x2,6
_0x2040009:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x204000A
	SBI  0x2,7
	RJMP _0x204000B
_0x204000A:
	CBI  0x2,7
_0x204000B:
	__DELAY_USB 7
	SBI  0x2,2
	__DELAY_USB 18
	CBI  0x2,2
	__DELAY_USB 18
	RJMP _0x2080001
__lcd_write_data:
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_nibble_G102
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_nibble_G102
	__DELAY_USB 184
	RJMP _0x2080001
_lcd_gotoxy:
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G102)
	SBCI R31,HIGH(-__base_y_G102)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R30,R26
	ST   -Y,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
_lcd_clear:
	LDI  R30,LOW(2)
	CALL SUBOPT_0x18
	LDI  R30,LOW(12)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(1)
	CALL SUBOPT_0x18
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
_lcd_putchar:
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2040011
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2040010
_0x2040011:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,__lcd_y
	SUBI R30,-LOW(1)
	STS  __lcd_y,R30
	ST   -Y,R30
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2040013
	RJMP _0x2080001
_0x2040013:
_0x2040010:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x2,0
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_data
	CBI  0x2,0
	RJMP _0x2080001
_lcd_puts:
	ST   -Y,R17
_0x2040014:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2040016
	ST   -Y,R17
	RCALL _lcd_putchar
	RJMP _0x2040014
_0x2040016:
	LDD  R17,Y+0
_0x2080002:
	ADIW R28,3
	RET
_lcd_init:
	SBI  0x1,4
	SBI  0x1,5
	SBI  0x1,6
	SBI  0x1,7
	SBI  0x1,2
	SBI  0x1,0
	SBI  0x1,1
	CBI  0x2,2
	CBI  0x2,0
	CBI  0x2,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G102,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G102,3
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CALL SUBOPT_0x12
	CALL SUBOPT_0x19
	CALL SUBOPT_0x19
	CALL SUBOPT_0x19
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL __lcd_write_nibble_G102
	__DELAY_USW 276
	LDI  R30,LOW(40)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(133)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(6)
	ST   -Y,R30
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	ADIW R28,1
	RET

	.CSEG

	.DSEG
_dataSerial:
	.BYTE 0x11
_dataRFID:
	.BYTE 0xC
_dataAsciiRFID:
	.BYTE 0xC
_password:
	.BYTE 0x5
_namaUser:
	.BYTE 0xA
_nomorPin:
	.BYTE 0xA
_id1:
	.BYTE 0xC
_id2:
	.BYTE 0xC
_id3:
	.BYTE 0xC
_id4:
	.BYTE 0xC
_id5:
	.BYTE 0xC
__base_y_G102:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x0:
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x2:
	OUT  0x8,R30
	LDI  R30,LOW(30)
	LDI  R31,HIGH(30)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x3:
	LDI  R26,LOW(_password)
	LDI  R27,HIGH(_password)
	ADD  R26,R5
	ADC  R27,R6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x4:
	ST   X,R30
	MOV  R30,R5
	SUBI R30,-LOW(6)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:207 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(42)
	ST   -Y,R30
	CALL _lcd_putchar
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 5,6,30,31
	SBI  0xB,6
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
	CBI  0xB,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	SET
	BLD  R15,0
	CLR  R7
	CLR  R8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	CP   R7,R30
	CPC  R8,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(_dataAsciiRFID)
	LDI  R27,HIGH(_dataAsciiRFID)
	ADD  R26,R7
	ADC  R27,R8
	LD   R0,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9:
	ADD  R26,R7
	ADC  R27,R8
	LD   R30,X
	CP   R30,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 7,8,30,31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:49 WORDS
SUBOPT_0xB:
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xC:
	LDI  R26,LOW(_dataRFID)
	LDI  R27,HIGH(_dataRFID)
	ADD  R26,R7
	ADC  R27,R8
	LD   R26,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xD:
	__GETW1R 7,8
	SUBI R30,LOW(-_dataAsciiRFID)
	SBCI R31,HIGH(-_dataAsciiRFID)
	MOVW R0,R30
	LDI  R26,LOW(_dataRFID)
	LDI  R27,HIGH(_dataRFID)
	ADD  R26,R7
	ADC  R27,R8
	LD   R30,X
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	LDI  R30,LOW(2000)
	LDI  R31,HIGH(2000)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0xF:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_password)
	LDI  R31,HIGH(_password)
	ST   -Y,R31
	ST   -Y,R30
	CALL _strcmp
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x10:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
	RJMP SUBOPT_0xB

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x11:
	SET
	BLD  R15,0
	CBI  0xB,5
	RJMP SUBOPT_0xB

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x13:
	ST   -Y,R18
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x14:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x15:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x16:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x17:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x18:
	ST   -Y,R30
	CALL __lcd_write_data
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RJMP SUBOPT_0x12

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x19:
	LDI  R30,LOW(48)
	ST   -Y,R30
	CALL __lcd_write_nibble_G102
	__DELAY_USW 276
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xACD
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

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

;END OF CODE MARKER
__END_OF_CODE:
