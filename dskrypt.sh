#!/bin/bash

# Systemy operacyjne - laboratorium: Duzy skrypt - "pogodynka".

# dskrypt 1.0
# utworzony: 2020-06-10
# ostatnia modyfikacja: 2020-06-10
# licencja: Open Source


while getopts ":hv" OPCJE	# wybor opcji przy uruchomieniu skryptu
do
	case $OPCJE in
		h) 		# pomoc
			echo "Tuz po uruchomieniu, uzytkownik zostanie poproszony o podanie nazwy miejscowosci dla ktorej ma zostac wyswietlona prognoza pogody i zatwierdzeniu jej klawiszem ENTER."
			echo -e "\n"		# wyswietlenie znaku nowej linii
			echo "Kolejne opcje nalezy wybierac klawiszami 1 lub 2, z wyjatkiem opcji wyboru ilosci dni, gdzie nalezy wybrac opcje 1-8 i zatwierdzeniu jej klawiszem ENTER."
			echo -e "\n"		# wyswietlenie znaku nowej linii
			echo "Po wyswietleniu pogody, uzytkownik bedzie mogl wybrac, czy chce zakonczyc dzialanie skryptu, czy wyswietlic informacje o pogodzie dla kolejnej miejscowosci."
			exit ;;	# wylaczenie
		v) 		# informacja o autorze i wersji
			echo "Autor: Michal J"
			echo "Wersja skryptu: 1.0" 
			exit ;;	# wylaczenie
		"?") 		# wybor innej opcji
			echo "Nieznana opcja -$OPTARG." 
			echo "Obslugiwane opcje: -h oraz -v."
			exit ;;	# wylaczenie
	esac
done


echo "Witaj w pogodynce. Wszelkie operacje zatwierdzaj klawiszem ENTER."

