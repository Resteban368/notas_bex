import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notas_bex/core/utils/app_theme.dart';
import 'package:notas_bex/presentation/blocs/auth/auth_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();

  //   // Disparar el evento para verificar la sesión
  //   context.read<AuthBloc>().add(CheckSessionEvent());

  //   // Escuchar el estado de autenticación
  //   context.read<AuthBloc>().stream.listen((state) {
  //     if (state is AuthAuthenticated) {
  //       // Si el usuario ya está autenticado, redirigir al HomeScreen
  //       context.go('/main');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Bienvenido ${state.user.name}")),
  //       );
  //     } else if (state is AuthUnauthenticated) {
  //       // Si no está autenticado, redirigir al LoginScreen
  //       context.go('/login');
  //     }
  //   });
  // }
  void initState() {
  super.initState();

  // Disparar el evento para verificar la sesión
  context.read<AuthBloc>().add(CheckSessionEvent());

  // Escuchar el estado de autenticación
  context.read<AuthBloc>().stream.listen((state) {
    if (state is AuthAuthenticated) {
      // Si el usuario ya está autenticado, redirigir al HomeScreen
      context.go('/main');
      
    } else if (state is AuthUnauthenticated) {
      // Si no está autenticado, redirigir al LoginScreen
      context.go('/login');
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BounceInDown(
              duration: const Duration(seconds: 2),
              child: const Text(
                "Notas Bex",
                style: TextStyle(
                  fontSize: 66,
                  color: AppThemeColors.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Shimmer.fromColors(
              baseColor: const Color.fromARGB(255, 75, 71, 75),
              highlightColor: AppThemeColors.primary,
              child: Icon(
                Icons.note,
                color: Theme.of(context).colorScheme.primary,
                size: 180,
              ),
            ).animate().rotate(
                  begin: 0.1,
                  duration: 450.ms,
                  delay: 200.ms,
                  alignment: Alignment.topCenter,
                ),
          ],
        ),
      ),
    );
  }
}
