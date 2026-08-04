Write-Host "Rozpoczynam instalację suchar CLI..."

$ARCHITEKTURA = $env:PROCESSOR_ARCHITECTURE.ToLower()
if ($ARCHITEKTURA -eq "amd64") {
    $ARCHITEKTURA = "amd64"
} elseif ($ARCHITEKTURA -eq "arm64") {
    $ARCHITEKTURA = "arm64"
} else {
    Write-Host "Nieobsługiwana architektura: $ARCHITEKTURA"
    exit 1
}

$ADRES_URL = "https://github.com/SucharyAPI/suchary-cli/releases/latest/download/suchar_windows_$ARCHITEKTURA.zip"
$KATALOG_INSTALACJI = "$env:LOCALAPPDATA\suchar"
$PLIK_TYMCZASOWY = "$env:TEMP\suchar.zip"

Write-Host "Pobieranie paczki z: $ADRES_URL"
Invoke-WebRequest -Uri $ADRES_URL -OutFile $PLIK_TYMCZASOWY

Write-Host "Rozpakowywanie archiwum..."
if (Test-Path $KATALOG_INSTALACJI) {
    Remove-Item -Recurse -Force $KATALOG_INSTALACJI
}
New-Item -ItemType Directory -Force -Path $KATALOG_INSTALACJI | Out-Null
Expand-Archive -Path $PLIK_TYMCZASOWY -DestinationPath $KATALOG_INSTALACJI -Force

Remove-Item -Force $PLIK_TYMCZASOWY

# Sprawdzanie i dodawanie do PATH
$ZMIENNA_PATH = [Environment]::GetEnvironmentVariable("Path", "User")
if ($ZMIENNA_PATH -notmatch [regex]::Escape($KATALOG_INSTALACJI)) {
    Write-Host "Dodawanie ścieżki $KATALOG_INSTALACJI do zmiennej środowiskowej PATH..."
    $NOWY_PATH = "$KATALOG_INSTALACJI;$ZMIENNA_PATH"
    [Environment]::SetEnvironmentVariable("Path", $NOWY_PATH, "User")
    Write-Host "Musisz uruchomić PowerShell ponownie, aby system zauważył zmiany w PATH."
}

Write-Host "Gotowe! Otwórz nowe okno terminala i wpisz 'suchar', aby użyć aplikacji."