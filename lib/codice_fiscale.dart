library codice_fiscale;

import 'package:flutter_codice_fiscale/utils/constants.dart';
import 'package:flutter_codice_fiscale/utils/helpers.dart';
import 'package:flutter/material.dart';

import 'models/city.dart';
import 'dao/city_dao.dart';

enum CodiceFiscaleGender { M, F }

class CodiceFiscale {
  String firstName, lastName;
  City birthCity;
  CodiceFiscaleGender gender;
  DateTime birthDate;
  String birthCityString;
  String _fiscalCode;

  CodiceFiscale(
      {@required this.firstName,
      @required this.lastName,
      @required this.birthCity,
      @required this.gender,
      @required this.birthDate})
      : assert(firstName != null && firstName.isNotEmpty),
        assert(lastName != null && lastName.isNotEmpty),
        assert(birthCity != null),
        assert(gender != null),
        assert(birthDate != null) {
    _fiscalCode = '${lastNameCode()}${firstNameCode()}${birthDateCode()}${birthPlaceCode()}${getCheckCode()}';
  }

  CodiceFiscale.searchcity(
      {@required this.firstName,
      @required this.lastName,
      @required this.birthCityString,
      @required this.gender,
      @required this.birthDate})
      : assert(firstName != null && firstName.isNotEmpty),
        assert(lastName != null && lastName.isNotEmpty),
        assert(birthCityString != null && birthCityString.isNotEmpty),
        assert(gender != null),
        assert(birthDate != null) {
    this.birthCity = CityDao().getCityByName(birthCityString);
    _fiscalCode = '${lastNameCode()}${firstNameCode()}${birthDateCode()}${birthPlaceCode()}${getCheckCode()}';
  }

  static bool check(String codiceFiscale) {
    if (codiceFiscale == null) {
      return false;
    }

    String cf = codiceFiscale.toUpperCase();
    if (cf.length != 16) {
      return false;
    }
    if (!RegExp(r'^[A-Z]{6}[0-9LMNPQRSTUV]{2}[ABCDEHLMPRST]{1}[0-9LMNPQRSTUV]{2}[A-Z]{1}[0-9LMNPQRSTUV]{3}[A-Z]{1}$')
        .hasMatch(cf)) {
      return false;
    }
    final expectedCheckCode = codiceFiscale[15];
    cf = codiceFiscale.substring(0, 15);
    return _getCheckCode(cf).toUpperCase() == expectedCheckCode.toUpperCase();
  }

  String get fiscalCode => _fiscalCode;

  // Useful methods

  String lastNameCode() {
    final String code = extractConsonants(this.lastName);
    return code.substring(0, 3).toUpperCase();
  }

  String firstNameCode() {
    String code = extractConsonants(this.firstName);
    if (code.length >= 4) {
      code = '${code[0]}${code[2]}${code[3]}';
    } else {
      code += '${extractVowels(this.firstName)}XXX';
      code = code.substring(0, 3);
    }
    return code.toUpperCase();
  }

  String birthDateCode() {
    String year = '${this.birthDate.year.toString()[2]}${this.birthDate.year.toString()[3]}';
    String month = MONTH_CODES[this.birthDate.month - 1];
    int dayInt = this.birthDate.day;
    if (gender == CodiceFiscaleGender.F) {
      dayInt += 40;
    }
    String day = '0$dayInt';
    day = day.substring(day.length - 2, day.length);
    return '$year$month$day';
  }

  String birthPlaceCode() {
    return birthCity.code;
  }

  static String _getCheckCode(String partialFiscalCode) {
    int val = 0;
    for (int i = 0; i < 15; i = i + 1) {
      final String c = partialFiscalCode[i];
      val += (i % 2 != 0 ? CHECK_CODE_EVEN[c.toString()] : CHECK_CODE_ODD[c.toString()]);
    }
    val = val % 26;
    return CHECK_CODE_CHARS[val];
  }

  String getCheckCode() {
    String partialFiscalCode = '${lastNameCode()}${firstNameCode()}${birthDateCode()}${birthPlaceCode()}';
    return _getCheckCode(partialFiscalCode);
  }
}
