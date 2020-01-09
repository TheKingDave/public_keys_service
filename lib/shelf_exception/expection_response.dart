import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;

import '../formatter.dart';
import 'exception.dart';

///A middleware that allows handlers to simply throw [HttpExceptions]
///instead of having to create and return a non successful [Response].
///
///Example:
///(request) {
///   if(notA) {
///     throw(301, "You have to be A");
///   }
///   return new Response();
///}
shelf.Middleware exceptionResponse() {
  return (shelf.Handler handler) {
    return (shelf.Request request) {
      return Future.sync(() => handler(request))
          .then((response) => response)
          .catchError((error, stackTrace) {
        final result = formatter.formatResponse(request, error.toMap());
        return shelf.Response(error.status,
            body: result.body,
            headers: {HttpHeaders.contentTypeHeader: result.contentType});
      }, test: (e) => e is HttpException);
    };
  };
}
