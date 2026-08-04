# Suchary CLI

## Użycie

Uruchom program bez argumentów, aby pobrać losowy kawał:

```bash
suchar
```

Możesz przekazać nazwę kategorii, aby otrzymać kawał z konkretnej grupy.

```bash
suchar <kategoria>
```

## Dostępne kategorie

- `programowanie`
- `dwuznaczny`
- `szkolny`
- `suchar`
- `wulgarny`
- `czarny`
- `inny`

## Przykłady

```bash
suchar programowanie
suchar szkolny
suchar suchar
```

## Obsługa błędów

Program rozpoznaje błędy połączenia z siecią, problemy z API HTTP i błędy parsowania JSON. W przypadku nieznanej kategorii wyświetli komunikat z listą dostępnych opcji.

## Informacje dodatkowe

`Suchary CLI` wykorzystuje bibliotekę oficjalną bibliotekę sucharypl-go do komunikacji z API.
