import 'dart:convert';
import 'package:shelf/shelf.dart';

const apiInfo = {
  "made_by": "tobycm on GitHub",
  "discord": "https://discord.com/users/487597510559531009"
};

Response rootHandler(Request request) {
  return Response.ok(jsonEncode(apiInfo));
}
