import 'dart:io';

import 'package:plain_github_keys/shelf_exception/exception.dart';

class NoServiceException extends HttpException {
  const NoServiceException(String service):
      super(HttpStatus.badRequest, "The service '$service' does not exist");
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
