import 'dart:async';
import 'dart:convert';

import 'package:notas_bex/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
   final SharedPreferences _preferences;

  AuthRepository(this._preferences);

  Future<String?> getTokenFromPreferences() async {
    return _preferences.getString('token');
  }

  Future<void> saveTokenToPreferences(String token) async {
    await _preferences.setString('token', token);
  }

  Future<void> clearTokenFromPreferences() async {
    await _preferences.remove('token');
  }

  // Guardar el usuario en SharedPreferences
  Future<void> saveUserToPreferences(User user) async {
    final userJson = jsonEncode(user.toMap());
    await _preferences.setString('user', userJson);
  }

  // Obtener el usuario desde SharedPreferences
  Future<User?> getUserFromPreferences() async {
    final userJson = _preferences.getString('user');
    if (userJson != null) {
      return User.fromMap(jsonDecode(userJson));
    }
    return null;
  }

  // Limpiar el usuario de SharedPreferences
  Future<void> clearUserFromPreferences() async {
    await _preferences.remove('user');
  }

 
// Obtener usuario por token (puedes adaptarlo si lo necesitas)
  Future<User?> getUserByToken(String token) async {
    final storedUser = await getUserFromPreferences();
    // Validación adicional si es necesario
    if (storedUser != null) {
      // Si el token coincide con el guardado, se retorna el usuario
      return storedUser;
    }
    return null;
  }


  
}
