#!/bin/sh
set -e

echo "Rozpoczynam instalację suchar CLI..."

SYSTEM_OPERACYJNY=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCHITEKTURA=$(uname -m)

if [ "$ARCHITEKTURA" = "x86_64" ]; then
    ARCHITEKTURA="amd64"
elif [ "$ARCHITEKTURA" = "aarch64" ] || [ "$ARCHITEKTURA" = "arm64" ]; then
    ARCHITEKTURA="arm64"
fi

ADRES_URL="https://github.com/SucharyAPI/suchary-cli/releases/latest/download/suchar_${SYSTEM_OPERACYJNY}_${ARCHITEKTURA}.tar.gz"
KATALOG_TYMCZASOWY=$(mktemp -d)
PLIK_POBRANY="${KATALOG_TYMCZASOWY}/suchar.tar.gz"
KATALOG_INSTALACJI="$HOME/.local/bin"

echo "Pobieranie paczki z: $ADRES_URL"
curl -sSL "$ADRES_URL" -o "$PLIK_POBRANY"

echo "Rozpakowywanie archiwum..."
tar -xzf "$PLIK_POBRANY" -C "$KATALOG_TYMCZASOWY"

echo "Instalowanie binarki..."
mkdir -p "$KATALOG_INSTALACJI"
mv "${KATALOG_TYMCZASOWY}/suchar" "$KATALOG_INSTALACJI/suchar"
chmod +x "$KATALOG_INSTALACJI/suchar"

rm -rf "$KATALOG_TYMCZASOWY"

# Sprawdzanie i dodawanie do PATH
if ! echo "$PATH" | grep -q "$KATALOG_INSTALACJI"; then
    echo "Dodawanie ścieżki $KATALOG_INSTALACJI do zmiennej PATH..."
    if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "*/zsh" ] || [ -f "$HOME/.zshrc" ]; then
        echo "export PATH=\"$KATALOG_INSTALACJI:\$PATH\"" >> "$HOME/.zshrc"
        KOMENDA_RESTARTU="source ~/.zshrc"
    elif [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
        echo "export PATH=\"$KATALOG_INSTALACJI:\$PATH\"" >> "$HOME/.bashrc"
        KOMENDA_RESTARTU="source ~/.bashrc"
    fi
    
    echo ""
    echo "===================================================================="
    echo " WAŻNE: Ze względów bezpieczeństwa systemów UNIX, skrypt uruchamiany"
    echo " przez 'curl | sh' nie może zmodyfikować PATH w otwartym terminalu."
    echo ""
    echo " Aby użyć komendy 'suchar' już teraz, skopiuj i wklej to:"
    echo " $KOMENDA_RESTARTU"
    echo "===================================================================="
    echo ""
else
    echo "Gotowe! Wpisz 'suchar', aby użyć aplikacji."
fi