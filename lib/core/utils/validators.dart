import 'package:flutter/material.dart';

class Validator {
  Validator();

  static String? isEmpty(String? value, BuildContext context) {
    if (value?.isEmpty ?? true) {
      return "Este campo es obligatorio";
    } else {
      return null;
    }
  }

  //validacion de email
  static String? email(String? value, BuildContext context) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  static String? passwordConfirm(
      String? value, String? password, BuildContext context) {
    if (value! != password) {
      return "Las contraseñas no coinciden";
    } else {
      return null;
    }
  }


  static String? password(String? value, BuildContext context) {
    if (value!.length < 8) {
      return "La contraseña debe tener al menos 8 caracteres";
    } else {
      return null;
    }
  }


}