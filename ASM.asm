   .MODEL small
   .STACK 100h
   .DATA
WelcomeMessage DB 10,13,'Welcome to Gladiator Gauntlet, this game is not affiliated to the board game of the same name. It is a fanmade recreation by PremiumDays',10,13,'$'
ChooseDifficultyMessage DB 10,13,'Choose the Difficulty (Easy,Medium,Hard)',10,13,'$'
NotValidMessage DB 10,13,'What is that?',10,13,'$'
RoundMessage DB 10,13,'The Current Round: $'
YouHaveHPMessage DB 10,13,'Your Remaining Life: $'
YouHaveHonorMessage DB 10,13,'Your Honor: $'
YourOpponentMessage DB 10,13,'Your Opponent Is: $'
OpponentHPMessage DB 10,13,'His Remaining HP: $'
EventMessage DB 10,13,'The Current Event: $'
Event1Message DB 'You May Reroll a One Once During Combat$'
Event2Message DB 'Gain Maximum Glory$'
Event3Message DB 'DRAW AN EXTRA ENEMY CARD$'
Event4Message DB 'ENEMY WINS TIES THIS ROUND$'
Event5Message DB '+2 To Any Health Die$'
Event6Message DB 'You Win Ties This Round$'
DamageDealtMessage DB 10,13,'You Dealt $'
DamageTakenMessage DB 10,13,'You Took $'
DamageMessage DB ' Damage',10,13,'$'
YouWonMessage DB 10,13,'You DESTROYED Your Opponent',10,13,'$'
YouLostMessage DB 10,13,'You Got An AGONIZING DEATH',10,13,'$'
GameWonMessage DB 10,13,'You Got a BLOODY CONQUEST',10,13,'$' 
Plus DB ' + $'

SagittarivsMessage DB 'Sagittarivs',10,13,'$'
MvrmilloMessage DB 'Mvrmillo',10,13,'$'
ScvtarivsMessage DB 'Scvtarivs',10,13,'$'
EssedarivsMessage DB 'Essedarivs',10,13,'$'
ThraexMessage DB 'Thraex',10,13,'$'
ProvocatorMessage DB 'Provocator',10,13,'$'
RetiarivsMessage DB 'Retiarivs',10,13,'$'
RvdiarivsMessage DB 'Rvdiarivs',10,13,'$'
CestvsMessage DB 'Cestvs',10,13,'$'
EqvesMessage DB 'Eqves',10,13,'$'

Difficulty DB 'Easy'
HP1 DB '4$'
HP2 DB '4$'
Round DB 'I$'
EnemyHealth DB '0$'
HONOR DB '0',10,13,'$'
Event DB '0$'
Opponent DB 'Placeholder$'
DiceRoll DB '0$'
Die1Status DB 'Alive$'
Side DB 'a$'

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
   mov dx,OFFSET RoundMessage
   mov ah,9
   int 21h
   mov dx,OFFSET [Round]
   mov ah,9
   int 21h
   mov dx,OFFSET YouHaveHPMessage
   mov ah,9
   int 21h
   mov dx,OFFSET [HP1]
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
   
   mov dx,OFFSET YourOpponentMessage
   mov ah,9
   int 21h
   cmp Side,'b'
   jz SideB
   call EnemyCardSub
   cmp DiceRoll,'1'
   jz  Provocator
   cmp DiceRoll,'2'
   jz  Retiarivs
   cmp DiceRoll,'3'
   jz  Rvdiarivs
   cmp DiceRoll,'4'
   jz  Cestvs
Eqves:
   mov dx,OFFSET EqvesMessage
   mov ah,9
   int 21h
   jmp MainLoopContinue
Cestvs:
   mov dx,OFFSET CestvsMessage
   mov ah,9
   int 21h
   jmp MainLoopContinue
Rvdiarivs:
   mov dx,OFFSET RvdiarivsMessage
   mov ah,9
   int 21h
   jmp MainLoopContinue
Retiarivs:
   mov dx,OFFSET RetiarivsMessage
   mov ah,9
   int 21h
   jmp MainLoopContinue
Provocator:
   mov dx,OFFSET ProvocatorMessage
   mov ah,9
   int 21h
SideB:
   call EnemyCardSub
   cmp DiceRoll,'1'
   jz  Sagittarivs
   cmp DiceRoll,'2'
   jz  Mvrmillo
   cmp DiceRoll,'3'
   jz  Scvtarivs
   cmp DiceRoll,'4'
   jz  Essedarivs
Thraex:
   mov dx,OFFSET ThraexMessage
   mov ah,9
   int 21h
   jmp MainLoopContinue
Essedarivs:
   mov dx,OFFSET EssedarivsMessage
   mov ah,9
   int 21h
   jmp MainLoopContinue
Scvtarivs:
   mov dx,OFFSET ScvtarivsMessage
   mov ah,9
   int 21h
   jmp MainLoopContinue
Mvrmillo:
   mov dx,OFFSET MvrmilloMessage
   mov ah,9
   int 21h
   jmp MainLoopContinue
Sagittarivs:
   mov dx,OFFSET SagittarivsMessage
   mov ah,9
   int 21h
MainLoopContinue:
   call DiceRollSub            ;Roll The Dice For Event
   mov dx,OFFSET EventMessage
   mov ah,9
   int 21h
   cmp DiceRoll,'1' 
   jz  Event1
   cmp DiceRoll,'2'
   jz  Event2
   cmp DiceRoll,'3'
   jz  Event3
   cmp DiceRoll,'4'
   jz  Event4
   cmp DiceRoll,'5'
   jz  Event5
Event6:
   mov [Event],6
   mov dx,OFFSET Event6Message
   mov ah,9
   int 21h
   jmp MainLoopContinue2
Event5:
   mov [Event],5
   mov dx,OFFSET Event5Message
   mov ah,9
   int 21h
   jmp MainLoopContinue2
Event4:
   mov [Event],4
   mov dx,OFFSET Event4Message
   mov ah,9
   int 21h
   jmp MainLoopContinue2
Event3:
   mov [Event],3
   mov dx,OFFSET Event3Message
   mov ah,9
   int 21h
   jmp MainLoopContinue2
Event2:
   mov [Event],2
   mov dx,OFFSET Event2Message
   mov ah,9
   int 21h
   jmp MainLoopContinue2
Event1:
   mov [Event],1
   mov dx,OFFSET Event1Message
   mov ah,9
   int 21h
MainLoopContinue2:
   jmp Exit   

DiceRollSub:
   mov ah,2ch
   int 21h
   xor ax,ax
   mov al,dl
   xor dx,dx
   mov bx,6
   div bx
   add dl,49
   mov DiceRoll,dl
   ret
EnemyCardSub:
   mov ah,2ch
   int 21h
   xor ax,ax
   mov al,dl
   xor dx,dx
   mov bx,5
   div bx
   add dl,49
   mov DiceRoll,dl
   ret  
Exit:
   mov ah,4ch
   int 21h
   END
