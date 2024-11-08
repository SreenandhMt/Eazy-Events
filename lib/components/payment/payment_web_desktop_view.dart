import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_manager/components/payment/payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/config.dart';
import '../../dashboard/models/ticket_model.dart';
import '../../payment/view_models/payment_view_model.dart';

class PaymentDesktopView extends StatefulWidget {
  const PaymentDesktopView({
    super.key,
    required this.amount,
    required this.imageurl,
    required this.title,
    required this.subtitle,
    required this.stock,
    required this.ticketModel
  });
  final String amount;
  final String imageurl;
  final String title;
  final String subtitle;
  final String stock;
  final TicketModel ticketModel;//todo add did you want data

  @override
  State<PaymentDesktopView> createState() => _PaymentDesktopViewState();
}

class _PaymentDesktopViewState extends State<PaymentDesktopView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    PaymentViewModel paymentViewModel = context.watch<PaymentViewModel>();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(),
          LimitedBox(maxWidth: 300,child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(height: 10),
            Text(
              "₹${widget.amount}.00",
              style: const TextStyle(fontSize: 40,color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,maxLines: 1,
              style: GoogleFonts.abel(fontSize: 13,color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                imageUrl:
                    widget.imageurl,
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),),
        width35,
          Container(height: double.infinity,width: (screenSize.width/2)*0.5,color: Colors.white,child: paymentViewModel.clientSecret == null
                ? const CircularProgressIndicator()
                : Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           PlatformPaymentElement(clientSecret: paymentViewModel.clientSecret),
           const SizedBox(height: 20),
           MaterialButton(onPressed: () {
            context.read<PaymentViewModel>().pay(context,true,widget.amount,stock: widget.stock,createrID: widget.ticketModel.createrID,eventID: widget.ticketModel.eventID,phoneNumber: widget.ticketModel.userNumber,name: widget.ticketModel.userName,title: widget.title);
           },color: AppColor.primaryColor,child: SizedBox(width: double.infinity,height: 55,child: paymentViewModel.paymentLoading?const Center(child: CircularProgressIndicator(color: Colors.green,)):const Center(child: Text("Pay",style: TextStyle(color: Colors.black),)),),)
         ],
       ),),
       const SizedBox(),
        ],
      );
  }
}