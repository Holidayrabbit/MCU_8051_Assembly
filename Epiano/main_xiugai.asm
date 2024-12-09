;------------------------------------
;-  Generated Initialization File  --
;------------------------------------

$include (C8051F020.inc)


RS bit P2.0
RW bit P2.1
E bit P2.2	
BUZ BIT P2.3

MODE EQU 29H

STH0 EQU 31H             ;STH0 ����Ϊ,31H
STL0 EQU 32H             ;STL0 ����Ϊ,32H	
STH1 EQU 33H            
STL1 EQU 34H
COUNT_T1 EQU 35H        //T1��������
TEMP EQU 36H             ;TEMP ����Ϊ,36H
KeyVal_Address	EQU 7AH
KeyVal_Address1	EQU 7BH
KeyVal_Address2	EQU 7CH

DELAY_FLAG BIT 11H
NEXT BIT 10H       ;�����־λ,���Ŀ�ʼʱ��Ϊ1������ʱ��Ϊ0
INT_FLAG BIT 09H


/*******************************************************************************************************************/
//������
/*******************************************************************************************************************/

	
ORG 0000H
    LJMP MAIN
	
ORG 0003H
	LJMP EXINT0
	
ORG 000BH
	LJMP T0_Process	
	
ORG 0013H
	LJMP EXINT1
	
ORG 001BH
	LJMP T1_Process	
	
ORG 0100H                                          ;�����ַ


;INT0_HOME:

;		CLR INT_FLAG
;	    MOV MODE,#0
;		AJMP MAIN1



MAIN:
	LCALL Init_Device
	
MAIN1:	
	LCALL LCD_DISP_MENU	
		
		
		
;MAIN_LOOP:
;	MOV DPTR, #ENTRY ; ��ָ�����ڵ�ַ
;	MOV A, R3		 ; ����ƫ����

;NEXT:		
;	JMP @A+DPTR	; ɢת
;ENTRY:         
;	LJMP MENU	; ת��ָ���: 3 �ֽ�
;	LJMP PIANO
;	LJMP PLAYER		
		
		
		
		
		
MAIN_LOOP:

;	MOV R7,#0
	
;	LCALL LCD_DISP_MENU
	
	LCALL KEY_SCAN1
	
	MOV A, KeyVal_Address1
   
			CJNE A,#0,PANDUAN1          ;���ݶ����ж�A�ļ�ֵ         ;
			AJMP MODE1         ;K1������
			
PANDUAN1:        
			CJNE A,#1,PANDUAN2          ; K2������
            AJMP MODE2          ;
		   
PANDUAN2:       
			NOP                    ;û�м�����
			LJMP MAIN_LOOP
		
MODE1:
		SETB INT_FLAG
		LCALL LCD_DISP_PIANO
		LJMP PIANO_LOOP
	

MODE2:
		SETB INT_FLAG
		LCALL LCD_DISP_CHOOSE
		LJMP PLAYER_LOOP
	




/*******************************************************************************************************************/
//LCD
/*******************************************************************************************************************/

LCD_INIT:
    
	CLR RS
	CLR RW
	CLR E
	MOV P1,#01H;�����Ļ

	ACALL ENABLE
	MOV P1,#38H;8λ����ʽ
	ACALL ENABLE1
	
	ACALL ENABLE
	MOV P1,#0CH;����ʾ
	ACALL ENABLE1
	
	ACALL ENABLE
	MOV P1,#06H;�ƶ����
	ACALL ENABLE1
	
	ACALL ENABLE
	MOV P1,#01H;��긴λ
	ACALL ENABLE1
	
	RET




;LCD_DISP_TEST:	

;	LCALL LCD_INIT
;	
;	MOV DPTR,#LCD_TAB1;�����ݱ�3
;	LCALL WRITE1
;	
;	LCALL ENABLE
;	MOV P1,#0C0H;�ƶ����λ�õ��ڶ���
;	LCALL ENABLE1
;	
;	MOV DPTR,#LCD_TAB2
;	LCALL WRITE1
;	
;	RET

LCD_DISP_MENU:	

	LCALL LCD_INIT
	
	MOV DPTR,#LCD_TAB3;�����ݱ�3
	LCALL WRITE1
	
	LCALL ENABLE
	MOV P1,#0C0H;�ƶ����λ�õ��ڶ���
	LCALL ENABLE1
	
	MOV DPTR,#LCD_TAB4
	LCALL WRITE1
	
	RET
	
