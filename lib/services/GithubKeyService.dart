import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plain_github_keys/custom_errors.dart';
import 'package:plain_github_keys/services/KeyService.dart';

final userNameRegex = RegExp('^[a-z\\d](?:[a-z\\d]|-(?=[a-z\\d])){0,38}\$');

class GithubKeyService implements KeyService {
  @override
  Future<List<String>> getKeys(String user) async {
    user = user.toLowerCase();

    if (!userNameRegex.hasMatch(user)) {
      throw WrongUsernameFormatException();
    }

    final uri = Uri.https('api.github.com', '/users/${user}/keys');
    final resp = await http.get(uri);

    final decode = json.decode(resp.body);
    if(decode is Map) {
      throw UserDoesNotExistException();
    }

    final keys = decode as List<dynamic>;

    return List.from(keys.map((e) => e['key']));
  }
}
