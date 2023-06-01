.data
licz1: .word 11
licz2: .word 10
wyn:   .word 0
status: .word 0 #warto�� zmieni si� je�eli nast�pi nadmiar
string: .asciiz "Nastapil nadmiar, polecam mniejsze liczby"


.text
# �aduje pocz�tkowe warto�ci danych do rejestr�w
lw $t0, wyn
lw $t1, licz1
lw $t2, licz2 

petla:
blez $t2, end # Je�eli t2 jest <= 0, to sko�czyli�my liczy�, mamy wynik
andi $t5, $t2, 1 # Sprawdzam czy ostatnia cyfra licz2 jest 0 czy 1, je�li jest 1 to w $t5 b�dzie 1, je�li 0 to 0
blez $t5 przesun # Je�eli ostatnia/obecna cyfra licz2 to zero, nic nie dodajemy tylko przesuwamy
addu $t0, $t0, $t1 # Je�eli ostatnia/obecna cyfra licz2 to jeden, dodajemy do wyniku mno�n� (mno�enie przez jeden nic nie zmienia)
bltz $t0, overflow # Je�eli wynik b�dzie ujemny, to wiem �e dosz�o do overlow
j przesun 	  # Je�eli nie dosz�o do overflow, to przesuwamy


end: 
#Koniec programu
li $v0, 1   # warto�� dla syscall do wy�wietlania liczby
move $a0, $t0 # liczba do wy�wietlenia
sw $t0, wyn # zapisuj� wynik do pami�ci
syscall 
#Ewentualnie mo�na robi� syscall 35 (print liczby dziesi�tnej jako binarn�)

li $v0, 10 #wyjd� z programu
syscall


przesun:
sll $t1, $t1, 1 # Przesuwam licz1 (mno�n�) o jedn� pozycje w lewo (zwi�kszam), krok mno�enia
bltz $t1, overflow # Je�eli mno�na b�dzie ujemna, to wiemy �e nast�pi� overflow
srl $t2, $t2, 1 # Przesuwam licz2 w prawo (zmniejszam), kiedy dojdziemy do 0 program si� sko�czy
j petla

overflow:
li $t6, 1 # �aduje jedynke �eby potem zapisa� j� do pola status
sw $t6, status # Zapisuje 1 do pola status �eby zasygnalizowa� overflow
li $v0 4 # 4 odpowiada wy�wietleniu stringa podczas syscall
la $a0 string #wy�wietlam tekst informuj�cy o wyst�pieniu nadmiaru
syscall

li $v0, 10 #wyjd� z programu
syscall
