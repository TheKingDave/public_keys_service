import 'dart:io';

import 'package:plain_github_keys/formatter.dart';
import 'package:plain_github_keys/shelf_exception/exception.dart';
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
        print('Error caught: ${error.toString()}');
        print(stackTrace);

        final e = HttpException();
        final result = formatter.formatResponse(request, e.toMap());
        return shelf.Response(HttpStatus.internalServerError,
            body: result.body,
            headers: {HttpHeaders.contentTypeHeader: result.contentType});
      });
    };
  };
}
