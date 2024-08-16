part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}


class GetUserProfileEvent extends ProfileEvent {
  const GetUserProfileEvent();
}

class UpdateUserProfileEvent extends ProfileEvent {
  final User user;

  const UpdateUserProfileEvent(this.user);

  @override
  List<Object> get props => [user];
}

