import 'package:coffee_app/features/auth/domain/auth_repo.dart';
import 'package:coffee_app/main.dart';

class SupabaseAuthRepo implements AuthRepo {
  @override
  bool loggedIn() {
    return supabase.auth.currentUser != null;
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<void> register(String email, String password) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  @override
  Future<String> getRole() async {
    try {
      final user = supabase.auth.currentUser!;
      final response =
          await supabase.from('profiles').select().eq('id', user.id).single();
      final role = response['role'];
      return role;
    } catch (e) {
      throw Exception('Failed to get user role: $e');
    }
  }

  @override
  String getUserId() {
    return supabase.auth.currentUser!.id;
  }

  @override
  void logout() {
    supabase.auth.signOut();
  }
}
