.data
licz1: .word 11
licz2: .word 10
wyn:   .word 0
status: .word 0 #wartoœæ zmieni siê je¿eli nast¹pi nadmiar
string: .asciiz "Nastapil nadmiar, polecam mniejsze liczby"


.text
# £aduje pocz¹tkowe wartoœci danych do rejestrów
lw $t0, wyn
lw $t1, licz1
lw $t2, licz2 

petla:
blez $t2, end # Je¿eli t2 jest <= 0, to skoñczyliœmy liczyæ, mamy wynik
andi $t5, $t2, 1 # Sprawdzam czy ostatnia cyfra licz2 jest 0 czy 1, jeœli jest 1 to w $t5 bêdzie 1, jeœli 0 to 0
blez $t5 przesun # Je¿eli ostatnia/obecna cyfra licz2 to zero, nic nie dodajemy tylko przesuwamy
addu $t0, $t0, $t1 # Je¿eli ostatnia/obecna cyfra licz2 to jeden, dodajemy do wyniku mno¿n¹ (mno¿enie przez jeden nic nie zmienia)
bltz $t0, overflow # Je¿eli wynik bêdzie ujemny, to wiem ¿e dosz³o do overlow
j przesun 	  # Je¿eli nie dosz³o do overflow, to przesuwamy


end: 
#Koniec programu
li $v0, 1   # wartoœæ dla syscall do wyœwietlania liczby
move $a0, $t0 # liczba do wyœwietlenia
sw $t0, wyn # zapisujê wynik do pamiêci
syscall 
#Ewentualnie mo¿na robiæ syscall 35 (print liczby dziesiêtnej jako binarn¹)

li $v0, 10 #wyjdŸ z programu
syscall


przesun:
sll $t1, $t1, 1 # Przesuwam licz1 (mno¿n¹) o jedn¹ pozycje w lewo (zwiêkszam), krok mno¿enia
bltz $t1, overflow # Je¿eli mno¿na bêdzie ujemna, to wiemy ¿e nast¹pi³ overflow
srl $t2, $t2, 1 # Przesuwam licz2 w prawo (zmniejszam), kiedy dojdziemy do 0 program siê skoñczy
j petla

overflow:
li $t6, 1 # £aduje jedynke ¿eby potem zapisaæ j¹ do pola status
sw $t6, status # Zapisuje 1 do pola status ¿eby zasygnalizowaæ overflow
li $v0 4 # 4 odpowiada wyœwietleniu stringa podczas syscall
la $a0 string #wyœwietlam tekst informuj¹cy o wyst¹pieniu nadmiaru
syscall

li $v0, 10 #wyjdŸ z programu
syscall
