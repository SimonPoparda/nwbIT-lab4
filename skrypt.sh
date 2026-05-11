#!/bin/bash

# Główny skrypt z obsługą różnych flag

case "$1" in
    --date|-d)
        date +"%Y-%m-%d"
        ;;
    --help|-h)
        echo "Dostępne opcje:"
        echo "  --date, -d        Wyświetl dzisiejszą datę"
        echo "  --logs [liczba], -l [liczba]    Utwórz pliki logów (domyślnie 100)"
        echo "  --error [liczba], -e [liczba]   Utwórz pliki błędów (domyślnie 100)"
        echo "  --init             Klonuj repo i ustaw PATH"
        echo "  --help, -h        Wyświetl tę pomoc"
        ;;
    --logs|-l)
        liczba=${2:-100}
        for ((i=1; i<=liczba; i++)); do
            nazwa_pliku="log$i.txt"
            {
                echo "Nazwa pliku: $nazwa_pliku"
                echo "Skrypt: skrypt.sh"
                echo "Data: $(date)"
            } > "$nazwa_pliku"
        done
        echo "Utworzono $liczba plików logów"
        ;;
    --error|-e)
        liczba=${2:-100}
        mkdir -p error
        for ((i=1; i<=liczba; i++)); do
            mkdir -p "error/error$i"
            nazwa_pliku="error/error$i/error$i.txt"
            {
                echo "Nazwa pliku: error$i.txt"
                echo "Skrypt: skrypt.sh"
                echo "Data: $(date)"
            } > "$nazwa_pliku"
        done
        echo "Utworzono $liczba plików błędów"
        ;;
    --init)
        repo_url="https://github.com/SimonPoparda/nwbIT-lab4.git"
        git clone "$repo_url"
        skrypt_path="$(pwd)/nwbIT-lab4/skrypt.sh"
        chmod +x "$skrypt_path"
        export PATH="$PATH:$(dirname "$skrypt_path")"
        echo "Repo sklonowane i PATH ustawiony"
        ;;
    *)
        echo "Nieznana opcja: $1"
        echo "Użyj: $0 --help"
        exit 1
        ;;
esac
