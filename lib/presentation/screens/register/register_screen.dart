// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notas_bex/core/utils/app_theme.dart';
import 'package:notas_bex/core/utils/validators.dart';
import 'package:notas_bex/presentation/blocs/auth/auth_bloc.dart';
import 'package:notas_bex/presentation/screens/login/widgets/input_decoration.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/main');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
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
                    decoration: inputDecorationLogin(
                      labelText: "Nombre",
                      hintText: "Nombre",
                    ),
                    validator: (value) {
                      return Validator.isEmpty(value, context);
                    },
                    onChanged: (value) {
                      context.read<AuthBloc>().user.name = value;
                    }

                    ),
                const SizedBox(height: 16.0),
                TextFormField(
                    decoration: inputDecorationLogin(
                      labelText: "Apellidos",
                      hintText: "Apellidos",
                    ),
                    validator: (value) {
                      return Validator.isEmpty(value, context);
                    },
                    onChanged: (value) {
                      context.read<AuthBloc>().user.lastName = value;
                    }
                    ),
                const SizedBox(height: 16.0),
                TextFormField(
                    decoration: inputDecorationLogin(
                      labelText: "Correo electrónico",
                      hintText: "Correo electrónico",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return Validator.email(value, context);
                    },
                    onChanged: (value) {
                      context.read<AuthBloc>().user.email = value;
                    }
                    ),
                const SizedBox(height: 16.0),
                TextFormField(
                    decoration: inputDecorationLogin(
                      labelText: "Teléfono",
                      hintText: "Teléfono",
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      return Validator.isEmpty(value, context);
                    },
                    onChanged: (value) {
                      context.read<AuthBloc>().user.phone = value;
                    }
                    ),
                const SizedBox(height: 16.0),
                TextFormField(
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
                    onChanged: (value) {
                      context.read<AuthBloc>().user.password = value;
                    }
                    ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    context.read<AuthBloc>().add(RegisterUserEvent());
                  },
                  child: const Text('Registrarse'),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    context.push("/login");
                  },
                  child: Text(
                    "Iniciar sesión",
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
          ),
        ),
      ),
    );
  }
}