LCD_DISP_PIANO:	

	LCALL LCD_INIT
	
	MOV DPTR,#LCD_TAB5;
	LCALL WRITE1
	
	RET
	
LCD_DISP_SONG01:	

	LCALL LCD_INIT
	
	MOV DPTR,#LCD_TAB01;
	LCALL WRITE1
	
	RET
LCD_DISP_SONG02:	

	LCALL LCD_INIT
	
	MOV DPTR,#LCD_TAB02;
	LCALL WRITE1
	
	RET
	
LCD_DISP_SONG03:	

	LCALL LCD_INIT
	
	MOV DPTR,#LCD_TAB03;
	LCALL WRITE1
	
	RET
	
LCD_DISP_CHOOSE:	

	LCALL LCD_INIT
	
	MOV DPTR,#LCD_TAB6;
	LCALL WRITE1
	
	RET
ENABLE:
	   CLR RS
	   CLR RW
	   RET
ENABLE1:
	   SETB E
	   ACALL DELAY
;	NOP
;	NOP
;	NOP
;	NOP
;	NOP
	   CLR E
	   ACALL DELAY
;	NOP
;	NOP
;	NOP
;	NOP
;	NOP
	   RET
	   
WRITE1: ;д����
    MOV R1,#00h
A1:
    MOV A,R1
    MOVC A,@A+DPTR
    ACALL WRITE2
    INC R1
    CJNE A,#20h,A1
    RET
	
WRITE2:
	SETB RS
    CLR RW
    MOV P1,A
	SETB E
	ACALL DELAY

;	NOP
;	NOP
;	NOP
;	NOP
;	NOP
	
    CLR E
    ACALL DELAY

; 	NOP
;	NOP
;	NOP
;	NOP
;	NOP

    RET

DELAY:          ;0.7MS��ʱ
	    MOV  R2, #255	
LOOP2: 	

		NOP
		NOP			
		NOP
		DJNZ  R2, LOOP2 
		RET
  
;LCD_TAB1: DB 46H,72H,65H,71H,75H,65H,6EH,63H,79H,3AH,31H,30H,30H,48H,7AH,00H;	Frequency:100Hz
;LCD_TAB2: DB 41h,6dh,70h,6ch,69h,74h,75H,64H,65H,3Ah,20H,35H,56H,00H;			Amplitude: 5V
LCD_TAB3: DB 4BH,4BH,31H,3AH,50H,69H,61H,6EH,6FH,20H ,20H ,20H ,20H,20H,20H,20H,20H    ;	K1:Piano
LCD_TAB4: DB 4BH,32H,3AH,4DH,75H,73H,69H,63H,5FH,50H,6CH,61H,79H,65H,72H,20H     ;			K2:Music_Player
LCD_TAB5: DB 50H,50H,69H,61H,6EH,6FH,20H ,20H ,20H ,20H,20H,20H,20H,20H,20H ,20H      ;			Piano
LCD_TAB6: DB 43H,43H,68H,6FH,6FH,73H,65H,5FH,33H,5FH,34H,5FH,35H,20H ,20H ,20H     ;       Choose_3_4_5


LCD_TAB01: DB 54H,54H,77H,6FH,5FH,54H,69H,67H,65H,72H,73H,20H ,20H ,20H ,20H,20H     ;			/Two_Tigers
LCD_TAB02: DB 4FH,4FH,6EH,6CH,79H,5FH,4DH,6FH,6DH,20H ,20H ,20H ,20H,20H,20H,20H     ;			/Only_Mom
LCD_TAB03: DB 48H,48H,75H,4DH,75H,4DH,77H,51H,20H ,20H ,20H ,20H,20H,20H,20H,20H     ;			/Huluwa

/*******************************************************************************************************************/
//������̼��
/*******************************************************************************************************************/	





KEY_SCAN:

		MOV 7AH, #98      //û�м�����ʱ����98
		NOP
		MOV P5, #00000000B
		MOV P4, #00111111B
		MOV A, P4
		CJNE A, #00111111B, HKVAL	;ȷ���м����£������ж�
		LJMP PIANO_LOOP
		
HKVAL:	MOV A, #00111111B
		MOV P4,A
		MOV A, #00000000B
		MOV P5,A
		NOP
		MOV A, P4			;��֤��
		ANL A, #00111111B
		JNB ACC.0, H1		;��һ�У�����0����ת
		JNB ACC.1, H2
		JNB ACC.2, H3
		JNB ACC.3, H4
		JNB ACC.4, H5
		JNB ACC.5, H6		
		SJMP HKVAL
		
