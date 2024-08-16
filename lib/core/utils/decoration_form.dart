import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_bex/core/utils/app_theme.dart';

import '../../presentation/blocs/theme/theme_bloc.dart';

InputDecoration inputDecorationForm(String labelText, BuildContext context, {IconData? iconData}) {
    return InputDecoration(
      //anchura del campo de texto
      contentPadding: const EdgeInsets.only(left: 14, right: 14),
      labelText: labelText,
      labelStyle: TextStyle(
             fontSize: 13,
      fontFamily: "Poppins",
      color: AppThemeColors.black
      ),
      suffixIcon: iconData != null
          ? Icon(
              iconData,
              // color: MyColors.primary.withOpacity(0.4),
              color: context.watch<ThemeBloc>().state.theme == AppTheme.light
                  ? AppThemeColors.primary.withOpacity(0.4)
                  : AppThemeColors.primary,
            )
          : null,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppThemeColors.primary)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppThemeColors.primary)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppThemeColors.primary)),
    );
  }