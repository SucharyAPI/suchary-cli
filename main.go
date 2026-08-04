package main

import (
	"errors"
	"fmt"
	"os"

	sucharygo "github.com/SucharyAPI/sucharypl-go"
)

func main() {
	komenda := ""
	if len(os.Args) > 1 {
		komenda = os.Args[1]
	}

	if komenda == "" {
		zart, err := sucharygo.DajKawal()
		if err != nil {
			obsluzBlad(err)
			return
		}
		fmt.Println(zart)
		return
	}

	var czekator sucharygo.Kategoria
	switch komenda {
	case "programowanie":
		czekator = sucharygo.Programowanie
	case "dwuznaczny":
		czekator = sucharygo.Dwuznaczne
	case "szkolny":
		czekator = sucharygo.Szkolne
	case "suchar":
		czekator = sucharygo.Suchary
	case "wulgarny":
		czekator = sucharygo.Wulgarne
	case "czarny":
		czekator = sucharygo.CzarnyHumor
	case "inny":
		czekator = sucharygo.Inne
	default:
		fmt.Printf("Nieznana kategoria: %s\n", komenda)
		fmt.Println("Dostępne kategorie: programowanie, dwuznaczny, szkolny, suchar, wulgarny, czarny, inny")
		return
	}

	zart, err := sucharygo.DajKawal(czekator)
	if err != nil {
		obsluzBlad(err)
		return
	}
	fmt.Println(zart)
}

func obsluzBlad(err error) {
	var blednyHttp *sucharygo.HTTPError
	var blednePolaczenie *sucharygo.ConnectionError
	var blednyJson *sucharygo.JSONError

	if errors.As(err, &blednyHttp) {
		fmt.Printf("Błąd serwera HTTP (%d): %s\n", blednyHttp.Kod, blednyHttp.Tresc)
		return
	}

	if errors.As(err, &blednePolaczenie) {
		fmt.Println("Błąd połączenia z siecią! Sprawdź swoje połączenie z internetem.")
		return
	}

	if errors.As(err, &blednyJson) {
		fmt.Println("Błąd przetwarzania danych JSON z odpowiedzi API.")
		return
	}

	fmt.Printf("Wystąpił nieoczekiwany błąd: %v\n", err)
}
