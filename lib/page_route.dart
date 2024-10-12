import 'package:event_manager/auth/views/auth_route.dart';
import 'package:event_manager/category_list/views/category_list_page.dart';
import 'package:event_manager/dashboard/views/dashboard_page.dart';
import 'package:event_manager/event_details/views/event_details.dart';
import 'package:event_manager/search/views/event_list.dart';
import 'package:event_manager/home/views/home_page.dart';
import 'package:event_manager/tickets/views/ticket_page.dart';
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
      path: '/dash',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardPage();
      },
    ),
    GoRoute(
      path: '/details/:eventid',
      builder: (BuildContext context, GoRouterState state) {
        return EventDetailsPage(eventID: state.pathParameters["eventid"]??"");
      },
    ),
    GoRoute(
      path: '/tickets',
      builder: (BuildContext context, GoRouterState state) {
        return const TicketPage();
      },
    ),
    GoRoute(
      path: '/event/tickets/:id',
      builder: (BuildContext context, GoRouterState state) {
        return TicketPage(eventID:state.pathParameters["id"]??"",);
      },
    ),
    GoRoute(
      path: '/event/category/:index',
      builder: (BuildContext context, GoRouterState state) {
        return CategoryListPage(typeIndex:state.pathParameters["index"]??"",);
      },
    ),
    GoRoute(
      path: '/event/search/:search',
      builder: (BuildContext context, GoRouterState state) {
        return SearchPage(search: state.pathParameters["search"]??"",);
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
