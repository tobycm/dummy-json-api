import 'dart:convert';
import 'package:shelf/shelf.dart';

import 'package:dummy_json_api/request/validator.dart';

import 'package:dummy_json_api/random/phone_number.dart' as phone_number;

Future<Response> generateRandomData(Request request) async {
  final requestData = await checkRequest(request);

  if (requestData is Response) {
    return requestData;
  }
  requestData as List<String>;

  Map<String, String> returnData = {};

  if (requestData.contains('phone_number')) {
    returnData = await phone_number.generate();
  }

  return Response.ok(jsonEncode(returnData));
}
