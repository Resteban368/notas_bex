// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_bex/core/utils/validators.dart';
import 'package:notas_bex/data/models/user_model.dart';
import 'package:notas_bex/presentation/blocs/bloc/profile_bloc.dart';
import 'package:notas_bex/presentation/screens/login/widgets/input_decoration.dart';
import 'package:notas_bex/presentation/widgets/custom_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Disparar el evento para obtener el perfil del usuario
    context.read<ProfileBloc>().add(const GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProfileSuccess ) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const CustomAppbar(title: 'Perfil'),
                    const SizedBox(height: 36.0),
                    TextFormField(
                      initialValue: state.user.name,
                      decoration: inputDecorationLogin(
                        labelText: "Nombre",
                        hintText: "Nombre",
                      ),
                      validator: (value) {
                        return Validator.isEmpty(value, context);
                      },
                      onChanged: (value) {
                        context.read<ProfileBloc>().user.name = value;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: state.user.lastName,
                      decoration: inputDecorationLogin(
                        labelText: "Apellido",
                        hintText: "Apellido",
                      ),
                      validator: (value) {
                        return Validator.isEmpty(value, context);
                      },
                      onChanged: (value) {
                        context.read<ProfileBloc>().user.lastName = value;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: state.user.email,
                      decoration: inputDecorationLogin(
                        labelText: "Correo Electrónico",
                        hintText: "Correo Electrónico",
                      ),
                      readOnly: true, // El correo no debería ser editable
                      validator: (value) {
                        return Validator.email(value, context);
                      },
                      onChanged: (value) {
                        context.read<ProfileBloc>().user.email = value;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: state.user.phone,
                      decoration: inputDecorationLogin(
                        labelText: "Teléfono",
                        hintText: "Teléfono",
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        return Validator.isEmpty(value, context);
                      },
                      onChanged: (value) {
                        context.read<ProfileBloc>().user.phone = value;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: state.token,
                      decoration: inputDecorationLogin(
                        labelText: "Token",
                        hintText: "Token",
                      ),
                      readOnly: true, // El token no debería ser editable
                      validator: (value) {
                        return Validator.isEmpty(value, context);
                      },
                      onChanged: (value) {
                        context.read<ProfileBloc>().token = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     minimumSize: const Size(double.infinity, 50),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 20, vertical: 6),
                    //   ),
                    //   onPressed: () {
                    //     if (!_formKey.currentState!.validate()) return;

                    //     User user = User(
                    //         name: context.read<ProfileBloc>().user.name,
                    //         lastName: context.read<ProfileBloc>().user.lastName,
                    //         email: context.read<ProfileBloc>().user.email,
                    //         phone: context.read<ProfileBloc>().user.phone,
                    //         password:
                    //             context.read<ProfileBloc>().user.password);

                    //       print('user: ${user.toMap()}');

                    //     // context.read<ProfileBloc>().add(
                    //     //       UpdateUserProfileEvent(user),
                    //     //     );
                    //     // Lógica para guardar los cambios, si es necesario
                    //   },
                    //   child: const Text('Guardar Cambios'),
                    // ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: Text('Estado desconocido')),
        );
      },
    );
  }
}
