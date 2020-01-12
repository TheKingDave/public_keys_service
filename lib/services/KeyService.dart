abstract class KeyService {
  String get name;

  Future<List<String>> getKeys(String user);
}