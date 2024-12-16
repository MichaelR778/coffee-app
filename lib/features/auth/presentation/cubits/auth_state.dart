abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String role;

  Authenticated({required this.role});
}

class Unauthenticated extends AuthState {}
