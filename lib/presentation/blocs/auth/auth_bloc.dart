// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notas_bex/core/utils/token_generator.dart';
import 'package:notas_bex/data/models/user_model.dart';
import 'package:notas_bex/data/repositories/note_repostory.dart';
import 'package:notas_bex/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final NoteRepository noteRepository;

  final AuthRepository _authRepository;

  final TokenGenerator tokenGenerator = TokenGenerator();

  User user = User(
    id: 0,
    name: '',
    lastName: '',
    phone: "",
    email: "",
    password: "",
  );

  String email = ''; //
  String password = ''; //
  bool isVisible = true;

  AuthBloc(this.noteRepository, this._authRepository) : super(AuthInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);

    on<TogglePasswordVisibility>((event, emit) {
      isVisible = !isVisible;
      emit(PasswordVisibilityToggled(isVisible));
    });

    on<LoginUserEvent>(_onLoginUser);
    on<CheckSessionEvent>(_onCheckSession);

    on<LogoutEvent>(_onLogout);

    // on<UpdateUserProfileEvent>(_onUpdateUserProfile);
  }

  Future<void> _onRegisterUser(
      RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final existingUser = await noteRepository.getUserByEmail(user.email);
      if (existingUser != null) {
        emit(const AuthFailure('El correo electrónico ya está registrado.'));
      } else {
        await noteRepository.registerUser(user);
        String token = tokenGenerator.generateToken(25);
        emit(AuthSuccess(user: user, token: token));
        _authRepository.saveTokenToPreferences(token);
        _authRepository.saveUserToPreferences(user);
        user = User(
          id: 0,
          name: '',
          lastName: '',
          phone: "",
          email: "",
          password: "",
        );
      }
    } catch (e, s) {
      emit(const AuthFailure('Error al registrar el usuario.'));
      print("Error: $e, StackTrace: $s");
    }
  }

  Future<void> _onLoginUser(
      LoginUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await noteRepository.getUserByEmail(email);
      if (user != null && user.password == password) {
        String token = tokenGenerator.generateToken(25);
        print('token: $token');
        emit(AuthSuccess(user: user, token: token));
        _authRepository.saveTokenToPreferences(token);
        _authRepository.saveUserToPreferences(user);
      } else {
        emit(const AuthFailure('Correo o contraseña incorrectos.'));
      }
    } catch (e) {
      emit(const AuthFailure('Error al iniciar sesión.'));
    }
  }

  Future<void> _onCheckSession(
      CheckSessionEvent event, Emitter<AuthState> emit) async {

    final token = await _authRepository.getTokenFromPreferences();

    if (token != null && token.isNotEmpty) {
      final user = await _authRepository.getUserFromPreferences();

      if (user != null) {
        final newToken = tokenGenerator.generateToken(25);
        await _authRepository.saveTokenToPreferences(newToken);
        emit(AuthAuthenticated(user: user, token: newToken));
      } else {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _authRepository.clearTokenFromPreferences();
    await _authRepository.clearUserFromPreferences();
    // emit(AuthUnauthenticated());
  }

  // Future<void> _onUpdateUserProfile(
  //     UpdateUserProfileEvent event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   try {
  //     await _noteRepository.updateUser(event.user);
  //     emit(AuthSuccess(
  //         user: event.user, token: event.token)); // Mantiene el token actual
  //   } catch (e) {
  //     emit(AuthFailure('Error al actualizar el perfil.'));
  //   }
  // }

 
}
