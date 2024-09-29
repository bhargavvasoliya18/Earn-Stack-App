class PhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;
  String validationMsg;

  PhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
    this.validationMsg = ''
  });

  String get completeNumber {
    return countryCode + number;
  }

  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