H1:		MOV B, #0    //���水��������
		SJMP LKVAL
H2:		MOV B, #1
		SJMP LKVAL	
H3:		MOV B, #2
		SJMP LKVAL
H4:		MOV B, #3
		SJMP LKVAL
H5:		MOV B, #4
		SJMP LKVAL
H6:		MOV B, #5
		SJMP LKVAL		


LKVAL:	MOV A, #11000000B	;��֤��
		MOV P4, A
		MOV A, #11111111B	;��֤��
		MOV P5, A
		NOP
		MOV A, P4
		ANL A, #11000000B
		JNB ACC.6, L1		;��һ��
		JNB ACC.7, L2		;�ڶ��� 
		MOV A, P5
		ANL A, #11111111B
		JNB ACC.0, L3		;������
		JNB ACC.1, L4		;������ 
		JNB ACC.2, L5		;������
		JNB ACC.3, L6		;������


		
		SJMP LKVAL
		
L1:		MOV R4, #0
		SJMP SKVAL
L2:		MOV R4, #1
		SJMP SKVAL
L3:		MOV R4, #2
		SJMP SKVAL
L4:		MOV R4, #3
		SJMP SKVAL
L5:		MOV R4, #4
		SJMP SKVAL
L6:		MOV R4, #5
		SJMP SKVAL
		
SKVAL:	MOV A, #6
		MUL AB
		ADD A, R4 ;�����Ӧ���ƫ����
		MOV 7AH, A                   ;7AH��ʱ���A�ж���
		
		RET




KEY_SCAN1:

		MOV 7BH, #98      //û�м�����ʱ����98
		NOP
		MOV P5, #00000000B
		MOV P4, #00111111B
		MOV A, P4
		CJNE A, #00111111B, HKVAL1	;ȷ���м����£������ж�
		LJMP MAIN_LOOP
		
HKVAL1:	MOV A, #00111111B
		MOV P4,A
		MOV A, #00000000B
		MOV P5,A
		NOP
		MOV A, P4			;��֤��
		ANL A, #00111111B
		JNB ACC.0, H11		;��һ�У�����0����ת
		JNB ACC.1, H21
		JNB ACC.2, H31
		JNB ACC.3, H41
		JNB ACC.4, H51
		JNB ACC.5, H61		
		SJMP HKVAL1
		
H11:		MOV B, #0    //���水��������
		SJMP LKVAL1
H21:		MOV B, #1
		SJMP LKVAL1	
H31:		MOV B, #2
		SJMP LKVAL1
H41:		MOV B, #3
		SJMP LKVAL1
H51:		MOV B, #4
		SJMP LKVAL1
H61:		MOV B, #5
		SJMP LKVAL1		


LKVAL1:	MOV A, #11000000B	;��֤��
		MOV P4, A
		MOV A, #11111111B	;��֤��
		MOV P5, A
		NOP
		MOV A, P4
		ANL A, #11000000B
		JNB ACC.6, L11		;��һ��
		JNB ACC.7, L21		;�ڶ��� 
		MOV A, P5
		ANL A, #11111111B
		JNB ACC.0, L31		;������
		JNB ACC.1, L41		;������ 
		JNB ACC.2, L51		;������
		JNB ACC.3, L61		;������


		
		SJMP LKVAL1
		
L11:		MOV R4, #0
		SJMP SKVAL1
L21:		MOV R4, #1
		SJMP SKVAL1
L31:		MOV R4, #2
		SJMP SKVAL1
L41:		MOV R4, #3
		SJMP SKVAL1
L51:		MOV R4, #4
		SJMP SKVAL1
L61:		MOV R4, #5
		SJMP SKVAL1
		
SKVAL1:	MOV A, #6
		MUL AB
		ADD A, R4 ;�����Ӧ���ƫ����
		MOV 7BH, A                   ;7AH��ʱ���A�ж���
		
		RET

KEY_SCAN2:

		MOV 7CH, #98      //û�м�����ʱ����98
		NOP
		MOV P5, #00000000B
		MOV P4, #00111111B
		MOV A, P4
		CJNE A, #00111111B, HKVAL11	;ȷ���м����£������ж�
		LJMP PLAYER_LOOP
		
