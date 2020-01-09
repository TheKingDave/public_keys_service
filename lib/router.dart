import 'dart:convert';
import 'dart:io';

import 'package:plain_github_keys/services/GithubKeyService.dart';
import 'package:plain_github_keys/services/KeyService.dart';
import 'package:plain_github_keys/shelf_exception/exception.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_response_formatter/shelf_response_formatter.dart';
import 'package:shelf_router/shelf_router.dart';

final Map<String, KeyService Function()> services = {
  'github': () => GithubKeyService(),
};

final Map<String, String Function(List<String> keys)> formats = {
  'text/text': (keys) => keys.join('\n'),
  'application/json': (keys) => json.encode(keys),
  'application/xml': (keys) => xmlFormatter(keys),
  'text/xml': (keys) => xmlFormatter(keys),
};

Router getRouter() {
  final app = Router();

  app.get('/', (Request request) {
    return Response.ok('hello world');
  });

  Future<List<String>> _getKeys(String service, String user) {
    if (!services.containsKey(service)) {
      throw BadRequestException({'message': 'Service does not exist'});
    }
    return services[service]().getKeys(user);
  }

  Response _formatResponse(Request request, List<String> keys) {
    final accepts = request.headers[HttpHeaders.acceptHeader];

    final use = formats.keys.firstWhere((f) => accepts.contains(f),
        orElse: () => formats.keys.first);
    print(use);

    return Response.ok(formats[use](keys));
  }

  app.get('/api/keys/<user>', (Request request, String user) async {
    return _formatResponse(request, await _getKeys('github', user));
  });

  app.get('/api/keys/<service>/<user>',
      (Request request, String service, String user) async {
    return _formatResponse(request, await _getKeys(service, user));
  });

  app.get('/api/services', (Request request) {
    return _formatResponse(request, List.from(services.keys));
  });

  return app;
}
