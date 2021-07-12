# codice_fiscale

Package per generare il codice fiscale italiano a partire dai dati anagrafici.

Contiene il database dei comuni italiano con provincia e codice comune del catasto (city_dao.dart)

# Costruttore

```
final fiscalCode = CodiceFiscale(
    firstName: 'marco eliseo',
    lastName: 'sanson',
    birthCity: CityDao().getCityByName('Vicenza'),
    gender: CodiceFiscaleGender.M,
    birthDate: DateTime(1981, 10, 28));

print(fiscalCode.lastNameCode());
```

# Validazione

```
CodiceFiscale.check("ABCXYZ00E05C62BP")
```
