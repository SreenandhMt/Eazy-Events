import 'package:event_manager/core/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(){
  return AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Text("EazyEvents"),
            Container(
              width: 550,
              height: 44,
              margin: EdgeInsets.all(10),
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
                    icon: const Icon(Icons.search, color: Colors.black),
                    onPressed: () {},
                  ),
                        hintText: "Search events",
                        hintStyle: TextStyle(fontSize: 13),
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topLeft: Radius.circular(28),bottomLeft: Radius.circular(28))),
                      ),
                    ),
                  ),
                  Container(height: 33,width: 0.3,color: Colors.black),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          padding: const EdgeInsets.only(left: 14,right: 10),
                          iconSize: 20,
                    icon: const Icon(Icons.location_on, color: Colors.black),
                    onPressed: () {},
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CircleAvatar(
                      backgroundColor: Colors.deepOrange[700],
                      radius: 10,
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                        hintText: "Choose a location",
                        hintStyle: TextStyle(fontSize: 13),
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
          TextButton(
            onPressed: () {},
            child: const Text(
              "Create Events",
              style: TextStyle(color: Colors.black),
            ),
          ),
          width5,
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              "Log In",
              style: TextStyle(color: Colors.black),
            ),
          ),
          width5,
          TextButton(
            onPressed: () {},
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.black),
            ),
          ),
          width5,
        ],
      );
}