HKVAL11:	MOV A, #00111111B
		MOV P4,A
		MOV A, #00000000B
		MOV P5,A
		NOP
		MOV A, P4			;��֤��
		ANL A, #00111111B
		JNB ACC.0, H111		;��һ�У�����0����ת
		JNB ACC.1, H211
		JNB ACC.2, H311
		JNB ACC.3, H411
		JNB ACC.4, H511
		JNB ACC.5, H611		
		SJMP HKVAL11
		
H111:		MOV B, #0    //���水��������
		SJMP LKVAL11
H211:		MOV B, #1
		SJMP LKVAL11
H311:		MOV B, #2
		SJMP LKVAL11
H411:		MOV B, #3
		SJMP LKVAL11
H511:		MOV B, #4
		SJMP LKVAL11
H611:		MOV B, #5
		SJMP LKVAL11		


LKVAL11:	MOV A, #11000000B	;��֤��
		MOV P4, A
		MOV A, #11111111B	;��֤��
		MOV P5, A
		NOP
		MOV A, P4
		ANL A, #11000000B
		JNB ACC.6, L111		;��һ��
		JNB ACC.7, L211	;�ڶ��� 
		MOV A, P5
		ANL A, #11111111B
		JNB ACC.0, L311		;������
		JNB ACC.1, L411		;������ 
		JNB ACC.2, L511		;������
		JNB ACC.3, L611		;������


		
		SJMP LKVAL11
		
L111:		MOV R7, #0
		SJMP SKVAL11
L211:		MOV R7, #1
		SJMP SKVAL11
L311:		MOV R7, #2
		SJMP SKVAL11
L411:		MOV R7, #3
		SJMP SKVAL11
L511:		MOV R7, #4
		SJMP SKVAL11
L611:		MOV R7, #5
		SJMP SKVAL11
		
SKVAL11:	MOV A, #6
		MUL AB
		ADD A, R7 ;�����Ӧ���ƫ����
		MOV 7CH, A                   ;7AH��ʱ���A�ж���
		
		RET




/*******************************************************************************************************************/
//�жϷ������
/*******************************************************************************************************************/


		
		
EXINT0:
		CLR INT_FLAG
;			JB BUZ,MAKE_EA//����1��ת
;		CPL BUZ
;MAKE_EA:		CPL EA	

		RETI


T0_Process:	

		MOV TH0,STH0          ; T0�жϷ������
        MOV TL0,STL0          ;
        CPL P2.3          ; �������
        RETI          ;

EXINT1:	
		JB BUZ,MAKE_EA//����1��ת
		CPL BUZ
MAKE_EA:		CPL ET0
		
INT1_BACK:		RETI


T1_Process:	

	PUSH ACC
	MOV A,COUNT_T1
	CJNE A,#0,T0L2
	   CLR TR0
       CLR TR1
	   CLR DELAY_FLAG
       CLR NEXT
       LJMP T0L3	   		
T0L2:		
		DEC A
		MOV COUNT_T1,A
		MOV TH1,STH1          ;
        MOV TL1,STL1          ;	
T0L3:   
		POP ACC
		RETI

/*******************************************************************************************************************/
//���������
/*******************************************************************************************************************/




TUICHU1:

RET




PIANO_LOOP:
	
	JNB INT_FLAG,TUICHU1  //����0����INT0_HOME




	MOV 7AH, #98
	LCALL KEY_SCAN
	MOV A, 7AH		   
			   
			CJNE A,#0,NK1          ;���ݶ����ж�A�ļ�ֵ         ;
			LJMP Start_Piano         ;K1������
NK1:       CJNE A,#1,NK2          ; K2������
           LJMP Start_Piano          ;
NK2:       CJNE A,#2,NK3          ;K3������         
           LJMP Start_Piano         ;
NK3:       CJNE A,#3,NK4          ;K4������         ;
           LJMP Start_Piano
NK4:       CJNE A,#4,NK5          ; K5������
           LJMP Start_Piano          ;
NK5:       CJNE A,#5,NK6          ;K6������         
           LJMP Start_Piano         ;
NK6:       CJNE A,#6,NK7         ;K7������         ;
           LJMP Start_Piano
NK7:       CJNE A,#7,NK8          ; K8������
           LJMP Start_Piano          ;
NK8:       CJNE A,#8,NK9          ;K9������         
           LJMP Start_Piano         ;
