import 'dart:io';

import 'package:plain_github_keys/custom_errors.dart';
import 'package:plain_github_keys/formatter.dart';
import 'package:plain_github_keys/services/GithubKeyService.dart';
import 'package:plain_github_keys/services/KeyService.dart';
import 'package:plain_github_keys/shelf_exception/exception.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

final Map<String, KeyService Function()> services = {
  'github': () => GithubKeyService(),
};

Router getRouter() {
  final app = Router();

  app.get('/', (Request request) async {
    return Response.ok(await File('public/index.html').readAsStringSync(),
        headers: {HttpHeaders.contentTypeHeader: ContentType.html.toString()});
  });

  Future<List<String>> _getKeys(String service, String user) async {
    if (!services.containsKey(service)) {
      throw NoServiceException(service);
    }
    try {
      return await services[service]().getKeys(user);
    } on UserDoesNotExistException catch(e) {
      throw UserDoesNotExistException(e.service ?? service, e.user ?? user);
    } on WrongUsernameFormatException catch(e) {
      throw WrongUsernameFormatException(e.service ?? service, e.user ?? user);
    } on ServiceNotAvailableException catch(e) {
      final r = e.reason;
      print('Service not available: ${r.statusCode} ${r.body}');
      throw ServiceNotAvailableException(service: e.service ?? service);
    } catch(e) {
      print(e);
      throw InternalServerErrorException();
    }
  }

  Response _formatResponse(Request request, List<String> keys) {
    final result = formatter.formatResponse(request, keys);

    return Response.ok(result.body,
        headers: {HttpHeaders.contentTypeHeader: result.contentType});
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
