   .MODEL small
   .STACK 100h
   .DATA
Choose DB 10,13,'Choose Rock, Paper or Scissors (R,P,S)',10,13,'$'
NotValid DB 10,13,'Not a Valid Option',10,13,'$'
YouChoose_ DB 10,13,'You choose $'
OpponentChooses_ DB 10,13,'Your opponent chooses $'
Rock DB 'Rock',10,13,'$'
Paper DB 'Paper',10,13,'$'
Scissors DB 'Scissors',10,13,'$'
Lose DB 10,13,'You lose, better luck next time.',10,13,'$'
Win DB 10,13,'You Won!!!!',10,13,'$'
   .CODE
   mov ax,@data
   mov ds,ax
InputLoop:
   mov dx,OFFSET Choose
   mov ah,9
   int 21h
   mov ah,2ch
   int 21h
   mov ax,dx
   and ax,01h
   push ax
   mov ah,1
   int 21h
   cmp al,'R'
   jz  RockChosen
   cmp al,'r'
   jz  RockChosen
   cmp al,'P'
   jz  PaperChosen
   cmp al,'p'
   jz  PaperChosen
   cmp al,'S'
   jz  ScissorsChosen
   cmp al,'s'
   jz  ScissorsChosen

   mov dx,OFFSET NotValid
   mov ah,9
   int 21h
   jmp InputLoop
RockChosen:
   mov dx,OFFSET YouChoose_
   mov ah,9
   int 21h
   mov dx,OFFSET Rock
   mov ah,9
   int 21h
   pop ax
   cmp ax,0
   mov dx,OFFSET OpponentChooses_
   mov ah,9
   int 21h
   mov dx,OFFSET Scissors
   jz Won
   mov dx,OFFSET Paper
   jmp Lost
PaperChosen:
   mov dx,OFFSET YouChoose_
   mov ah,9
   int 21h
   mov dx,OFFSET Paper
   mov ah,9
   int 21h
   pop ax
   cmp ax,1
   mov dx,OFFSET OpponentChooses_
   mov ah,9
   int 21h
   mov dx,OFFSET Rock
   jz Won
   mov dx,OFFSET Scissors
   jmp Lost
ScissorsChosen:
   mov dx,OFFSET YouChoose_
   mov ah,9
   int 21h
   mov dx,OFFSET Scissors
   mov ah,9
   int 21h
   pop ax
   cmp ax,1
   mov dx,OFFSET OpponentChooses_
   mov ah,9
   int 21h
   mov dx,OFFSET Paper
   jz Won
   mov dx,OFFSET Rock
   jmp Lost
Won:
   mov ah,9
   int 21h
   mov dx,OFFSET Win
   mov ah,9
   int 21h
   jmp ENDSs
Lost:
   mov ah,9
   int 21h
   mov dx,OFFSET Lose
   mov ah,9
   int 21h
ENDSs:
   mov ah,4ch
   int 21h
   END

