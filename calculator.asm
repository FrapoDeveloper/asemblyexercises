.model small ;programa de un segmento de memoria de 64kb
.stack 100 ;numero de posiciones que tendremos en la pila
.data    
           
    msj1 DB 13,10, "Numero 1: ","$" ;dato tipo byte      
    msj2 DB 13,10, "Numero 2: ","$"               
    msj3 DB 13,10, "Suma: ","$"
    msj4 DB 13,10, "Resta: ","$"
    msj5 DB 13,10, "Producto: ","$"
    msj6 DB 13,10, "Division: ","$"  

    
    var1 DB 0 ;variable de tipo byte iniciada en cero
    var2 DB 0 
    div3 db 0 
    
.code ;origen de la memoria de programa guardada en el disco duro
    
    .startup ;inicio del programa  
    
        call limpia  
        
        ;---- MOSTRAMOS INFO Y LEEMOS PRIMER NUMERO -----
        
        mov ah,09h ; servicio para la interrupcion 21h para visualizar los caracteres
          lea dx, msj1 ;muestra lo que tenemos cargado en dx
        int 21h ; interrupcion de entrada y salida              
        
          call leer
          sub al,30h ;restamos 30h para sacar el numero, ascii (48) - 30h = numero decimal
          mov var1, al ;seteamos la var1
             
             
        ;---- MOSTRAMOS INFO Y LEEMOS SEGUNDO NUMERO -----     
             
        mov ah,09h
          lea dx, msj2
        int 21h
                 
          call leer
          sub al, 30h
          mov var2,al
          mov bl,var2 ; bl es ..       
        
        
        ;***** SUMA *****    
  
        mov ah, 09h 
          lea dx,msj3 
        int 21h         
          add bl,var1 ;guardamos el resultado de bl(var2) mas var1 en en bl
          mov dl,bl ;cargamos en dl el numero que queremos imprimir (dl)
          add dl,30h ; sumamos 30h para sacar el numero  ascii 
      
        mov ah,02h ; servicio que imprime un caracter, sabe lo que tiene dl
        int 21h 
        
            
       
        ;***** RESTA *****
   
        mov ah, 09h
            lea dx, msj4
        int 21h
          mov bl, var1   
          sub bl, var2   
          mov dl,bl
          add dl, 30h 
        
            
        mov ah, 02h  
        int 21h
        
        
        ;***** PRODUCTO *****
  
        mov ah,09h
            lea dx, msj5
        int 21h 
        
          mov al,var1
          mov bl,var2 
          mul bl ; al = al*bl (bl sabe cuanto almacena al) 
          mov dl,al
          add dl, 30h  
       
        
        mov ah, 02h 
        int 21h 
        
       ;***** DIVISION ***** 
         
        mov ah,09h
            lea dx,msj6
        int 21h
        
          xor ax,ax ;limpiar el registro AX =0 cuenta con 16 byte AH (8) AL (8)  
          mov al,var2 
          mov bl,var1 
          
          div bl ;divide ah = al (dividendo) / bl (divisor) el resto queda en AH y el cociente en AL
         
          mov dl, ah
 
          add dl,30h 
          
        mov ah, 02h
        int 21h
         
        
        ;PROCEDIMIENTOS
        
        limpia proc near
        mov ah,00h
        mov al,03h
        int 10h
        ret
        limpia endp 
                       
                       
        leer proc near
        mov ah,01h ;servicio para leer un caracter desde el teclado
        int 21h ;interrupcion de entrada y salida
        ret
        leer endp 
        
    