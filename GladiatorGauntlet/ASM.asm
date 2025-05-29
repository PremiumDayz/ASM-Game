   .MODEL small
   .STACK 100h
   .DATA
WelcomeMessage DB 10,13,'Welcome to Gladiator Gauntlet, this game is not affiliated to the board game of the same name. It is a fanmade recreation by PremiumDays',10,13,'$'
ChooseDifficultyMessage DB 10,13,'Choose the Difficulty (Easy,Medium,Hard)',10,13,'$'
NotValidMessage DB 10,13,'What is that?',10,13,'$'
LevelMessage DB 10,13,'The Current Level: $'
YouHaveHPMessage DB ' Your Remaining Life: $'
YouHaveHonorMessage DB ' Your Honor: $'
YourOpponentMessage DB 10,13,'Your Opponent Is: $'
OpponentHPMessage DB 10,13,'His Remaining HP: $'
DamageDealtMessage DB 10,13,'You Dealt $'
DamageTakenMessage DB 10,13,'You Took $'
DamageMessage DB ' Damage',10,13,'$'
YouWonMessage DB 10,13,'You VAPORIZED Your Opponent',10,13,'$'
YouLostMessage DB 10,13,'You Died In A HORRENDOUS way',10,13,'$'
Plus DB ' + $'

Difficulty DB 'Easy'
HP1 DB '4$'
HP2 DB '4$'
LVL DB '1$'
EnemyHealth DB '0$'
HONOR DB '0$'
Opponent DB 'Placeholder$'
DiceRoll DB '0$'
Die1Status DB 'Alive$'

   .CODE
   mov ax,@data
   mov ds,ax
   mov dx,OFFSET WelcomeMessage
   mov ah,9
   int 21h
DifficultyLoop:
   mov dx,OFFSET ChooseDifficultyMessage
   mov ah,9
   int 21h
   mov ah,1 ;It is only 1 or do i need to call 9 first?
   int 21h
   cmp al,'e'
   jz  EasyDifficultySetVar
   cmp al,'E'
   jz  EasyDifficultySetVar
   cmp al,'m'
   jz  MediumDifficultySetVar
   cmp al,'M'
   jz  MediumDifficultySetVar
   cmp al,'h'
   jz  HardDifficultySetVar
   cmp al,'H'
   jz  HardDifficultySetVar
   mov dx,OFFSET NotValidMessage
   mov ah,9
   int 21h
   jmp DifficultyLoop
EasyDifficultySetVar:
   mov [Difficulty],1
   jmp MainLoop
MediumDifficultySetVar:
   mov [Difficulty],2
   jmp MainLoop
HardDifficultySetVar:
   mov [Difficulty],3
MainLoop:
   mov dx,OFFSET LevelMessage
   mov ah,9
   int 21h
   mov dx,OFFSET [LVL]       ;PLACEHOLDER
   mov ah,9
   int 21h
   mov dx,OFFSET YouHaveHPMessage
   mov ah,9
   int 21h
   mov dx,OFFSET [HP1]         ;PLACEHOLDER
   mov ah,9
   int 21h
   mov dx,OFFSET Plus
   mov ah,9
   int 21h
   mov dx,OFFSET [HP2]
   mov ah,9
   int 21h
   mov dx,OFFSET YouHaveHonorMessage
   mov ah,9
   int 21h
   mov dx,OFFSET [HONOR]       ;PLACEHOLDER
   mov ah,9
   int 21h
Exit:
   mov ah,4ch
   int 21h
   END
