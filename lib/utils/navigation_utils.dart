import 'package:event_manager/dashboard/models/ticket_model.dart';
import 'package:event_manager/dashboard/views/dashboard_page.dart';
import 'package:event_manager/home/models/event_model.dart';
import 'package:event_manager/payment/view_models/payment_view_model.dart';
import 'package:event_manager/payment/views/payment_web.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
  static showEventCategoryList(BuildContext context,String categoryIndex){
    context.go("/event/category/$categoryIndex");
  }
  static showSearchScreen(BuildContext context,String query){
    context.go("/event/search/$query");
  }
  static paymentSreen(BuildContext context,String eventID,String amount,String title,String subtitle,String imageUrl,{required String stock,required TicketModel ticketModel}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(amount: amount,imageurl: imageUrl,subtitle: subtitle,title: title,stock: stock,ticketModel: ticketModel),));
  }
}