// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notas_bex/core/utils/app_theme.dart';
import 'package:notas_bex/core/utils/validators.dart';
import 'package:notas_bex/presentation/blocs/auth/auth_bloc.dart';
import 'package:notas_bex/presentation/screens/login/widgets/input_decoration.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio de Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // Navegar a la pantalla principal si el login es exitoso
              context.go('/main');
            } else if (state is AuthFailure) {
              // Mostrar un mensaje de error si el login falla
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Notas Bex",
                      style: TextStyle(
                          fontSize: 66,
                          color: AppThemeColors.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins")),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        color: AppThemeColors.white,
                        fontSize: 14,
                        fontFamily: "Poppins"),
                    decoration: inputDecorationLogin(
                      labelText: "Correo electrónico",
                      hintText: "Correo electrónico",
                    ),
                    validator: (value) {
                      return Validator.email(value, context);
                    },
                    onChanged: (value) =>
                        context.read<AuthBloc>().email = value,
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: context.watch<AuthBloc>().isVisible,
                    decoration: inputDecorationLogin(
                      labelText: "Contraseña",
                      hintText: "Contraseña",
                      iconButton: IconButton(
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(TogglePasswordVisibility());
                        },
                        icon: Icon(
                          context.watch<AuthBloc>().isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppThemeColors.white,
                        ),
                      ),
                    ),
                    validator: (value) {
                      return Validator.password(value, context);
                    },
                    onChanged: (value) =>
                        context.read<AuthBloc>().password = value,
                  ),

                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                    ),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      // Disparar el evento de login
                      context.read<AuthBloc>().add(LoginUserEvent());
                    },
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const CircularProgressIndicator();
                        }
                        return const Text('Iniciar Sesión');
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  //texto de crear cuenta subrayado
                  GestureDetector(
                    onTap: () {
                      context.push("/register");
                    },
                    child: Text(
                      "Crear cuenta",
                      style: TextStyle(
                        color: AppThemeColors.white,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        decoration: TextDecoration.underline,
                        //color de la linea
                        decorationColor: AppThemeColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
