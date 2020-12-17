import 'package:codice_fiscale/dao/city_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:codice_fiscale/codice_fiscale.dart';

void main() {
  test('test last name', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Vicenza'),
        gender: CodiceFiscaleGender.M,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.lastNameCode(), 'SNS');
  });

  test('test first name', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Vicenza'),
        gender: CodiceFiscaleGender.M,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.firstNameCode(), 'MCL');
  });

  test('test birth date Male', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Vicenza'),
        gender: CodiceFiscaleGender.M,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.birthDateCode(), '81R28');
  });

  test('test birth date Female', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Vicenza'),
        gender: CodiceFiscaleGender.F,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.birthDateCode(), '81R68');
  });

  test('test birth place vicenza', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Vicenza'),
        gender: CodiceFiscaleGender.F,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.birthPlaceCode(), 'L840');
  });

  test('test birth place padova', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Padova'),
        gender: CodiceFiscaleGender.F,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.birthPlaceCode(), 'G224');
  });

  test('test check code char one', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Vicenza'),
        gender: CodiceFiscaleGender.M,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.getCheckCode(), 'T');
  });

  test('test check code char two', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Padova'),
        gender: CodiceFiscaleGender.M,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.getCheckCode(), 'G');
  });

  test('calculate male', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Vicenza'),
        gender: CodiceFiscaleGender.M,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.fiscalCode, 'SNSMCL81R28L840T');
  });

  test('calculate female', () {
    final fiscalCode = CodiceFiscale(
        firstName: 'marco eliseo',
        lastName: 'sanson',
        birthCity: CityDao().getCityByName('Padova'),
        gender: CodiceFiscaleGender.F,
        birthDate: DateTime(1981, 10, 28));
    expect(fiscalCode.fiscalCode, 'SNSMCL81R68G224K');
  });
}
