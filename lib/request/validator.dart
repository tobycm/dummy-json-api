import 'package:shelf/shelf.dart';

Future<dynamic> checkRequest(Request request) async {
  if (request.method != 'GET') {
    return Response.badRequest(body: 'Invalid method');
  }

  if ((request.url.queryParameters['data'] == null) |
      (request.url.queryParameters['data'] == '')) {
    return Response.badRequest(body: 'Missing data parameter');
  }

  final requestData = request.url.queryParameters['data']!.split(',');
  if (requestData.isEmpty) {
    return Response.badRequest(body: 'Invalid data parameter');
  }

  return requestData;
}
