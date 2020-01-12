import 'dart:io';

import 'package:http/http.dart';
import 'package:plain_github_keys/shelf_exception/exception.dart';

class NoServiceException extends HttpException {
  const NoServiceException(String service):
      super(HttpStatus.badRequest, "The service '$service' does not exist");
}

class ServiceNotAvailableException extends HttpException {
  final Response reason;
  final String service;

  const ServiceNotAvailableException({this.reason, this.service}):
        super(HttpStatus.serviceUnavailable, "The service '$service' is not available");
}

class WrongUsernameFormatException extends HttpException {
  final String service;
  final String user;

  const WrongUsernameFormatException([this.service, this.user])
      : super(HttpStatus.badRequest,
            "Wrong username '$user' (format) for service '$service'");
}

class UserDoesNotExistException extends HttpException {
  final String service;
  final String user;

  const UserDoesNotExistException([this.service, this.user])
      : super(HttpStatus.badRequest,
            "The user '$user' does not exist in the service '$service'");
}
