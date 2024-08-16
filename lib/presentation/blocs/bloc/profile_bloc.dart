// ignore_for_file: prefer_const_constructors, avoid_print, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notas_bex/data/datasources/note_database_helper.dart';
import 'package:notas_bex/data/models/user_model.dart';
import 'package:notas_bex/domain/repositories/auth_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository;
  final NoteDatabaseHelper _noteDatabaseHelper = NoteDatabaseHelper();

  User user = User(
    id: 0,
    name: '',
    lastName: '',
    phone: "",
    email: "",
    password: "",
  );

  String token = '';

  ProfileBloc(
    this._authRepository,
  ) : super(ProfileInitial()) {
    on<GetUserProfileEvent>(_onGetUserProfile);
    add(GetUserProfileEvent());
    on<UpdateUserProfileEvent>(_onUpdateProfile);
  }

  Future<void> _onGetUserProfile(
      GetUserProfileEvent event, Emitter<ProfileState> emit) async {
    print('getUserProfile');

    emit(ProfileLoading());
    try {
      User userInfo = await _authRepository.getUserFromPreferences() ??
          User(
            id: 0,
            name: '',
            lastName: '',
            phone: "",
            email: "",
            password: "",
          );

      user = userInfo;
      print('user: ${user.toMap()}');

      String tokenInfo = await _authRepository.getTokenFromPreferences() ?? '';

      print('token: $token');
      emit(ProfileSuccess(user: userInfo, token: tokenInfo));
    } catch (e, s) {
      emit(ProfileFailure('Error al obtener el perfil.'));
      print("Error: $e, StackTrace: $s");
    }
  }

  Future<void> _onUpdateProfile(
      UpdateUserProfileEvent event, Emitter<ProfileState> emit) async {
    print('UpdateUserProfileEvent');

    emit(UpdateLoading());
    try {

      await _noteDatabaseHelper.updateUser(event.user);
      await _authRepository.saveUserToPreferences(event.user);
      emit(UpdateSuccess(user));
    } catch (e, s) {
      emit(UpdateFailure('Error al obtener el perfil.'));
      print("Error: $e, StackTrace: $s");
    }
  }
}
