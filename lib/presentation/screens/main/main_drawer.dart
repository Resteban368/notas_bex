// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:notas_bex/presentation/screens/screens.dart';

import '../../blocs/theme/theme_bloc.dart';

class MainDrawerScreen extends StatefulWidget {
  const MainDrawerScreen({Key? key}) : super(key: key);

  @override
  State<MainDrawerScreen> createState() => _MainDrawerScreenState();
}

class _MainDrawerScreenState extends State<MainDrawerScreen> {
  Widget page = HomeScreen();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ZoomDrawer(
        menuScreen: MenuScreen(
          onPageChanged: (a) {
            setState(() {
              page = a;
            });
          },
        ),
        mainScreen: page,
        borderRadius: 24.0,
        showShadow: true,
        drawerShadowsBackgroundColor: Colors.grey[300]!,
        menuBackgroundColor: colors.primary);
  }
}

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key, required this.onPageChanged}) : super(key: key);

  final Function(Widget) onPageChanged;

  List<ListItems> drawerItems = [
    ListItems(title: 'Home', icon: Icons.home, widget: HomeScreen()),
    ListItems(title: 'Perfil', icon: Icons.toc, widget: ProfileScreen()),
    ListItems(
        title: 'Notas', icon: Icons.favorite, widget: const NoteListScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 200, left: 15, right: 15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                ZoomDrawer.of(context)!.close();
                onPageChanged(HomeScreen());
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                ZoomDrawer.of(context)!.close();
                onPageChanged(ProfileScreen());
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.note),
              title: const Text('Notas'),
              onTap: () {
                ZoomDrawer.of(context)!.close();
                onPageChanged(const NoteListScreen());
              },
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              // height: 70,
              padding: const EdgeInsets.only(left: 20),
              child:
                  //ponemo sun raised button para el modo oscuro
                  BlocBuilder<ThemeBloc, DarkModeState>(
                builder: (context, state) {
                  return SwitchListTile.adaptive(
                      value: state.theme == AppTheme.dark,
                      title: const Text('Tema'),
                      // activeColor: const Color.fromARGB(255, 7, 61, 111),
                      onChanged: (value) {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ToggleDarkMode());
                      });
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ListItems {
  final String title;
  final IconData icon;
  final Widget widget;

  ListItems({
    required this.title,
    required this.icon,
    required this.widget,
  });
}
