import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Router getRouter() {
  final app = Router();
  
  app.get('/', (Request request) {
    return Response.ok('hello world');
  });

  app.get('/<user>', (Request request, String user) {
    return Response.ok('Hello $user');
  });

  return app;
}