import 'package:central_nuclear/presentation/presentation.dart';
import 'package:go_router/go_router.dart';

//Definicion de las rutas de las pantallas a utilizar:
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => StartSimulationScreen()),

    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),

    GoRoute(path: '/lose', builder: ((context, state) => LoseScreen())),

    GoRoute(path: '/win', builder: (context, state) => WinScreen()),
  ],
);
