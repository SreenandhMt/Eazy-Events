import 'package:event_manager/components/appbar_action_icon.dart';
import 'package:event_manager/core/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/colors.dart';

class AppbarActions extends StatelessWidget {
  const AppbarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context,snap){
      if(snap.hasData)
      {
        return Row(
      children: [
       const AppbarActionsIcons(icon: Icons.add, text: "Create an event"),
          width20,
          const AppbarActionsIcons(icon: Icons.airplane_ticket_outlined, text: "Ticket"),
          width35,
          const AppbarActionsIcons(icon: Icons.favorite_border_rounded, text: "Likes"),
          width30,
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),color: AppColor.secondaryColor(context)),
            child: Row(
            children: [
              const CircleAvatar(radius: 15,),
              width5,
              Text(snap.data!.email??""),
            ],
          ),),
          width10,
      ],
    );
      }
      return Row(
      children: [
        TextButton(
            onPressed: () {},
            child: const Text(
              "Create Events",
            ),
          ),
          width5,
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              "Log In",
            ),
          ),
          width5,
          TextButton(
            onPressed: () {},
            child: const Text(
              "Sign Up",
            ),
          ),
          width5,
      ],
    );
    });
  }
}