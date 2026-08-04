# 🥑 Suchary CLI

Oficjalne narzędzie wiersza poleceń do pobierania dawki dobrego (lub złego) humoru bezpośrednio w Twoim terminalu.

---

## 🚀 Instalacja

Zainstaluj `suchar` jedną komendą. Skrypt automatycznie rozpozna Twój system operacyjny oraz architekturę procesora, pobierze najnowszą binarkę i doda ją do zmiennej środowiskowej `PATH`.

### Linux / macOS

```bash
curl -fsSL https://raw.githubusercontent.com/SucharyAPI/suchary-cli/main/install.sh | sh
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/SucharyAPI/suchary-cli/main/install.ps1 | iex
```

---

## 💻 Użycie

Uruchom program bez argumentów, aby wylosować kawał:

```bash
suchar
```

Możesz także podać nazwę kategorii jako argument, aby otrzymać suchar z konkretnej grupy:

```bash
suchar <kategoria>
```

### 🏷️ Dostępne kategorie

- `programowanie`
- `dwuznaczny`
- `szkolny`
- `suchar`
- `wulgarny`
- `czarny`
- `inny`

### 📝 Przykłady

```bash
suchar programowanie
suchar szkolny
suchar suchar
```

---

## 🛡️ Obsługa błędów

Program posiada wbudowaną obsługę błędów – wyłapuje brak połączenia z siecią, błędy serwera HTTP oraz problemy z parsowaniem odpowiedzi JSON. W przypadku wpisania niepoprawnej kategorii, aplikacja poinformuje Cię o tym i wyświetli listę dostępnych opcji.

---

## ℹ️ Informacje dodatkowe

`Suchary CLI` wykorzystuje oficjalną bibliotekę [`sucharypl-go`](https://github.com/SucharyAPI/sucharypl-go) do integracji z ogólnopolską bazą żartów SucharyAPI
