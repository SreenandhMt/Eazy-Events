import 'package:event_manager/dashboard/views/event_category.dart';
import 'package:event_manager/dashboard/views/event_creating.dart';
import 'package:event_manager/dashboard/views/orders.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/auth/views/auth_route.dart';
import '/category_list/views/category_list_page.dart';
import '/dashboard/views/dashboard_page.dart';
import '/event_details/views/event_details.dart';
import '/search/views/event_list.dart';
import '/home/views/home_page.dart';
import '/tickets/views/ticket_page.dart';


class PageRouteGoRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GoRouter goRouter(isAuth){
    return  GoRouter(
      initialLocation: "/",
  routes: <RouteBase>[
     StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return DashboardPage(shell: navigationShell);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: navigatorKey,
              routes: [
                GoRoute(
                  path: "/dash",
                  builder: (context, state) => const DashBoardEventPage(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/event/manage",
                  builder: (context, state) => const EventCategoryDashBoard(),
                ),
              ],
            ),
             StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/orders",
                  builder: (context, state) => const EventOrders(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/create",
                  builder: (context, state) => const EventCreatingPage(),
                ),
              ],
            ),
          ],
        ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    // GoRoute(
    //   path: '/dash',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const DashboardPage();
    //   },
    // ),
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
