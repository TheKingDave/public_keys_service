import 'package:plain_github_keys/custom_errors.dart';
import 'package:plain_github_keys/key_services/GithubKeyService.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_test_handler/shelf_test_handler.dart';
import 'package:test/test.dart';

void main() {
  var service = GithubKeyService();

  test('check username regex', () async {
    expect(() async => await service.getKeys('-test'),
        throwsA(TypeMatcher<WrongUsernameFormatException>()));

    expect(() async => await service.getKeys('test-'),
        throwsA(TypeMatcher<WrongUsernameFormatException>()));

    expect(() async => await service.getKeys('-test-'),
        throwsA(TypeMatcher<WrongUsernameFormatException>()));

    expect(() async => await service.getKeys('te#st'),
        throwsA(TypeMatcher<WrongUsernameFormatException>()));

    expect(() async => await service.getKeys('teäst'),
        throwsA(TypeMatcher<WrongUsernameFormatException>()));

    expect(() async => await service.getKeys('te+st'),
        throwsA(TypeMatcher<WrongUsernameFormatException>()));

    expect(() async => await service.getKeys('te]st'),
        throwsA(TypeMatcher<WrongUsernameFormatException>()));
  });
}
