part of 'auth_bloc.dart';


abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthChecking extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  final String token;

  const AuthSuccess({required this.user, required this.token});

  @override
  List<Object> get props => [user, token];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PasswordVisibilityToggled extends AuthState {
   PasswordVisibilityToggled(bool isVisible) : super();
}

class AuthAuthenticated extends AuthState {
  final User user;
  final String token;

  AuthAuthenticated({required this.user, required this.token});
}

class AuthUnauthenticated extends AuthState {}

