import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Routes imports.
import '../routes/root.dart';
import '../routes/random_data.dart';

// Configure routes.
final _router = Router()
  ..get('/', rootHandler)
  ..get('/random', generateRandomData)
  ..post("/random", generateRandomData);

void main(List<String> args) async {
  int port;
  if (args.contains('--port')) {
    port = int.parse(args[args.indexOf('--port') + 1]);
  } else if (Platform.environment.containsKey('PORT')) {
    // For running in containers, we respect the PORT environment variable.
    port = int.parse(Platform.environment['PORT']!);
  } else {
    print("No port specified, using default port 8080");
    port = 8080;
  }

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
