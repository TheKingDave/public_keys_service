import 'dart:convert';

import 'package:plain_github_keys/github.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Router getRouter() {
  final app = Router();
  
  app.get('/', (Request request) {
    return Response.ok('hello world');
  });

  app.get('/api/<user>', (Request request, String user) async {
    final result = await getGithubKeys(user);
    return Response.ok(json.encode(result));
  });

  app.get('/api/<service>/<user>', (Request request, String service, String user) {
    return Response.ok('Hello $user from $service');
  });

  return app;
}