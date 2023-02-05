import 'dart:convert';
import 'package:shelf/shelf.dart';

import 'package:dummy_json_api/request/validator.dart';

import 'package:dummy_json_api/random/phone_number.dart' as phone_number;

Future<Response> generateRandomData(Request request) async {
  final requestData = await checkRequest(request);
  if (requestData is Response) {
    return requestData;
  }
  requestData as List<RequestDataNode>;

  Map<String, dynamic> returnData = {};

  for (var query in requestData) {
    List<dynamic> data = <dynamic>[];
    for (var i = 0; i < query.looping; i++) {
      var node_data;
      if (query.requireData == "phone_number") {
        node_data = await phone_number.generate();
      }
      data.add(node_data);
    }
    returnData[query.requireData] = data;
  }

  return Response.ok(jsonEncode(returnData));
}
