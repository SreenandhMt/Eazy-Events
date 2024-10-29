import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/auth/view_models/auth_view_model.dart';
import 'package:event_manager/components/appbar_action_icon.dart';
import 'package:event_manager/core/size.dart';
import 'package:event_manager/utils/navigation_utils.dart';

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
      AppbarActionsIcons(icon: Icons.add, text: "Create an event",onTap: () => AppNavigation.dashboardEventCreatePage(context),),
          width20,
          AppbarActionsIcons(icon: Icons.airplane_ticket_outlined, text: "Ticket",onTap: () {
            AppNavigation.ticketPage(context);
          }),
          width35,
          AppBarProfilePopUpButton(child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),color: AppColor.secondaryColor(context)),
            child: Row(
            children: [
              const CircleAvatar(radius: 15,),
              width5,
              Text(snap.data!.email??""),
            ],
          ),),),
          width10,
      ],
    );
      }
      return Row(
      children: [
          TextButton(
            onPressed: () {
              AppNavigation.authPage(context);
            },
            child: const Text(
              "Log In",
            ),
          ),
          width5,
          TextButton(
            onPressed: () {
              context.read<AuthViewModel>().setPage(false);
              AppNavigation.authPage(context);
            },
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
class AppBarProfilePopUpButton extends StatelessWidget {
  const AppBarProfilePopUpButton({
    super.key,
    required this.child,
    this.moreButton1,
    this.moreButton2,
  });
  final Widget child;
  final PopupMenuEntry<dynamic>? moreButton1;
  final PopupMenuEntry<dynamic>? moreButton2;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none,gapPadding: 0),padding: const EdgeInsets.all(0),itemBuilder: (context) {
            return [
              if(moreButton1!=null)moreButton1!,
              if(moreButton2!=null)moreButton2!,
              PopupMenuItem(onTap: () =>AppNavigation.dashboardPage(context),padding: const EdgeInsets.only(left: 10,right: 50), child: const Row(
                children: [
                  Icon(Icons.account_circle_outlined),
                  width10,
                  Text("Profile"),
                ],
              )),
              PopupMenuItem(onTap: () =>AppNavigation.dashboardPage(context),padding: const EdgeInsets.only(left: 10,right: 30), child: const Row(
                children: [
                  Icon(Icons.movie_creation_rounded),
                  width10,
                  Text("Dashbord"),
                ],
              )),
              PopupMenuItem(onTap: () => FirebaseAuth.instance.signOut(),padding: const EdgeInsets.only(left: 10,right: 30), child: const Row(
                children: [
                  Icon(Icons.logout_outlined),
                  width10,
                  Text("LogOut"),
                ],
              )),
            ];
          },child: child,);
  }
}
