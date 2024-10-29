import 'package:event_manager/dashboard/models/ticket_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/event_details/view_models/event_view_model.dart';
import 'package:event_manager/home/models/event_model.dart';

import '../../core/size.dart';
import '../../utils/navigation_utils.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required this.eventModel,
  });
  final EventModel eventModel;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  bool isEventUpdatesChecked = true;
  bool isBestEventsChecked = true;
  String oldValue = '';
  TextEditingController email = TextEditingController(text: _auth.currentUser==null?"":_auth.currentUser!.email),number = TextEditingController(),name = TextEditingController(text: _auth.currentUser!.displayName!=null?_auth.currentUser!.displayName!.split(" ").first:""),lastName = TextEditingController(text:  _auth.currentUser!.displayName!=null?_auth.currentUser!.displayName!.split(" ").last:"");

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: 600,
      height: screenSize.height*0.7,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Contact Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              height20,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(children: [
                      LimitedBox(
                        maxWidth: screenSize.width>=800?275:(screenSize.width/2)*0.6,
                        child: TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                          labelText: "First Name",
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                                          ),
                      ),
                    width10,
                    LimitedBox(
                      maxWidth: screenSize.width>=800?275:(screenSize.width/2)*0.6,
                      child: TextFormField(
                        controller: lastName,
                        decoration: const InputDecoration(
                          labelText: "Last Name",
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                    ),
                    ],),
                    height30,
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    height30,
                    TextFormField(
                      controller: number,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if(value.isEmpty)return;
                        if(int.tryParse(value)==null)
                        {
                          number.text = oldValue;
                        }else{
                          oldValue = value;
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    height20,
                    CheckboxListTile(
                      title: const Text("Keep me updated on more events and news from this event organizer."),
                      value: isEventUpdatesChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isEventUpdatesChecked = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Send me emails about the best events happening nearby or online."),
                      value: isBestEventsChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isBestEventsChecked = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              height35,
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if(widget.eventModel.fee=="0")
                    {
                      context.read<EventViewModel>().createTicket(eventID: widget.eventModel.id, stock: widget.eventModel.stock, createrID: widget.eventModel.createrid, phoneNumber: number.text, name: "${name.text} ${lastName.text}");
                      Navigator.pop(context);
                      return;
                    }
                    AppNavigation.paymentSreen(context, widget.eventModel.id,widget.eventModel.fee,widget.eventModel.title,widget.eventModel.subtitle,widget.eventModel.poster,stock: widget.eventModel.stock,ticketModel: TicketModel(userName: "${name.text} ${lastName.text}", userProfile: "", userNumber: number.text, eventID: widget.eventModel.id, email: email.text, uid: "", ticketID: "", createrID: widget.eventModel.createrid,active: true));
                    
                  }
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(style: BorderStyle.none),
                  backgroundColor: AppColor.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Register',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
    );
  }
}