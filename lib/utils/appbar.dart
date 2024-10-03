import 'package:event_manager/auth/view_models/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:event_manager/core/size.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/appbar_actions.dart';
import '../components/appbar_logo.dart';

PreferredSizeWidget customAppBar(Size size){
  if(size.width<871.0)
  {
     return AppBar(
        elevation: 1,
        title: const Row(
          children: [
            AppIcon(),
          ],
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(!snapshot.hasData)
              {
                return const AuthButton();
              }
              return IconButton(onPressed: () {},icon: const Icon(Icons.account_circle_outlined));
            }
          )
        ],
        bottom: PreferredSize(preferredSize: const Size(double.infinity, 50), child: Container(
              width: 550,
              padding: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(28)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 20,right: 10),
                          iconSize: 20,
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                        hintText: "Search events",
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topLeft: Radius.circular(28),bottomLeft: Radius.circular(28))),
                      ),
                    ),
                  ),
                  Container(height: 20,width: 0.3,color: Colors.black),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 14,right: 10),
                          iconSize: 20,
                    icon: const Icon(Icons.location_on),
                    onPressed: () {},
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CircleAvatar(
                      backgroundColor: Colors.deepOrange[700],
                      radius: 10,
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                        hintText: "Choose a location",
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topRight: Radius.circular(28),bottomRight: Radius.circular(28))),
                      ),
                    ),
                  ),
                ],
              ),
            ),),
      );
  }
  if(size.width<1193.0)
  {
    return AppBar(
        elevation: 1,
        title: Row(
          children: [
            const AppIcon(),
            width20,
             Container(
              width: 550,
              padding: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(28)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 20,right: 10),
                          iconSize: 20,
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                        hintText: "Search events",
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topLeft: Radius.circular(28),bottomLeft: Radius.circular(28))),
                      ),
                    ),
                  ),
                  Container(height: 20,width: 0.3,color: Colors.black),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 14,right: 10),
                          iconSize: 20,
                    icon: const Icon(Icons.location_on),
                    onPressed: () {},
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CircleAvatar(
                      backgroundColor: Colors.deepOrange[700],
                      radius: 10,
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                        hintText: "Choose a location",
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topRight: Radius.circular(28),bottomRight: Radius.circular(28))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(!snapshot.hasData)
              {
                return const AuthButton();
              }
              return const Icon(Icons.account_circle_outlined);
            }
          )
        ],
      );
  }
  return AppBar(
        elevation: 1,
        title: Row(
          children: [
            const AppIcon(),
            width20,
            Container(
              width: 550,
              decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(28)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 20,right: 10),
                          iconSize: 20,
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                        hintText: "Search events",
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topLeft: Radius.circular(28),bottomLeft: Radius.circular(28))),
                      ),
                    ),
                  ),
                  Container(height: 20,width: 0.3,color: Colors.black),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 14,right: 10),
                          iconSize: 20,
                    icon: const Icon(Icons.location_on),
                    onPressed: () {},
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CircleAvatar(
                      backgroundColor: Colors.deepOrange[700],
                      radius: 10,
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                        hintText: "Choose a location",
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topRight: Radius.circular(28),bottomRight: Radius.circular(28))),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
        actions: const [
          AppbarActions()
        ],
      );
}

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              context.read<AuthViewModel>().setPage(true);
              context.go("/auth");
            },
            child: const Text(
              "Log In",
            ),
          ),
          width5,
          TextButton(
            onPressed: () {
              context.read<AuthViewModel>().setPage(false);
              context.go("/auth");
            },
            child: const Text(
              "Sign Up",
            ),
          ),
          width5,
      ],
    );
  }
}