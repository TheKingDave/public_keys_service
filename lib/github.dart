import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> getGithubKeys(String user) async {
  final uri = Uri.https('api.github.com', '/users/$user/keys');
  final resp = await http.get(uri);

  final decode = json.decode(resp.body) as List<dynamic>;

  return List.from(decode.map((e) => e['key']));
}