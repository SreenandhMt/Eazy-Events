import 'package:event_manager/event_details/view_models/event_view_model.dart';
import 'package:event_manager/event_details/views/event_details.dart';
import 'package:event_manager/home/view_models/home_view_model.dart';
import 'package:event_manager/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    HomeViewModel homeViewModel = context.watch<HomeViewModel>();
    if(homeViewModel.loading)
    {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar:customAppBar(),
      body: ListView(
        children: [
          Container(width: double.infinity,height: 400,decoration: BoxDecoration(image: DecorationImage(image: screenSize.width<=800? const NetworkImage("https://cdn.evbstatic.com/s3-build/fe/build/images/b4a2c827f30f313141217e4d87c907e2-4_mobile_659x494.webp"):const NetworkImage("https://cdn.evbstatic.com/s3-build/fe/build/images/d496904ef6b1264a0a7f769d33acad73-4_tablet_1067x470.webp"))),),
          LimitedBox(maxWidth: screenSize.width*0.9,maxHeight: 150,child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(9, (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(radius: 53,backgroundColor: Colors.grey.shade300,child: CircleAvatar(radius: 50,backgroundColor: Colors.white,child: Image.asset("assets/dark/category-image-${index+1}.png",width: 40),),),
            ),),
          )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("TOP 5 EVENTS",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          if(homeViewModel.eventModels!=null)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 5,
            children: List.generate(homeViewModel.eventModels!.length, (index) => GestureDetector(
              onTap: () {
                 context.read<EventViewModel>().setEventData(homeViewModel.eventModels![index]);
                Navigator.push(context,(MaterialPageRoute(builder: (context) => const EventDetailsPage())));
              },
              child: Container(width: 350,height: 300,decoration: BoxDecoration(color: Colors.grey.shade300,image: DecorationImage(image: NetworkImage(homeViewModel.eventModels![index].poster.first),fit: BoxFit.fitHeight),borderRadius: BorderRadius.circular(10)),child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(alignment: Alignment.bottomCenter,child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(homeViewModel.eventModels![index].title,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 14)),
                          Text(homeViewModel.eventModels![index].timedate,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 12)),
                          const Text("Fee ₹100",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 10)),
                          const Text("Sreenandh Shout",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 13)),
                        ],
                      ),
                    ),
                  ),)
                ],
              ),),
            )),
          )
        ],
      ),
    );
  }
}