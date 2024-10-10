
import 'dart:developer';

import 'package:event_manager/core/assets.dart';
import 'package:event_manager/core/colors.dart';
import 'package:event_manager/event_details/view_models/event_view_model.dart';
import 'package:event_manager/home/view_models/home_view_model.dart';
import 'package:event_manager/utils/appbar.dart';
import 'package:event_manager/utils/dark_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../utils/navigation_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> eventType = [
    "Music",
    "Nightlife",
    "Art",
    "Dating",
    "Gaming",
    "Business",
    "Study",
    "Food and Drink",
    "Sports"
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    HomeViewModel homeViewModel = context.watch<HomeViewModel>();
    if(homeViewModel.loading)
    {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar:customAppBar(screenSize,context),
      body: ListView(
        children: [
          Container(width: double.infinity,height: 400,decoration: BoxDecoration(image: DecorationImage(image: screenSize.width<=800? const NetworkImage("https://cdn.evbstatic.com/s3-build/fe/build/images/b4a2c827f30f313141217e4d87c907e2-4_mobile_659x494.webp"):const NetworkImage("https://cdn.evbstatic.com/s3-build/fe/build/images/d496904ef6b1264a0a7f769d33acad73-4_tablet_1067x470.webp"))),),
          if(screenSize.width<1105)
          LimitedBox(maxWidth: screenSize.width*0.9,maxHeight: 150,child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(9, (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(onTap: (){
                AppNavigation.showEventCategoryList(context,eventType[index]);
              },child: CircleAvatar(radius: 53,backgroundColor: Colors.grey.shade400,child: CircleAvatar(radius: 50,backgroundColor: AppColor.secondaryColor(context),child: Image.asset(ImageAssets.categoryImage(index+1,isDarkTheme(context)),width: 40),),)),
            ),),
          ))
          else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(9, (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(onTap: () => AppNavigation.showEventCategoryList(context,eventType[index]),child: CircleAvatar(radius: 53,backgroundColor: Colors.grey.shade400,child: CircleAvatar(radius: 50,backgroundColor: AppColor.secondaryColor(context),child: Image.asset(ImageAssets.categoryImage(index+1,isDarkTheme(context)),width: 40),),)),
            ),),
          )
          ,
          const Padding(
            padding: EdgeInsets.only(top: 8.0,bottom: 8.0,left: 20),
            child: Text("TOP 8 EVENTS",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          if(homeViewModel.eventModels!=null)
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.8/1.5,
                crossAxisCount: screenSize.width<=600?1:screenSize.width<=870?2:screenSize.width<=1000? 3:4),
            itemCount: homeViewModel.eventModels!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                onTap: () {
                   context.read<EventViewModel>().setEventData(homeViewModel.eventModels![index]);
                   AppNavigation.eventDetailsPage(context,homeViewModel.eventModels![index].id);
                },
                child: Container(width: 350,height: 300,decoration: BoxDecoration(color: Colors.grey.shade300,image:homeViewModel.eventModels![index].poster.isEmpty?null: DecorationImage(image: NetworkImage(homeViewModel.eventModels![index].poster),fit: BoxFit.fitHeight),borderRadius: BorderRadius.circular(10)),child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(alignment: Alignment.bottomCenter,child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(color: AppColor.secondaryColor(context),borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(homeViewModel.eventModels![index].title,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 14),maxLines: 1),
                            Text(homeViewModel.eventModels![index].date,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 12),maxLines: 1),
                            Text("Fee ₹${homeViewModel.eventModels![index].fee}",style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 10),maxLines: 1),
                            Text(homeViewModel.eventModels![index].createrName,style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 13),maxLines: 1),
                          ],
                        ),
                      ),
                    ),)
                  ],
                ),),
              ),
              );
            },
          ),
        ],
      ),
    );
  }
}