import 'package:event_manager/auth/views/auth_route.dart';
import 'package:event_manager/event_details/views/event_details.dart';
import 'package:event_manager/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageRouteGoRouter {
  static GoRouter goRouter(isAuth){
    return  GoRouter(
      initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/details',
      builder: (BuildContext context, GoRouterState state) {
        return const EventDetailsPage();
      },
    ),
    GoRoute(
      path: '/auth',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthRoute();
      },
      redirect: (context, state) {
        if (!isAuth) return "/auth";
        return "/";
      },
    ),
  ],
  redirect: (context, state) {
        // if (!isAuth) return "/auth";
        return state.path;
      },
    );
  }
}
