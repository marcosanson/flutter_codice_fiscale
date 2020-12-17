String extractConsonants(String string) {
  return string.replaceAll(RegExp('[^BCDFGHJKLMNPQRSTVWXYZ]', caseSensitive: false, multiLine: true), '');
}

String extractVowels(String string) {
  return string.replaceAll(RegExp('[^AEIOU]', caseSensitive: false, multiLine: true), '');
}
