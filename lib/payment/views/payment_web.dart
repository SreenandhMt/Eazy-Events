import 'package:flutter/material.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/core/size.dart';
import 'package:event_manager/payment/view_models/payment_view_model.dart';

import '../../dashboard/models/ticket_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
    required this.amount,
    required this.imageurl,
    required this.title,
    required this.subtitle,
    required this.stock,
    required this.ticketModel,
  }) : super(key: key);
  final String amount;
  final String imageurl;
  final String title;
  final String subtitle;
  final String stock;
  final TicketModel ticketModel;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context.read<PaymentViewModel>().setAmount(widget.amount),);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    PaymentViewModel _paymentViewModel = context.watch<PaymentViewModel>();
    if(_paymentViewModel.successPayment!=null)
    {
      _paymentViewModel.setPaymentStatus(null, null);
      context.pop();
    }
    if(_paymentViewModel.loading)
    {
      return const Center(child: CircularProgressIndicator(color: Colors.red,));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Stripe Payment'),backgroundColor: Colors.white),
      body: screenSize.width <= 850
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
            ),
    );
  }
}

class PaymentDesktopView extends StatefulWidget {
  const PaymentDesktopView({
    Key? key,
    required this.amount,
    required this.imageurl,
    required this.title,
    required this.subtitle,
    required this.stock,
    required this.ticketModel
  }) : super(key: key);
  final String amount;
  final String imageurl;
  final String title;
  final String subtitle;
  final String stock;
  final TicketModel ticketModel;

  @override
  State<PaymentDesktopView> createState() => _PaymentDesktopViewState();
}

class _PaymentDesktopViewState extends State<PaymentDesktopView> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    PaymentViewModel _paymentViewModel = context.watch<PaymentViewModel>();
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
                image: DecorationImage(
                  image: NetworkImage(widget.imageurl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),),
        width35,
          Container(height: double.infinity,width: (screenSize.width/2)*0.5,color: Colors.white,child: _paymentViewModel.clientSecret == null
                ? const CircularProgressIndicator()
                : Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           PlatformPaymentElement(clientSecret: _paymentViewModel.clientSecret),
           const SizedBox(height: 20),
           MaterialButton(onPressed: () {
             context.read<PaymentViewModel>().pay(context,stock: widget.stock,createrID: widget.ticketModel.createrID,eventID: widget.ticketModel.eventID,phoneNumber: widget.ticketModel.userNumber,name: widget.ticketModel.userName);
           },color: AppColor.primaryColor,child: SizedBox(width: double.infinity,height: 55,child: _paymentViewModel.paymentLoading?const Center(child: CircularProgressIndicator(color: Colors.green,)):const Center(child: Text("Pay",style: TextStyle(color: Colors.black),)),),)
         ],
       ),),
       const SizedBox(),
        ],
      );
  }
}

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
  final TicketModel ticketModel;

  @override
  State<PaymentMobileView> createState() => _PaymentMobileViewState();
}

class _PaymentMobileViewState extends State<PaymentMobileView> {
  @override
  Widget build(BuildContext context) {
    PaymentViewModel _paymentViewModel = context.watch<PaymentViewModel>();
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
            _paymentViewModel.clientSecret == null
                ? const CircularProgressIndicator()
                : Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           PlatformPaymentElement(clientSecret: _paymentViewModel.clientSecret),
           const SizedBox(height: 20),
           MaterialButton(onPressed: () {
             context.read<PaymentViewModel>().pay(context,stock: widget.stock,createrID: widget.ticketModel.createrID,eventID: widget.ticketModel.eventID,phoneNumber: widget.ticketModel.userNumber,name: widget.ticketModel.userName);
           },color: AppColor.primaryColor,child: SizedBox(width: double.infinity,height: 40,child: _paymentViewModel.paymentLoading?const Center(child: CircularProgressIndicator(color: Colors.green,)):const Center(child: Text("Pay",style: TextStyle(color: Colors.black),)),),),
           height15,
         ],
       ),]);
  }
}

class PlatformPaymentElement extends StatelessWidget {
  const PlatformPaymentElement({super.key, required this.clientSecret});

  final String? clientSecret;

  @override
  Widget build(BuildContext context) {
    return PaymentElement(
      autofocus: true,
      enablePostalCode: true,
      onCardChanged: (card) {
        
      },
      clientSecret: clientSecret ?? '',
    );
  }
}
