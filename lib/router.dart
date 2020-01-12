import 'package:plain_github_keys/keyServiceRouter.dart';
import 'package:plain_github_keys/services/GithubKeyService.dart';
import 'package:shelf_router/shelf_router.dart';

Router getRouter() {
  final services = [
    GithubKeyService(),
  ];

  return KeyServiceRouter(services).getRouter();
}
