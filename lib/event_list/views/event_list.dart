import 'package:event_manager/core/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/core/colors.dart';
import 'package:event_manager/event_list/view_model/view_model.dart';
import 'package:event_manager/utils/appbar.dart';

import '../../event_details/view_models/event_view_model.dart';
import '../../utils/navigation_utils.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({
    Key? key,
    this.type,
  }) : super(key: key);
  final String? type;


  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  void initState() {
    if(widget.type!=null)
    {
      context.read<ListEventViewModel>().getTypeEvent(widget.type!);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ListEventViewModel viewModel = context.watch<ListEventViewModel>();
    if(viewModel.loading)
    {
      return Center(child: CircularProgressIndicator(color: Colors.red,),);
    }
    if(viewModel.eventList.isNotEmpty)
    {
      return Center(child: CircularProgressIndicator(color: Colors.red,),);
    }
    return Scaffold(
      appBar:customAppBar(screenSize,context),
      body: ListView(
        children: [
          height20,
          // Padding(
          //   padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 20),
          //   child: Text(widget.type!=null?"Study Events":"",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          // ),
          if(viewModel.eventList.isNotEmpty)
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.8/1.5,
                crossAxisCount: screenSize.width<=600?1:screenSize.width<=870?2:screenSize.width<=1000? 3:4),
            itemCount: viewModel.eventList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                onTap: () {
                   context.read<EventViewModel>().setEventData(viewModel.eventList[index]);
                   AppNavigation.eventDetailsPage(context,viewModel.eventList[index].id);
                },
                child: Container(width: 350,height: 300,decoration: BoxDecoration(color: Colors.grey.shade300,image:viewModel.eventList[index].poster.isEmpty?null: DecorationImage(image: NetworkImage(viewModel.eventList[index].poster),fit: BoxFit.fitHeight),borderRadius: BorderRadius.circular(10)),child: Stack(
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
                            Text(viewModel.eventList[index].title,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 14),maxLines: 1),
                            Text(viewModel.eventList[index].date,style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 12),maxLines: 1),
                            Text("Fee ₹${viewModel.eventList[index].fee}",style: const TextStyle(fontWeight: FontWeight.w800,fontSize: 10),maxLines: 1),
                            Text(viewModel.eventList[index].createrName,style: const TextStyle(fontWeight: FontWeight.w900,fontSize: 13),maxLines: 1),
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