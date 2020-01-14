import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plain_github_keys/custom_errors.dart';
import 'package:plain_github_keys/key_services/KeyService.dart';

class GithubKeyService implements KeyService {
  @override
  String get name => 'github';

  final String _apiUrl;
  final _userNameRegex;

  GithubKeyService([String apiUrl, RegExp userNameRegex])
      : _apiUrl = apiUrl ?? 'api.github.com',
        _userNameRegex = userNameRegex ??
            RegExp('^[a-z\\d](?:[a-z\\d]|-(?=[a-z\\d])){0,38}\$');

  @override
  Future<List<String>> getKeys(String user) async {
    user = user.toLowerCase();

    if (!_userNameRegex.hasMatch(user)) {
      throw WrongUsernameFormatException();
    }

    final uri = Uri.https(_apiUrl, '/users/${user}/keys');
    final resp = await http.get(uri);

    final status = resp.statusCode;

    final decode = json.decode(resp.body);
    if (status == 404) {
      throw UserDoesNotExistException();
    }
    if (status != 200) {
      throw ServiceNotAvailableException(reason: resp);
    }

    final keys = decode as List<dynamic>;

    return List.from(keys.map((e) => e['key']));
  }
}
