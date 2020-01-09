import 'package:shelf_response_formatter/shelf_response_formatter.dart';

ResponseFormatter formatter = ResponseFormatter()
  ..registerFormatter('text', 'text/text', (dynamic data) {
    if (data is Iterable) {
      return data.join('\n');
    }
    if (data is Map) {
      if (data.containsKey('message')) {
        return data['message'];
      } else {
        var ret = '';
        for (String key in data.keys) {
          ret += '$key: ${data[key]}\n';
        }
        return ret;
      }
    }
    return data.toString();
  })..registerFormatter('xml', 'text/xml', (dynamic data) {
    return xmlFormatter(data);
  });
