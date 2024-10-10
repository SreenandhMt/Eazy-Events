import 'package:event_manager/dashboard/views/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  static homePage(BuildContext context){
    context.go("/");
  }
  static eventDetailsPage(BuildContext context,String id){
    context.go("/details/$id");
  }
  static authPage(BuildContext context){
    context.go("/auth");
  }
  static dashboardPage(BuildContext context){
    context.go("/dash");
  }
  static ticketPage(BuildContext context){
    context.go("/tickets");
  }
  static showEventTickets(BuildContext context,String eventID){
    context.go("/event/tickets/$eventID");
  }
  static showEventCategoryList(BuildContext context,String category){
    context.go("/event/type/$category");
  }
  static showSearchScreen(BuildContext context,String query){
    context.go("/event/search/$query");
  }
}