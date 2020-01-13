import 'dart:io';

import 'package:plain_github_keys/keyServiceRouter.dart';
import 'package:plain_github_keys/key_services/GithubKeyService.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

Router getRouter() {
  final services = [
    GithubKeyService(),
  ];

  final app = Router();

  app.mount('/api/', KeyServiceRouter(services).router);

  app.get('/<ignored|.*>',
      createStaticHandler('public', defaultDocument: 'index.html'));

  return app;
}
