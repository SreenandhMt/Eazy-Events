import 'package:event_manager/components/payment/payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/config.dart';
import '../../dashboard/models/ticket_model.dart';
import '../../payment/view_models/payment_view_model.dart';

class PaymentMobileView extends StatefulWidget {
  const PaymentMobileView({
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
  final TicketModel ticketModel;//also remove this

  @override
  State<PaymentMobileView> createState() => _PaymentMobileViewState();
}

class _PaymentMobileViewState extends State<PaymentMobileView> {
  @override
  Widget build(BuildContext context) {
    PaymentViewModel paymentViewModel = context.watch<PaymentViewModel>();
    return ListView(
        padding: const EdgeInsets.only(left:20,right: 20,top: 10),
        children: [
            const SizedBox(height: 10),
            Text(
              "₹${widget.amount}.00",
              style: const TextStyle(fontSize: 40,color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,maxLines: 1,
              style: GoogleFonts.abel(fontSize: 13,color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(widget.imageurl),
                  fit: BoxFit.cover,
                ),
              ),
            ), 
            const SizedBox(height: 30),
            paymentViewModel.clientSecret == null
                ? const CircularProgressIndicator()
                : Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           PlatformPaymentElement(clientSecret: paymentViewModel.clientSecret),
           const SizedBox(height: 20),
           MaterialButton(onPressed: () {
             context.read<PaymentViewModel>().pay(context,true,widget.amount,stock: widget.stock,createrID: widget.ticketModel.createrID,eventID: widget.ticketModel.eventID,phoneNumber: widget.ticketModel.userNumber,name: widget.ticketModel.userName,title: widget.title);
           },color: AppColor.primaryColor,child: SizedBox(width: double.infinity,height: 40,child: paymentViewModel.paymentLoading?const Center(child: CircularProgressIndicator(color: Colors.green,)):const Center(child: Text("Pay",style: TextStyle(color: Colors.black),)),),),
           height15,
         ],
       ),]);
  }
}