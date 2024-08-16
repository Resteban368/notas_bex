// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:notas_bex/presentation/blocs/auth/auth_bloc.dart';
import 'package:notas_bex/presentation/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

//
class CustomAppbar extends StatelessWidget {
  final String title;

  const CustomAppbar({
    Key? key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: Icon(Icons.menu, color: colors.primary),
              ),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 190, 89, 208),
                  highlightColor: const Color.fromARGB(255, 68, 33, 243),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () async {
                    context.go('/login');
                    context.read<AuthBloc>().add(LogoutEvent());
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class MovieBloc {}
