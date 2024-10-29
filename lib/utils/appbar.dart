import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/auth/view_models/auth_view_model.dart';
import 'package:event_manager/core/size.dart';
import 'package:event_manager/search/view_model/search_view_model.dart';
import 'package:event_manager/utils/navigation_utils.dart';

import '../components/appbar_actions.dart';
import '../components/appbar_logo.dart';

String? searchQuery;
TextEditingController SearchController = TextEditingController();

PreferredSizeWidget customAppBar(Size size,BuildContext context,{bool? isSearchPage}){
  //mobile view
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
              return AppBarProfilePopUpButton(
                  moreButton1: PopupMenuItem(
                      onTap: () {
                        AppNavigation.ticketPage(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.airplane_ticket_outlined),
                          width10,
                          Text("Ticket"),
                        ],
                      )),
                  child: const Icon(Icons.account_circle_outlined));
            }
          )
        ],
        bottom: PreferredSize(preferredSize: const Size(double.infinity, 50), child:SearchButton(isSearchPage: isSearchPage)),
      );
  }
  //tablet view
  if(size.width<1193.0)
  {
    return AppBar(
        elevation: 1,
        title: Row(
          children: [
            const AppIcon(),
            width20,
             SearchButton(isSearchPage: isSearchPage)
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
              return AppBarProfilePopUpButton(
                  moreButton1: PopupMenuItem(
                      onTap: () {
                        AppNavigation.ticketPage(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.airplane_ticket_outlined),
                          width10,
                          Text("Ticket"),
                        ],
                      )),
                  child: const Icon(Icons.account_circle_outlined));
            }
          )
        ],
      );
  }
  //desktop view
  return AppBar(
        elevation: 1,
        title: Row(
          children: [
            const AppIcon(),
            width20,
            SearchButton(isSearchPage: isSearchPage)
          ],
        ),
        actions: const [
          AppbarActions()
        ],
      );
}

class SearchButton extends StatefulWidget {
  const SearchButton({
    super.key,
    this.isSearchPage,
  });
  final bool? isSearchPage;

  @override
  State<SearchButton> createState() => SearchButtonState();
}

class SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
              width: 550,
              decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(28)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: SearchController,
                      cursorColor: Colors.green,
                      onChanged: (value) => searchQuery=value,
                      onSubmitted: (value) {
                        if(searchQuery==null)return;
                        if(widget.isSearchPage!=null)
                        {
                          context.read<SearchViewModel>().searchItem(searchQuery!);
                          return;
                        }
                        AppNavigation.showSearchScreen(context, searchQuery!);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 20,right: 10),
                          child: Icon(Icons.search),
                        ),
                        hintText: "Search events",
                        border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topLeft: Radius.circular(28),bottomLeft: Radius.circular(28))),
                      ),
                    ),
                  ),
                  Container(height: 20,width: 0.3,color: Colors.black),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 14,right: 10),
                          child: IconButton(
                            iconSize: 20,
                                              icon: const Icon(Icons.location_on),
                                              onPressed: () {},
                                            ),
                        ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: InkWell(
                      onTap: () {
                        if(searchQuery!=null)AppNavigation.showSearchScreen(context, searchQuery!);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.deepOrange[700],
                        radius: 10,
                        child: const Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ),
                        hintText: "Choose a location",
                        border: const OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.only(topRight: Radius.circular(28),bottomRight: Radius.circular(28))),
                      ),
                    ),
                  ),
                  
                ],
              ),
            );
  }
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
  }
}