NK9:       CJNE A,#9,NK10          ;K10������         ;
           LJMP Start_Piano
NK10:       CJNE A,#10,NK11          ; K11������
           LJMP Start_Piano          ;
NK11:       CJNE A,#11,NK12         ;K12������         
           LJMP Start_Piano         ;
NK12:       CJNE A,#12,NK13         ;K13������         ;
           LJMP Start_Piano
NK13:       CJNE A,#13,NK14          ; K14������
           LJMP Start_Piano          ;
NK14:       CJNE A,#14,NK15          ;K15������         
           LJMP Start_Piano         ;
NK15:       CJNE A,#15,NK16          ;K16������         ;
           LJMP Start_Piano
NK16:       CJNE A,#16,NK17          ; K17������
           LJMP Start_Piano          ;
NK17:       CJNE A,#17,NK18          ;K18������         
           LJMP Start_Piano         ;
NK18:       CJNE A,#18,NK19          ;K19������         ;
           LJMP Start_Piano
NK19:       CJNE A,#19,NK20          ; K20������
           LJMP Start_Piano          ;
NK20:       CJNE A,#20,NK21          ;K21������         
           LJMP Start_Piano         ;
NK21:       CJNE A,#21,NK22          ;K22������         ;
           LJMP Start_Piano
NK22:       CJNE A,#22,NK23          ; K23������
           LJMP Start_Piano          ;
NK23:       CJNE A,#23,NK24          ;K24������         
           LJMP Start_Piano         ;
NK24:       CJNE A,#24,NK25          ;K25������         ;
           LJMP Start_Piano
NK25:       CJNE A,#25,NK26          ; K26������
           LJMP Start_Piano          ;
NK26:       CJNE A,#26,NK27          ;K27������         
           LJMP Start_Piano         ;
NK27:       CJNE A,#27,NK28          ;K28������         ;
           LJMP Start_Piano
NK28:       CJNE A,#28,NK29          ;K29������         
           LJMP Start_Piano         ;
NK29:       CJNE A,#29,NK30          ;K30������         ;
           LJMP Start_Piano
NK30:       CJNE A,#30,NK31          ; K31������
           LJMP Start_Piano          ;
NK31:       CJNE A,#31,NK32          ;K32������         
           LJMP Start_Piano         ;
NK32:       CJNE A,#32,NK33          ;K33������         ;
           LJMP Start_Piano
NK33:       CJNE A,#33,NK34          ; K34������
           LJMP Start_Piano          ;
NK34:       CJNE A,#34,NK35          ;K35������         
           LJMP Start_Piano         ;
NK35:       CJNE A,#35,NK36          ;K36������         ;
           LJMP MAIN


NK36:       NOP                    ;û�м�����

		LJMP PIANO_LOOP
		
		
Start_Piano:       
			MOV A,KeyVal_Address
           MOV B,#2
			MUL AB          ;��Ϊ����ﶼ���֣����Գ�2�Ĳ������
           MOV TEMP,A          ;
           MOV DPTR,#TABLE          ;  ָ���ͷ
           MOVC A,@A+DPTR          ; ���
           MOV STH0,A          ;
           MOV TH0,A          ;  �����ݸ�λ��TH0
           INC TEMP          ;
           MOV A,TEMP          ;
           MOVC A,@A+DPTR          ;
           MOV STL0,A          ;
           MOV TL0,A          ;�����ݵ�λ��TH0
           SETB TR0          ; ������ʱ��T0
		   
Stop_Piano:      
		MOV P5, #00000000B;���ּ��
		MOV P4, #00111111B
		MOV A, P4
		CJNE A, #00111111B,Stop_Piano
        CLR TR0          ;�رն�ʱ��T0
		SETB BUZ
		
		LJMP PIANO_LOOP
		   
TABLE:     DW 61719,61926,62135,62321,62506,62671          
           DW 62833,62985,63126,63263,63390,63512          
           DW 63624,63731,63832,63928,64019,64103          
           DW 64185,64260,64333,64400,64463,64524
		   DW 64580,64634,64685,64733,64777,64820          
           DW 64860,64898,64934,64968,65000,65030


/*******************************************************************************************************************/
//���ֲ�����
/*******************************************************************************************************************/

