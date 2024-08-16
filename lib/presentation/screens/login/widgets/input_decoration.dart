import 'package:flutter/material.dart';
import 'package:notas_bex/core/utils/app_theme.dart';


InputDecoration inputDecorationLogin(
      {String? hintText, required String labelText, IconButton? iconButton}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      labelText: labelText,
      hintText: hintText,
      errorStyle:  TextStyle(color: AppThemeColors.white, fontFamily: "Poppins"),

      hintStyle:  TextStyle(
          color: AppThemeColors.white, fontSize: 14, fontFamily: "Poppins"),
      labelStyle:  TextStyle(color: AppThemeColors.white, fontFamily: "Poppins"),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppThemeColors.primary),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppThemeColors.primary),
      ),
      errorBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: AppThemeColors.white),
      ),

      //icono al final del input
      suffixIcon: iconButton,
      fillColor: AppThemeColors.primary.withOpacity(0.5),
      filled: true,
    );
  }