import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:plain_github_keys/services/KeyService.dart';
import 'package:plain_github_keys/shelf_exception/exception.dart';

final userNameRegex = RegExp('^[a-z\\d](?:[a-z\\d]|-(?=[a-z\\d])){0,38}\$');

class GithubKeyService implements KeyService {
  @override
  Future<List<String>> getKeys(String user) async {
    user = user.toLowerCase();

    if (!userNameRegex.hasMatch(user)) {
      print("Wrong username: $user");
      throw HttpException(
          HttpStatus.badRequest, 'Wrong username format for service');
    }

    final uri = Uri.https('api.github.com', '/users/${user}/keys');
    final resp = await http.get(uri);

    final decode = json.decode(resp.body);
    if(decode is Map) {
      print(decode);
      throw HttpException(HttpStatus.badRequest, 'This user does not exist in this service');
    }

    final keys = decode as List<dynamic>;

    return List.from(keys.map((e) => e['key']));
  }
}