PLAYER_LOOP:

		

			
      MOV TH0,31H
      MOV TL0,32H
	  	  
	  MOV STH1,#0DFH
	  MOV STL1,#73H
	  
      MOV R4,#00H
	  
	  LCALL KEY_SCAN2
	  
	  	MOV A, KeyVal_Address2
   
			CJNE A,#3,PANDUAN11          ;���ݶ����ж�A�ļ�ֵ         ;
			LCALL LCD_DISP_SONG01
			LJMP SONG01         ;K1������
			
PANDUAN11:        
			CJNE A,#4,PANDUAN21          ; K2������
			LCALL LCD_DISP_SONG02

            LJMP SONG02          ;
		   
PANDUAN21:   
			CJNE A,#5,PANDUAN31          ; K2������
			LCALL LCD_DISP_SONG03

            LJMP SONG03          ;

PANDUAN31:
			NOP                    ;û�м�����
			LJMP PLAYER_LOOP
	  
	  
	  
SONG01:
      MOV DPTR,#TAB01
	  
YD1: 


JNB INT_FLAG,TUICHU01  //����0����INT0_HOME
		

		JNB ET0,$
		
		MOV A,R4            ;ȡ�������ݣ�R4�����Ǳ��еڼ���Ԫ��
      MOVC A,@A+DPTR
      MOV STH0,A             //�����ĸ߰�λ������R2
;      XRL A,#00H
;      JNZ JP              ;ֱ��ȡ����,��A��Ϊ0ʱ��ת
      INC R4
      LCALL PD1             ;�ж�ָ���Ƿ����
      MOV A,R4
      MOVC A,@A+DPTR
      MOV STL0,A            //�����ĵͰ�λ������R3
      XRL A,#0FFH         
      JNZ JP1
      MOV A,STH0
      XRL A,#0FFH
	  		
	  LJMP 	MAIN_LOOP

TUICHU01:
RET

	  
JP1:   INC R4               ;ȡ��������
      LCALL PD1
      MOV A,R4
      MOVC A,@A+DPTR
      MOV COUNT_T1,A              ;���Ĵ���COUNT_T1��
      SETB EA
      SETB ET0
      SETB ET1
      SETB TR0
      SETB TR1
      SETB NEXT

      JB NEXT,$
      INC R4
      LCALL PD1
      LJMP YD1
PD1:   MOV A,R4
      CJNE A,#00H,T1L1
      INC DPH
	  
T1L1:   RET

////////////////////////////////////////////////////////////////////////////////////////

SONG02:
      MOV DPTR,#TAB02
	  
YD2: 




JNB INT_FLAG,TUICHU02  //����0����INT0_HOMETUICHU01:






		JNB ET0,$

		MOV A,R4            ;ȡ�������ݣ�R4�����Ǳ��еڼ���Ԫ��
      MOVC A,@A+DPTR
      MOV STH0,A             //�����ĸ߰�λ������R2
;      XRL A,#00H
;      JNZ JP              ;ֱ��ȡ����,��A��Ϊ0ʱ��ת
      INC R4
      LCALL PD2             ;�ж�ָ���Ƿ����
      MOV A,R4
      MOVC A,@A+DPTR
      MOV STL0,A            //�����ĵͰ�λ������R3
      XRL A,#0FFH         
      JNZ JP2
      MOV A,STH0
      XRL A,#0FFH
      JNZ SONG02    //A��Ϊ0��ת
	
	  LJMP 	MAIN_LOOP	


TUICHU02:

RET



	  
JP2:   INC R4               ;ȡ��������
      LCALL PD2
      MOV A,R4
      MOVC A,@A+DPTR
      MOV COUNT_T1,A              ;���Ĵ���COUNT_T1��
      SETB EA
      SETB ET0
      SETB ET1
      SETB TR0
      SETB TR1
      SETB NEXT 
      JB NEXT,$
      INC R4
      LCALL PD2
      LJMP YD2
PD2:   MOV A,R4
      CJNE A,#00H,T1L1
      INC DPH
	  
T1L2:   RET

///////////////////////////////////////////////////////////////////////////////////////////////////

SONG03:
      MOV DPTR,#TAB03
	  
YD3:   


JNB INT_FLAG,TUICHU03  //����0����INT0_HOMETUICHU01:


		JNB ET0,$

		MOV A,R4            ;ȡ�������ݣ�R4�����Ǳ��еڼ���Ԫ��
      MOVC A,@A+DPTR
      MOV STH0,A             //�����ĸ߰�λ������R2
