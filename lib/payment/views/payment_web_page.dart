import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/core/size.dart';
import 'package:event_manager/payment/view_models/payment_view_model.dart';

import '../../components/payment/payment_web_desktop_view.dart';
import '../../components/payment/payment_web_mobile_view.dart';
import '../../dashboard/models/ticket_model.dart';
import '/payment/repo/platform_impl/imp.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.amount,
    required this.imageurl,
    required this.title,
    required this.subtitle,
    required this.stock,
    required this.ticketModel,
  });
  final String amount;
  final String imageurl;
  final String title;
  final String subtitle;
  final String stock;
  final TicketModel ticketModel;

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context.read<PaymentViewModel>().setAmount(widget.amount),);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    PaymentViewModel paymentViewModel = context.watch<PaymentViewModel>();
    if(paymentViewModel.successPayment!=null)
    {
      paymentViewModel.setPaymentStatus(null, null);
      context.pop();
    }
    if(paymentViewModel.loading)
    {
      return const Center(child: CircularProgressIndicator(color: Colors.red,));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body:screenSize.width <= 850
          ? PaymentMobileView(
              amount: widget.amount,
              imageurl: widget.imageurl,
              title: widget.title,
              subtitle: widget.subtitle,
              stock: widget.stock,
              ticketModel: widget.ticketModel,
            )
          : PaymentDesktopView(
              amount: widget.amount,
              imageurl: widget.imageurl,
              title: widget.title,
              subtitle: widget.subtitle,
              stock: widget.stock,
              ticketModel: widget.ticketModel,
            )
    );
  }
}