import 'dart:io';

import 'package:plain_github_keys/key_services/KeyService.dart';
import 'package:plain_github_keys/shelf_exception/exception.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'custom_errors.dart';
import 'formatter.dart';

class KeyServiceRouter {
  final List<KeyService> serviceList;
  final Map<String, KeyService> services = {};

  KeyServiceRouter(this.serviceList) {
    for(var service in serviceList) {
      services.putIfAbsent(service.name, () => service);
    }
  }

  Router get router {
    final app = Router();

    Future<List<String>> _getKeys(String service, String user) async {
      if (!services.containsKey(service)) {
        throw NoServiceException(service);
      }
      try {
        return await services[service].getKeys(user);
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

    app.get('/keys/<user>', (Request request, String user) async {
      return _formatResponse(request, await _getKeys('github', user));
    });

    app.get('/keys/<service>/<user>',
            (Request request, String service, String user) async {
          return _formatResponse(request, await _getKeys(service, user));
        });

    app.get('/services', (Request request) {
      return _formatResponse(request, List.from(services.keys));
    });

    return app;
  }
}