;      XRL A,#00H
;      JNZ JP              ;ֱ��ȡ����,��A��Ϊ0ʱ��ת
      INC R4
      LCALL PD3             ;�ж�ָ���Ƿ����
      MOV A,R4
      MOVC A,@A+DPTR
      MOV STL0,A            //�����ĵͰ�λ������R3
      XRL A,#0FFH         
      JNZ JP3
      MOV A,STH0
      XRL A,#0FFH
      JNZ SONG03
	
	  LJMP 	MAIN_LOOP

TUICHU03:

RET
;	  
	  
JP3:   INC R4               ;ȡ��������
      LCALL PD3
      MOV A,R4
      MOVC A,@A+DPTR
      MOV COUNT_T1,A              ;���Ĵ���COUNT_T1��
      SETB EA
      SETB ET0
      SETB ET1
      SETB TR0
      SETB TR1
      SETB NEXT 
      JB NEXT,$
      INC R4
      LCALL PD3
      LJMP YD3
PD3:   MOV A,R4
      CJNE A,#00H,T1L3
      INC DPH
	  
T1L3:   RET
      

;;���Ĳ����ӳ���
;BEAT: 
;		CJNE R5,#0,L2
;	   CLR TR0
;       CLR TR1
;       CLR NEXT
;       LJMP L3
;	   		
;L2:		
;		DEC R5
;		MOV TH1,#0DFH
;        MOV TL1,#73H	
;L3:   RETI


NOTE_TABLE: 
DW 63624,63832,64019,64103,64260,64400,64524//��DO,��RE,��M,��FA,��SO,��LA,��SI


;    0F8H,088H   //1
;	0F9H,058H   //2
;	0FAH,013H   //3
;	0FAH,67H    //4
;	0FBH,04H    //5
;	0FBH,90H    //6
;	0FCH,0CH    //7



;��ֻ�ϻ������� 
TAB01: 


	DB 0F8H,088H,08H,0F9H,058H,08H,0FAH,013H,08H,0F8H,088H,08H        //12
     DB 0F8H,088H,08H,0F9H,058H,08H,0FAH,013H,08H,0F8H,088H,08H         //12
     DB 0FAH,013H,08H,0FAH,67H,08H,0FBH,04H,10H,      0FAH,013H,08H     //12
     DB 0FAH,67H,08H,0FBH,04H,10H,        0FBH,04H,04H,0FBH,90H,04H      //12
     DB 0FBH,04H,04H,0FAH,67H,04H,0FAH,013H,08H,0F8H,088H,08H    //12 		  
     DB 0FBH,04H,04H,0FBH,90H,04H,0FBH,04H,04H,0FAH,67H,04H            //12
     DB 0FAH,013H,08H,0F8H,088H,08H,        0F8H,088H,08H,0FBH,04H,08H   //12
     DB 0F8H,088H,10H, 0F8H,088H,08H,0FBH,04H,08H, 0F8H,088H,10H  //11
     DB 0FFH,0FFH,04H      //NEXT BIT 10H       ;�����־λ,���Ŀ�ʼʱ��Ϊ1������ʱ��Ϊ0





;����ֻ������������� 		
TAB02:
	DB 0FBH,90H,0CH,0FBH,04H,04H,0FAH,013H,08H,0FBH,04H,08H
	DB 0F8H,088H,08H,0FBH,90H,04H,0FBH,04H,04H,0FBH,90H,10H
	DB 0FAH,013H,08H,0FBH,04H,04H,0FBH,90H,04H,0FBH,04H,08H,0FAH,013H,08H
	DB 0F8H,088H,04H,0FBH,90H,04H,0FBH,04H,04H,0FAH,013H,04H,0F9H,058H,10H
	DB 0F9H,058H,0CH,0FAH,013H,04H,0FBH,04H,08H,0FBH,04H,04H,0FBH,90H,04H
	DB 0FAH,013H,08H,0F9H,058H,08H,0F8H,088H,10H
	DB 0FBH,04H,0CH,0FAH,013H,04H,0F9H,058H,04H,0F8H,088H,04H,0FBH,90H,04H,0F8H,088H,04H
	DB 0FBH,04H,20H
	DB 0FFH,0FFH
		


