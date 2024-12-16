import 'package:coffee_app/features/auth/domain/auth_repo.dart';
import 'package:coffee_app/features/auth/presentation/cubits/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthInitial()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    final loggedIn = authRepo.loggedIn();

    if (loggedIn) {
      await authenticate();
    }

    // not logged in
    else {
      emit(Unauthenticated());
    }
  }

  Future<void> authenticate() async {
    final role = await authRepo.getRole();
    emit(Authenticated(role: role));
  }

  void logout() {
    authRepo.logout();
    emit(Unauthenticated());
  }

  Future<void> login(String email, String password) async {
    await authRepo.login(email, password);
  }

  Future<void> register(String email, String password) async {
    await authRepo.register(email, password);
  }
}
