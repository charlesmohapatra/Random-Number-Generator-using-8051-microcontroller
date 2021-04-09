RS EQU P2.0
RW EQU P2.1
E  EQU P2.2
ORG 00H ;
LJMP INIT ;
ORG 0013H ;
LCALL ISR ;
RETI ;



INIT: 
SETB TCON.2 ;
MOV IE,#10000100B ;
MOV A,#14H ;
LCALL DELAY ;
MOV A,#38H ;
LCALL CMD ;
MOV A,#0CH ;
LCALL CMD ;
MOV A,#06H ;
LCALL CMD ;
MOV A,#01H ;
LCALL CMD ;
MOV A,#80H ;
LCALL CMD ;
MOV A,#0C0H ;
LCALL CMD ;






;MOV R2,#02H ;
;SHOW: 
;MOV A,R2 ;
;ADD A,#30H ;
;LCALL DISP ;
;MOV A,#0FFH ;
;LCALL DELAY ;
;DJNZ R2,SHOW;

INITSEED:MOV B,#255D ;
GETSEED:
DJNZ B,GETSEED ;
SJMP INITSEED ;




;while1: SJMP while1 ;


ISR: 

MOV A,#01H ;
LCALL CMD ;
MOV A,#0C0H ;
LCALL CMD ;



GETDIGIT: 
      

MOV A,B ;

MOV B,#0AH ;
DIV AB ;
MOV R3,B ;


MOV B,#0AH ;
DIV AB ;
MOV R4,B ;

ADD A,#30H ;
LCALL DISP ;
MOV A,#0FFH ;
LCALL DELAY ;

MOV A,B ;
ADD A,#30H ;
LCALL DISP ;
MOV A,#0FFH ;
LCALL DELAY ;

MOV A,R3 ;
ADD A,#30H ;
LCALL DISP ;
MOV A,#0FFH ;
LCALL DELAY ;

RET ; isr ret




CMD:
MOV P0,A ;
CLR RS ;
CLR RW ;
SETB E ;
MOV A,#01H ;
LCALL DELAY ;
CLR E ;
MOV A,#05H ;
LCALL DELAY ;
RET ;

DISP:
MOV P0,A ;
SETB RS ;
CLR RW ;
SETB E ;
MOV A,#01 ;
LCALL DELAY ;
CLR E ;
MOV A,#05H ;
LCALL DELAY ;
RET ;








DELAY : 

MOV R1,A ;
L1: 
MOV R0,#70H ;
JDEL: DJNZ R0, JDEL ;
DJNZ R1, L1 ;
RET


EXIT:
END ;