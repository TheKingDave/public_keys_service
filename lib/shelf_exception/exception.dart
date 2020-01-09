import 'dart:html';

/// HTTP exception enables to immediately stop request execution
/// and send an appropriate error message to the client. An option
/// Map] data can be provided to add additional information as
/// the response body
class HttpException implements Exception {
  final int status;
  final String message;
  final Map<String, dynamic> data;

  const HttpException(
      [this.status = HttpStatus.internalServerError,
      this.message = 'Internal Server Error',
      this.data]);

  Map<String, dynamic> toMap() {
    final result = {'status': status, 'message': message};
    if (data != null && data.isNotEmpty) {
      data.forEach((name, value) {
        result[name] = value;
      });
    }
    return result;
  }

  @override
  String toString() {
    return 'Status ${status.toString()}: ${message}';
  }
}

/// 400 Bad Request
class BadRequestException extends HttpException {
  const BadRequestException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.badRequest, 'Bad Request${(detail!='' ? ': ' : '')}$detail', data);
}

// 401 Unauthorized
class UnauthorizedException extends HttpException {
  const UnauthorizedException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.unauthorized, 'Unauthorized${(detail!='' ? ': ' : '')}$detail', data);
}

// 402 Payment Required
class PaymentRequiredException extends HttpException {
  const PaymentRequiredException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.paymentRequired, 'Payment Required${(detail!='' ? ': ' : '')}$detail', data);
}

// 403 Forbidden
class ForbiddenException extends HttpException {
  const ForbiddenException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.forbidden, 'Forbidden${(detail!='' ? ': ' : '')}$detail', data);
}

// 404 Not Found
class NotFoundException extends HttpException {
  const NotFoundException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.notFound, 'Not Found${(detail!='' ? ': ' : '')}$detail', data);
}

// 405 Method Not Allowed
class MethodNotAllowed extends HttpException {
  const MethodNotAllowed([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.methodNotAllowed, 'Method Not Allowed${(detail!='' ? ': ' : '')}$detail', data);
}

// 406 Not Acceptable
class NotAcceptableException extends HttpException {
  const NotAcceptableException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.notAcceptable, 'Not Acceptable${(detail!='' ? ': ' : '')}$detail', data);
}

// 409 Conflict
class ConflictException extends HttpException {
  const ConflictException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.conflict, 'Conflict${(detail!='' ? ': ' : '')}$detail', data);
}

// 410 Gone
class GoneException extends HttpException {
  const GoneException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.gone, 'Gone${(detail!='' ? ': ' : '')}$detail', data);
}

// 412 Precondition Failed
class PreconditionFailedException extends HttpException {
  const PreconditionFailedException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.preconditionFailed, 'Precondition Failed${(detail!='' ? ': ' : '')}$detail', data);
}

// 415 Unsupported Media Type
class UnsupportedMediaTypeException extends HttpException {
  const UnsupportedMediaTypeException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.unsupportedMediaType, 'Unsupported Media Type${(detail!='' ? ': ' : '')}$detail',
      data);
}

// 429 Too Many Requests
class TooManyRequestsException extends HttpException {
  const TooManyRequestsException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.tooManyRequests, 'Too Many Requests${(detail!='' ? ': ' : '')}$detail', data);
}

// 501 Not Implemented
class NotimplementedException extends HttpException {
  const NotimplementedException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.notImplemented, 'Not Implemented${(detail!='' ? ': ' : '')}$detail', data);
}

// 503 Service Unavailable
class ServiceUnavailableException extends HttpException {
  const ServiceUnavailableException([Map<String, dynamic> data,
    String detail = ''])
      : super(HttpStatus.serviceUnavailable, 'Service Unavailable${(detail!='' ? ': ' : '')}$detail', data);
}