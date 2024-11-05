import 'dart:developer';

import 'package:event_manager/core/constants.dart';
import 'package:event_manager/dashboard/views/event_category.dart';
import 'package:event_manager/dashboard/views/event_creating.dart';
import 'package:event_manager/dashboard/views/orders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/auth/views/auth_route.dart';
import '/category_list/views/category_list_page.dart';
import '/dashboard/views/dashboard_page.dart';
import '/event_details/views/event_details.dart';
import '/search/views/event_list.dart';
import '/home/views/home_page.dart';
import '/tickets/views/ticket_page.dart';

import 'dart:html' as html;


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
                  name: Routes.dashboardPageName,
                  path: Routes.dashboardNamedPage,
                  builder: (context, state) => const DashBoardEventPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: Routes.categoryPageName,
                  path: Routes.categoryNamedPage,
                  builder: (context, state) => const EventCategoryDashBoard(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    name: Routes.ordersPageName,
                    path: Routes.ordersNamedPage,
                    builder: (context, state) => const EventOrders(),
                    routes: [
                      GoRoute(
                        path: "tickets/:id",
                        builder: (context, GoRouterState state) =>
                            EventOrdersTickets(
                          eventId: state.pathParameters["id"] ?? "",
                        ),
                      ),
                    ]),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    name: Routes.createScreenPageName,
                    path: Routes.createScreenNamedPage,
                    builder: (context, state) => const EventCreatingPage(),
                    routes: [
                      GoRoute(
                        path: "create",
                        builder: (context, state) => const EventCreatingPage(),
                      ),
                      GoRoute(
                        name: Routes.updateScreenPageName,
                        path: "update/:id",
                        builder: (context, state) => EventCreatingPage(
                            eventID: state.pathParameters["id"]),
                      ),
                    ]),
              ],
            ),
          ],
        ),
         GoRoute(
          name: Routes.homeNamedPage,
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: [
              GoRoute(
                path: 'details/:eventid',
                builder: (BuildContext context, GoRouterState state) {
                  return EventDetailsPage(
                      eventID: state.pathParameters["eventid"] ?? "");
                },
              ),
        ]),
        GoRoute(
          path: '/tickets',
          builder: (BuildContext context, GoRouterState state) {
            return const TicketPage();
          },
        ),
        GoRoute(
          path: '/event/tickets/:id',
          builder: (BuildContext context, GoRouterState state) {
            return TicketPage(
              eventID: state.pathParameters["id"] ?? "",
            );
          },
        ),
        GoRoute(
          path: '/event/category/:index',
          builder: (BuildContext context, GoRouterState state) {
            return CategoryListPage(
              typeIndex: state.pathParameters["index"] ?? "",
            );
          },
        ),
        GoRoute(
          path: '/event/search/:search',
          builder: (BuildContext context, GoRouterState state) {
            return SearchPage(
              search: state.pathParameters["search"] ?? "",
            );
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
   observers: [GoRouterObserver()],
  redirect: (context, state) {
        // if (!isAuth) return "/auth";
        return state.path;
      },
    );
  }
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _updateTitle(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _updateTitle(previousRoute);
  }

  void _updateTitle(Route? route) {
    if (route is PageRoute) {
      switch (route.settings.name) {
        case '/':
          _setTitle('Feed - home');
          break;
        case "details/:eventid":
          _setTitle('🤑 Event details');
          break;
        case "/tickets":
          _setTitle('🤑 Your tickets');
          break;
        case "/auth":
          _setTitle('🤫 Hide screen');
          break;
        default:
          _setTitle('(❁´◡`❁) Eazy To Book');
      }
    }else{
      _setTitle('(❁´◡`❁) Edit event now');
    }
  }

  void _setTitle(String title) {
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (kIsWeb) {
          html.document.title = title;
        }
      });
    }
  }
}