while [ 1==1 ]	# petla nieskonczona
do
	echo -n "Podaj nazwe miejscowosci: "	# -n - nie przechodzi do nastepnej linii
	read MIEJSCOWOSC	# wczytanie miejscowosci podanej przez uzytkownika

	PS3="Twoja odpowiedz: "		# komunikat wyswietlany po kazdym select
	echo "Wybierz system jednostkowy:"

	select SYSTEM_ODP in metryczny imperialny	# wybor systemu jednostkowego
	do
		case $SYSTEM_ODP in
			"metryczny") # odpowiedz nr 1
				RODZ_SYSTEMU="metric"		# metric - slowo uzywane w ansiweather
				echo "Wybrales/as system metryczny."
				break;	;;	# break - przerwanie wykonywania petli; dwa sredniki na koncu sa wymagane po kazdej opcji w select
			"imperialny") # odpowiedz nr 2
				RODZ_SYSTEMU="imperial"		# imperial - slowo uzywane w ansiweather
				echo "Wybrales/as system imperialny."
				break;	;;
			*) # kazda inna podana odpowiedz
				echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
				# brak break - nie nastapi przerwanie petli i uzytkownik bedzie mogl ponownie wybrac
		esac	# zakonczenie case
	done		# zakonczenie do
	echo -e "\n"		# wyswietlenie znaku nowej linii

	echo "Czy chcesz wyswietlic pogode na kilka kolejnych dni?"

	select CZY_KILKA_DNI in Tak Nie		# wybor pogody na jeden dzien lub na kilka dni
	do
		case $CZY_KILKA_DNI in
			"Tak") # odpowiedz nr 1
				echo "Wybierz liczbe kolejnych dni, dla ktorych ma zostac wyswietlona pogoda:"
				
				select LICZBA_DNI in "0 dni" "1 dzien" "2 dni" "3 dni" "4 dni" "5 dni" "6 dni" "7 dni"
				do
					case $LICZBA_DNI in
						"0 dni")  # odpowiedz nr 1
							LICZBA_DNI_2=0
							break;	;;
						"1 dzien") # odpowiedz nr 2
							LICZBA_DNI_2=1
							break;	;;
						"2 dni")  # odpowiedz nr 3
							LICZBA_DNI_2=2
							break;	;;
						"3 dni") # odpowiedz nr 4
							LICZBA_DNI_2=3
							break;	;;
						"4 dni")  # odpowiedz nr 5
							LICZBA_DNI_2=4
							break;	;;
						"5 dni") # odpowiedz nr 6
							LICZBA_DNI_2=5
							break;	;;
						"6 dni")  # odpowiedz nr 7
							LICZBA_DNI_2=6
							break;	;;
						"7 dni") # odpowiedz nr 8
							LICZBA_DNI_2=7
							break;	;;
						*) # kazda inna podana odpowiedz
							echo "Blad: wprowadzona wartosc nie nalezy do przedzialu 1-8. Wybierz wartosc z przedzialu 1-8:";;
					esac
				done				
				echo "Wybrales/as pogode na najblizsze $LICZBA_DNI."

				break;	;;		
			"Nie") # odpowiedz nr 2
				LICZBA_DNI_2=0;
				echo "Wybrales/as pogode na jeden dzien."
				break;	;;
			*) # kazda inna podana odpowiedz
				echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
		esac
	done
	echo -e "\n"		# wyswietlenie znaku nowej linii



	echo "Czy chcesz, by pogoda zostala wyswietlona na kolorowym tle?"

	select CZY_TLO in Tak Nie
	do
		case $CZY_TLO in
			"Tak") # odpowiedz nr 1
				TLO="true"
				echo "Wybrales/as kolorowe tlo." 
				break;	;;
			"Nie") # odpowiedz nr 2
				TLO="false"
				echo "Nie wybrales/as kolorowego tla."
				break;	;;
			*) # kazda inna podana odpowiedz
				echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
		esac
	done
	echo -e "\n"		# wyswietlenie znaku nowej linii


	echo "Czy chcesz, by zostaly wyswietlone symbole pogody?"

	select CZY_SYMBOLE in Tak Nie		# wybor, czy symbole pogodowe maja sie wyswietlac
	do
		case $CZY_SYMBOLE in
			"Tak") # odpowiedz nr 1
				SYMBOLE="true"
				echo "Wybrales/as symbole pogody." 
				break;	;;
			"Nie") # odpowiedz nr 2
				SYMBOLE="false"
				echo "Nie wybrales/as symboli pogody." 
				break;	;;
			*) # kazda inna podana odpowiedz
				echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
		esac
	done
	echo -e "\n"		# wyswietlenie znaku nowej linii


	if [ $LICZBA_DNI_2 -eq 0 ]; then	# jezeli LICZBA_DNI = 0
		# jezeli LICZBA_DNI = 0, uzytkownik moze wybrac wiecej parametrow, ktore maja zostac wyswietlone
		echo "Wybrales/as pogode na jeden dzien. Teraz wybierz kolejne parametry:"
		echo "Czy chcesz, by zostaly wyswietlone informacje o sile i kierunku wiatru?"

		select CZY_WIATR in Tak Nie		# wybor informacji o wietrze
		do
			case $CZY_WIATR in
			"Tak") # odpowiedz nr 1
				WIATR="true"
				echo "Wybrales/as informacje o sile i kierunku wiatru." 
				break;	;;
			"Nie") # odpowiedz nr 2
				WIATR="false"
				echo "Nie wybrales/as informacji o sile i kierunku wiatru." 
				break;	;;
			*) # kazda inna podana odpowiedz
				echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
			esac
		done
		echo -e "\n"		# wyswietlenie znaku nowej linii



		echo "Czy chcesz, by zostaly wyswietlone informacje o wilgotnosci?"

		select CZY_WILGOTNOSC in Tak Nie		# wybor informacji o wietrze
		do
			case $CZY_WILGOTNOSC in
			"Tak") # odpowiedz nr 1
				WILGOTNOSC="true"
				echo "Wybrales/as informacje o wilgotnosci." 
				break;	;;
			"Nie") # odpowiedz nr 2
				WILGOTNOSC="false"
				echo "Nie wybrales/as informacji o wilgotnosci." 
				break;	;;
			*) # kazda inna podana odpowiedz
				echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
			esac
		done
		echo -e "\n"		# wyswietlenie znaku nowej linii	




		echo "Czy chcesz, by zostaly wyswietlone informacje o cisnieniu atmosferycznym?"

		select CZY_CISNIENIE in Tak Nie		# wybor informacji o cisnieniu atmosferycznym
		do
			case $CZY_CISNIENIE in
			"Tak") # odpowiedz nr 1
				CISNIENIE="true"
				echo "Wybrales/as informacje o cisnieniu atmosferycznym." 
				break;	;;
			"Nie") # odpowiedz nr 2
				CISNIENIE="false"
				echo "Nie wybrales/as informacji o cisnieniu atmosferycznym."
				break; ;;
			*) # kazda inna podana odpowiedz
				echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
			esac
		done
		echo -e "\n"		# wyswietlenie znaku nowej linii



		echo "Czy chcesz, by zostaly wyswietlone informacje o wschodzie i zachodzie slonca?"

		select CZY_SLONCE in Tak Nie		# wybor informacji o wschodzie i zachodzie slonca
		do
			case $CZY_SLONCE in
			"Tak") # odpowiedz nr 1
				SLONCE="true"
				echo "Wybrales/as informacje o wschodzie i zachodzie slonca."
				break; ;;
			"Nie") # odpowiedz nr 2
				SLONCE="false"
				echo "Nie wybrales/as informacji o wschodzie i zachodzie slonca." 
				break;	;;
			*) # kazda inna podana odpowiedz
				echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
			esac
		done
		echo -e "\n"		# wyswietlenie znaku nowej linii


	else 	# jezeli LICZBA_DNI jest rozna od 0 (1-7 dni)
		echo "Wiecej opcji dla pogody na kilka dni jest niedostepnych."
		echo "Jezeli chcesz uzyskac wiecej informacji o pogodzie, wybierz pogode na jeden dzien."


	fi	# zakonczenie if-a


	echo "Pobieram informacje o pogodzie dla miejscowosci $MIEJSCOWOSC. Prosze o cierpliwosc..."

	# wywolanie ansiweather z parametrami podanymi przez uzytkownika:
	ansiweather -l $MIEJSCOWOSC -u $RODZ_SYSTEMU -f $LICZBA_DNI_2 -a $TLO -s $SYMBOLE -w $WIATR -h $WILGOTNOSC -p $CISNIENIE -d $SLONCE


echo "Aby zakonczyc dzialanie pogodynki, nacisnij klawisz 1;"
echo "Aby kontynuowac sprawdzanie pogody, nacisnij klawisz 2:"

select CZY_ZAKONCZYC in Zakoncz Kontynuuj		# wybor, czy kontynuowac dzialanie, czy zakonczyc
do
	case $CZY_ZAKONCZYC in
		"Zakoncz") # odpowiedz nr 1
			break;	;;
		"Kontynuuj") # odpowiedz nr 2
			echo -e "\n" # wyswietlenie znaku nowej linii	
			break;	;;
		*) # kazda inna podana odpowiedz
			echo "Bledny wybor. Wpisz cyfre 1 lub 2 i zatwierdz klawiszem ENTER." ;;
	esac
done

if [ $CZY_ZAKONCZYC == "Zakoncz" ]; then	# jezeli uzytkownik w CZY_ZAKONCZYC wybral "Zakoncz"
	echo -e "\n" 	# wyswietlenie znaku nowej linii
	break;		# przerwanie petli nieskonczonej
fi

done	# zakonczenie petli nieskonczonej
	
echo "Dziekuje za skorzystanie z pogodynki!"