;��«��������
TAB03:
	DB 0F8H,088H,08H,0F8H,088H,08H,0FAH,013H,10H
	DB 0F8H,088H,04H,0F8H,088H,08H,0FAH,013H,04H,0F8H,088H,10H
	DB 0FBH,90H,08H,0FBH,90H,08H,0FBH,90H,04H,0FBH,04H,04H,0FBH,90H,08H
	DB 0FBH,04H,04H,0F8H,088H,08H,0FAH,013H,0CH,0F8H,088,08H
	DB 0F8H,088H,04H,0FBH,90H,04H,0FBH,90H,04H,0FBH,04H,04H,0FBH,90H,10H
	DB 0FBH,04H,04H,0F8H,088H,08H,0F9H,058H,0CH,0FCH,0CH,08H
	DB 0FCH,0CH,10H,0FBH,04H,08H,0FAH,013H,08H
	DB 0FBH,04H,20H
	DB 0FFH,0FFH




;    0F8H,088H   //1
;	0F9H,058H   //2
;	0FAH,013H   //3
;	0FAH,67H    //4
;	0FBH,04H    //5
;	0FBH,90H    //6
;	0FCH,0CH    //7





/*******************************************************************************************************************/
//��ʼ������
/*******************************************************************************************************************/





; Peripheral specific initialization functions,
; Called from the Init_Device label
Reset_Sources_Init:
    mov  WDTCN,     #0DEh
    mov  WDTCN,     #0ADh
    ret

Timer_Init:
    mov  CKCON,     #008h
    mov  TCON,      #005h
    mov  TMOD,      #011h
    mov  TL1,       #073h
    mov  TH1,       #0DFh
    ret

Port_IO_Init:
    ; P0.0  -  Unassigned,  Push-Pull,  Digital
    ; P0.1  -  Unassigned,  Push-Pull,  Digital
    ; P0.2  -  Unassigned,  Push-Pull,  Digital
    ; P0.3  -  Unassigned,  Push-Pull,  Digital
    ; P0.4  -  Unassigned,  Push-Pull,  Digital
    ; P0.5  -  Unassigned,  Push-Pull,  Digital
    ; P0.6  -  Unassigned,  Push-Pull,  Digital
    ; P0.7  -  Unassigned,  Push-Pull,  Digital

    ; P1.0  -  Unassigned,  Push-Pull,  Digital
    ; P1.1  -  Unassigned,  Push-Pull,  Digital
    ; P1.2  -  Unassigned,  Push-Pull,  Digital
    ; P1.3  -  Unassigned,  Push-Pull,  Digital
    ; P1.4  -  Unassigned,  Push-Pull,  Digital
    ; P1.5  -  Unassigned,  Push-Pull,  Digital
    ; P1.6  -  Unassigned,  Push-Pull,  Digital
    ; P1.7  -  Unassigned,  Push-Pull,  Digital

    ; P2.0  -  Unassigned,  Push-Pull,  Digital
    ; P2.1  -  Unassigned,  Push-Pull,  Digital
    ; P2.2  -  Unassigned,  Push-Pull,  Digital
    ; P2.3  -  Unassigned,  Push-Pull,  Digital
    ; P2.4  -  Unassigned,  Push-Pull,  Digital
    ; P2.5  -  Unassigned,  Push-Pull,  Digital
    ; P2.6  -  Unassigned,  Push-Pull,  Digital
    ; P2.7  -  Unassigned,  Push-Pull,  Digital

    ; P3.0  -  Unassigned,  Push-Pull,  Digital
    ; P3.1  -  Unassigned,  Push-Pull,  Digital
    ; P3.2  -  Unassigned,  Push-Pull,  Digital
    ; P3.3  -  Unassigned,  Push-Pull,  Digital
    ; P3.4  -  Unassigned,  Push-Pull,  Digital
    ; P3.5  -  Unassigned,  Push-Pull,  Digital
    ; P3.6  -  Unassigned,  Push-Pull,  Digital
    ; P3.7  -  Unassigned,  Push-Pull,  Digital

    mov  P0MDOUT,   #0FFh
    mov  P1MDOUT,   #0FFh
    mov  P2MDOUT,   #0FFh
    mov  P3MDOUT,   #0FFh
    mov  P74OUT,    #0FFh
    mov  XBR1,      #014h
    mov  XBR2,      #040h
    ret

Interrupts_Init:
    mov  IE,        #08Fh
    ret

; Initialization function for device,
; Call Init_Device from your main program
Init_Device:
    lcall Reset_Sources_Init
    lcall Timer_Init
    lcall Port_IO_Init
    lcall Interrupts_Init
    ret

END