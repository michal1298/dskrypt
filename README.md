# dskrypt - zadanie laboratoryjne z przedmiotu *Systemy operacyjne*.
Skrypt napisany w Bashu.  
Korzysta z `ansiweather`: https://github.com/fcambus/ansiweather

## Przed użyciem
### Instalacja ansiweather
```
sudo apt install ansiweather
```
### Nadanie uprawnień do wykonywania
```
chmod +x dskrypt.sh
```

## Instrukcja użycia
### Uruchomienie
```
./dskrypt.sh
```
Skrypt będzie pytał o kolejne informacje pogodowe do wyświetlenia.  
Wszelkie informacje należy zatwierdzać klawiszem ENTER.  
Po wyświetleniu pogody, można zdecydować czy zakończyć działanie skryptu, czy kontynuować wyświetlanie dla innej lokalizacji.

### Wyświetlanie pomocy
```
./dskrypt.sh -h
```

### Wyświetlanie informacji o autorze i wersji
```
./dskrypt.sh -v
```

## Podręcznik użytkownika - *manual*
### Importowanie
Należy skopiować plik `dskrypt.8.gz` do odpowiedniego katalogu z instrukcjami.  
W zależności od posiadanej wersji, ścieżka może być inna. Przykład dla Ubuntu 20.04:
```
sudo cp dskrypt.8.gz /usr/share/man/pl/man8/
```

### Wyświetlenie podręcznika
```
man dskrypt
```