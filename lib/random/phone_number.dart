import 'dart:math';
import 'dart:io';
import 'dart:convert';

final Map<String, dynamic> countryCodes =
    jsonDecode(File('data/countryCodes.json').readAsStringSync());

Future<String> generate() async {
  final random = Random();

  String countryCode = countryCodes[countryCodes.keys
      .elementAt(random.nextInt(countryCodes.length))]!['countryCode']!;

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

  return phoneNumber;
}

Future<int> main(List<String> args) async {
  print(await generate());
  return 0;
}
