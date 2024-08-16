part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends AuthEvent {}

class LoginUserEvent extends AuthEvent {}

class UpdateUserProfileEvent extends AuthEvent {
  final User user;
  final String token;

  const UpdateUserProfileEvent(this.user, this.token);

  @override
  List<Object> get props => [user, token];
}

class TogglePasswordVisibility extends AuthEvent {}

class CheckSessionEvent extends AuthEvent {}


class LogoutEvent extends AuthEvent {}