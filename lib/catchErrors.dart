import 'dart:io';

import 'package:plain_github_keys/formatter.dart';
import 'package:shelf/shelf.dart' as shelf;

shelf.Middleware catchErrors() {
  return (shelf.Handler handler) {
    return (shelf.Request request) {
      return Future.sync(() => handler(request)).then((response) {
        if (response == null) {
          return shelf.Response.notFound('Content not found');
        }
        return response;
      }).catchError((error, stackTrace) {
        final result =
            formatter.formatResponse(request, {'message': error.toString()});
        return shelf.Response(HttpStatus.internalServerError,
            body: result.body,
            headers: {HttpHeaders.contentTypeHeader: result.contentType});
      });
    };
  };
}
