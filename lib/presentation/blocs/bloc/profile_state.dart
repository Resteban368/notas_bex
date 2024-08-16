part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  
  const ProfileState();

  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}


final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final User user;
  final String token;

  const ProfileSuccess({required this.user, required this.token});

  @override
  List<Object> get props => [user, token];
}

final class ProfileFailure extends ProfileState {
  final String error;

  const ProfileFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class UpdateLoading extends ProfileState {}

final class UpdateSuccess extends ProfileState {
  final User user;

  const UpdateSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class UpdateFailure extends ProfileState {
  final String error;

  const UpdateFailure(this.error);

  @override
  List<Object> get props => [error];
}