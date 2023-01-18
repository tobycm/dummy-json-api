import 'dart:math';
import 'dart:io';
import 'dart:convert';

final Map<String, dynamic> countryCodes =
    jsonDecode(File('data/countryCodes.json').readAsStringSync());

Future<Map<String, String>> generate() async {
  final random = Random();

  final Map<String, dynamic> countryCodeInfo = countryCodes[
      countryCodes.keys.elementAt(random.nextInt(countryCodes.length))];

  final String country = countryCodeInfo['isoCode']!;
  String countryCode = countryCodeInfo['countryCode']!;

  String areaCode = '';

  if (countryCode.contains("-")) {
    areaCode = countryCode.split("-")[1];
    countryCode = countryCode.split("-")[0];
  }

  String phoneNumber = '+$countryCode$areaCode';

  int numberLength = 10;

  if (areaCode != '') {
    numberLength = 7;
  }

  for (var i = 0; i < numberLength; i++) {
    phoneNumber += random.nextInt(10).toString();
  }

  return {'phone_number': phoneNumber, 'country': country};
}

Future<int> main(List<String> args) async {
  print(await generate());
  return 0;
}
