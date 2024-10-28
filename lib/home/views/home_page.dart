import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/components/home/category_widget.dart';
import '/components/home/event_widget.dart';
import '/home/view_models/home_view_model.dart';
import '/utils/appbar.dart';

import '../../core/size.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context.read<HomeViewModel>().getTop10Event());
    super.initState();
  }
  
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
          const CategoryWidget(),
          const Padding(
            padding: EdgeInsets.only(top: 8.0,bottom: 8.0,left: 20),
            child: Text("For you",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
              return EventWidget(eventModel: homeViewModel.eventModels![index]);
            },
          ),
          height35,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: const Center(child: Text("© 2024 EazyEvent")),
        ),
        ],
      ),
    );
  }
}