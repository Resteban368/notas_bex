import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas_bex/data/repositories/note_repostory.dart';
import 'package:notas_bex/domain/repositories/auth_repository.dart';
import 'package:notas_bex/presentation/blocs/auth/auth_bloc.dart';
import 'package:notas_bex/presentation/blocs/bloc/profile_bloc.dart';
import 'package:notas_bex/presentation/blocs/theme/theme_bloc.dart';
import 'package:notas_bex/presentation/config/routes/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/note_database_helper.dart';
import 'presentation/blocs/note/note_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //iniciamos el shared preferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Inicializar la base de datos SQLite
  final noteDbHelper = NoteDatabaseHelper();
  await noteDbHelper.database;

  runApp(MyApp(
    sharedPreferences: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            NoteRepository(),
            AuthRepository(sharedPreferences),
          ),
        ),
        BlocProvider<NoteBloc>(
          create: (context) => NoteBloc()..add(LoadNotesEvent()),
        ),
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(AuthRepository(sharedPreferences))..add(const GetUserProfileEvent())),
      ],
      child: BlocBuilder<ThemeBloc, DarkModeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Notas App',
            routerConfig: appRouter,
            theme: state.theme == AppTheme.light
                ? ThemeData.light(useMaterial3: true)
                : ThemeData.dark(
                    useMaterial3: true,
                  ),
          );
        },
      ),
    );
  }
}
