abstract class LocalStorage{
  void saveValue(String key, dynamic value);
  Future<dynamic> readValue(String key);
  void deleteAll();
}