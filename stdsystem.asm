include 'emu8086.inc'

.MODEL LARGE
.STACK 1000H
.DATA
    N   DW      ?                                                              
    Grade DB 1000 DUP (?)           ;1000 IS THE MAXIMYM NUMBER OF STUDENTS
    ID    DB  1000 DUP (?) 
    
nl DB 10,13,10,13,'$'
M1 DB 10,13,10,13,'                 ****Welcome to Our Students System****$',10,13 
M2 DB 10,13,'  **                 1.Menna Adel Alyamani                              **$' 
M3 DB 10,13,'  **                 2.Menna Ayman Aziza                                **$' 
M4 DB 10,13,'  **                 2.Ahmed Elmorsi                                    **$' 
MR5 DB 10,13,'  ************************************************************************$' 
MR6 DB 10,13,'  **                                                                    **$'  
M5 DB 10,13,10,13,'                 ****Press any button to start****$',10,13 

M6 DB 10,13,10,13,'                ***Choose the mode you want***$'
M7 DB 10,13,'  **           1.Add student record                               **$' 
M8 DB 10,13,'  **           3.View student record                              **$'
M9 DB 10,13,'  **           4.View all records                                 **$'
M11 DB 10,13,'  **          6.Exit                                             **$'
 

MSG1    DB 09H,09H,'  Enter the number of students :: ',0                                   ;0 INDICATES THAT THE MESSAGE ENDS HERE
MSG2    DB 10,13,10,13,09H,09H,'  Enter the IDs of students :: ',0                                       ;0Dh,0Ah, 0Dh,0Ah MEANS NEW LINE AND RETURN CURSOR TO ITS BEGINNING ACCORDING TO ASCI CODES 
MSG3    DB 10,13,10,13,09H,09H,'  Enter the Grades of students :: ',0 
HR      DB 10,13,10,13,'  ****************************Sorted Marks********************************',0            ;HORIZONTAL ROW  
MSG4    DB 10,13,10,13,09H,09H,09H,09H,'ID: ',09H,'GRADE:',0  

                               


.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
   TOP:
            ;DEFINING FUNCTIONS FOR THE LIBRARY EMU8086 WHICH WILL BE USED LATER
            DEFINE_SCAN_NUM           
            DEFINE_PRINT_STRING 
            DEFINE_PRINT_NUM
            DEFINE_PRINT_NUM_UNS
        
    LEA DX,M1
    MOV AH,9
    INT 21H
    
    LEA DX,nl ;NEWLINE
    MOV AH,9
    INT 21H 
    
    LEA DX,nl ;NEWLINE
    MOV AH,9
    INT 21H  
    
    LEA DX,MR5       ;stars line
    MOV AH,9
    INT 21H 
    
    LEA DX,MR6       ;stars line
    MOV AH,9
    INT 21H 
     
    LEA DX,M2
    MOV AH,9
    INT 21H
    
     
    LEA DX,M3
    MOV AH,9
    INT 21H
    
    LEA DX,M4
    MOV AH,9
    INT 21H  
    
    LEA DX,MR6       ;stars line
    MOV AH,9
    INT 21H 
    
    LEA DX,MR5
    MOV AH,9
    INT 21H  
    
     
    LEA DX,nl ;NEWLINE
    MOV AH,9
    INT 21H 
    
     
    LEA DX,M5
    MOV AH,9
    INT 21H 
    
    LEA DX,nl ;NEWLINE
    MOV AH,9
    INT 21H 
    
      
    MOV AH,1
    INT 21H
    MOV BH,AL
    SUB BH,48 
    
    LEA DX,nl ;NEWLINE
    MOV AH,9
    INT 21H     
            
            
    LEA DX,MR5       ;stars line
    MOV AH,9
    INT 21H         
            
    LEA DX,nl ;NEWLINE
    MOV AH,9
    INT 21H 
        
            ;READING NUMBER OF STUDENTS
        
            LEA SI,MSG1              ;PRINT_STRING FUNCTION PRINTS WHAT'S IN SI   
            CALL PRINT_STRING                                                        
            CALL SCAN_NUM            ;THE FUNCTION PUTS THE INPUT IN CX
            MOV N,CX
        
        
        
            ;READING IDs OF STUDENTS  
            LEA SI,MSG2
            CALL PRINT_STRING
            MOV SI, 0
       
    LOOP1:     
            CALL SCAN_NUM 
            MOV ID[SI],CL
            INC SI  
            PRINT 0AH        ;PRINT NEW LINE
            CMP SI,N 
            JNE LOOP1
       
        
        
            ;READING MARKS OF STUDENTS
            LEA SI,MSG3
            CALL PRINT_STRING
            MOV SI, 0
       
    LOOP2:      
            CALL SCAN_NUM 
            MOV Grade[SI],CL
            INC SI  
            PRINT 0AH        ;PRINT NEW LINE 
            CMP SI,N 
            JNE LOOP2  
       
        
           
            ;PRINT TABLE OF THEIR IDs AND MARKS AFTER SORTING
            LEA SI,HR   
            CALL PRINT_STRING
            LEA SI,MSG4
            CALL PRINT_STRING
          
            LEA DX,nl ;NEWLINE
            MOV AH,9
             INT 21H 
       
            MOV SI, 0
            
      LOOP3:  
            MOV AX,0
            MOV AL,ID[SI]  
            PRINT 09H
            PRINT 09H
            PRINT 09H
            PRINT 09H    
            CALL PRINT_NUM_UNS    
            PRINT 09H            ;PRINT TAB
            MOV AL,Grade[SI]
            CALL PRINT_NUM_UNS
             
            LEA DX,nl ;NEWLINE
            MOV AH,9
            INT 21H    
                      
            INC SI 
            CMP SI,N 
            JNE LOOP3

END MAIN
  

ret