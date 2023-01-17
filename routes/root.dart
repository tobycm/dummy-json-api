import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../constants/api_info.dart';

Response rootHandler(Request request) {
  return Response.ok(jsonEncode(apiInfo));
}
