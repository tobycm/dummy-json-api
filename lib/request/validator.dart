import 'dart:convert';
import 'dart:math';

import 'package:shelf/shelf.dart';

Future<dynamic> checkRequest(Request request) async {
  List<RequestDataNode> requestData = <RequestDataNode>[];
  if (request.method == "GET") {
    if ((request.url.queryParameters['data'] == null) |
        (request.url.queryParameters['data'] == '')) {
      return Response.badRequest(body: 'Missing data parameter');
    }

    final rawData = request.url.queryParameters['data']!.split(',');
    if (rawData.isEmpty) {
      return Response.badRequest(body: 'Invalid data parameter');
    }

    for (var data in rawData) {
      if (data.indexOf(";") >= 1) {
        final option = data.split(";");
        var numberOfDoc = int.tryParse(option[1]);
        if (numberOfDoc == null) {
          return Response.badRequest(body: "Invalid option");
        }
        requestData.add(RequestDataNode(option[0], numberOfDoc));
      } else {
        requestData.add(RequestDataNode(data, 1));
      }
    }
  } else if (request.method == "POST") {
    var body = jsonDecode(await request.readAsString(request.encoding));
    if (body is! List<dynamic>) {
      return Response.badRequest(body: 'Invalid body');
    }
    for (var element in body) {
      if (element is! Map<String, dynamic>) {
        return Response.badRequest(body: 'Invalid body');
      }
      if (element["name"] is! String) {
        return Response.badRequest(body: 'Invalid body');
      }
      var name = element["name"];
      var looping = 1;
      if (element["looping"] is int) {
        looping = element["looping"];
      }
      requestData.add(RequestDataNode(name, looping));
    }
  } else {
    return Response.badRequest(body: 'Invalid method');
  }
  return requestData;
}

class RequestDataNode {
  String requireData;
  int looping;
  RequestDataNode(this.requireData, this.looping);
}
