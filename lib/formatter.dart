import 'package:shelf_response_formatter/shelf_response_formatter.dart';

ResponseFormatter formatter = ResponseFormatter()
  ..registerFormatter('text', 'text/text', (dynamic data) {
    if (data is Iterable) {
      return data.join('\n');
    }
    return data.toString();
  })..registerFormatter('xml', 'text/xml', (dynamic data) {
    return xmlFormatter(data);
  });
