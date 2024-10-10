import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/event_details/view_models/event_view_model.dart';

import '../../core/size.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
    required this.eventID,
    required this.createrID,
    required this.stock,
  }) : super(key: key);
  final String eventID;
  final String createrID;
  final String stock;

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  bool isEventUpdatesChecked = true;
  bool isBestEventsChecked = true;
  String oldValue = '';
  TextEditingController _email = TextEditingController(text: _auth.currentUser==null?"":_auth.currentUser!.email),_number = TextEditingController(),_name = TextEditingController(),_lastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: 600,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        controller: _name,
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
                        controller: _lastName,
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
                      controller: _email,
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
                      controller: _number,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if(value.isEmpty)return;
                        if(int.tryParse(value)==null)
                        {
                          _number.text = oldValue;
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
                    context.read<EventViewModel>().createTicket(eventID: widget.eventID,stock: widget.stock,phoneNumber:_number.text,name: "${_name.text} ${_lastName.text}",createrID: widget.createrID);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Register',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(style: BorderStyle.none),
                  backgroundColor: AppColor.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}