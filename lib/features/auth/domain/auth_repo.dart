abstract class AuthRepo {
  bool loggedIn();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<String> getRole();
  String getUserId();
  void logout();
}