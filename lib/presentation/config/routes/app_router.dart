import 'package:go_router/go_router.dart';

import '../../screens/screens.dart';


final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) =>  LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) =>  RegisterScreen(),
  ),


  GoRoute(
    path: '/main',
    builder: (context, state) => const MainDrawerScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) =>  HomeScreen(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) =>  ProfileScreen(),
  ),
  GoRoute(
    path: '/notes',
    builder: (context, state) =>  NoteListScreen(),
  ),
  GoRoute(
    path: '/note-detail',
    builder: (context, state) =>  NoteDetailScreen(),
  ),
  
  


  // GoRoute(
  //   path: '/movie',
  //   builder: (context, state) {
  //     final id = state.extra as Map;
  //     return MovieScreen(
  //     movieId: id['id'],
  //   );
  //   },
  // ),





]);