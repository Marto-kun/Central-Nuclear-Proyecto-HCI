import 'package:central_nuclear/presentation/presentation.dart';
import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => StartInstructionsScreen(),
    ),

  ],
);