// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/core/colors.dart';
import '/core/size.dart';
import '/dashboard/view_models/dashboard_view_model.dart';
import '/utils/dark_check.dart';

import '../../components/dashboard/date_picker.dart';
import '../../components/dashboard/text_form.dart';

class EventCreatingPage extends StatefulWidget {
  const EventCreatingPage({
    super.key
  });

  @override
  State<EventCreatingPage> createState() => _EventCreatingPageState();
}

class _EventCreatingPageState extends State<EventCreatingPage> {

  final key = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController(),subtitleController = TextEditingController(),aboutController = TextEditingController(),registrationController = TextEditingController(),ticketFeeController = TextEditingController(text: "0"),ticketStockController = TextEditingController(text: "5");

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

  String selectedType = "Nightlife";
  String? imageLink;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    if(viewModel.editEvent!=null)
    {
      titleController.text = viewModel.editEvent!.title;
    aboutController.text = viewModel.editEvent!.about;
    subtitleController.text = viewModel.editEvent!.subtitle;
    ticketFeeController.text = viewModel.editEvent!.fee;
    ticketStockController.text = viewModel.editEvent!.stock;
    registrationController.text = viewModel.editEvent!.registrationDetails??"";
    selectedType = viewModel.editEvent!.category;
    imageLink = viewModel.editEvent!.poster;
    }
    return Form(
      key: key,
      child: SingleChildScrollView(
        child: Container(
          width: 600,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey.shade800),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(left: 20,top: 20,right: 20),
          child: Column(
            // padding: const EdgeInsets.all(10),
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height10,
                const Text("Create an event",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
                height10,
                InkWell(onTap: ()=>context.read<DashboardViewModel>().pickImage(),child: Container(margin: const EdgeInsets.all(10),width: double.infinity,height: 200,decoration: BoxDecoration(image: imageLink!=null&&viewModel.filePath==null?DecorationImage(image: NetworkImage(imageLink!),fit: BoxFit.fitWidth):viewModel.filePath==null?null:DecorationImage(image: MemoryImage(viewModel.filePath!),fit: BoxFit.fitWidth),borderRadius: BorderRadius.circular(20)),child: const Icon(Icons.add,size: 50))),
                height10,
                const TitleText(text: "Event title",subtitle: "Be clear and descriptive with a title that tells people what your event is about.",),
                DashboardTextform(text: "Type title here*",width: 480,padding: 0,controller: titleController,validator: (value){
                  if(value==null)return "Title is required";
                  if(value.length<=9)return "Title must be at least 9 characters";
                  return null;
                },),
                height10,
                const TitleText(text: "Summary",subtitle: "Grab people's attention with a short description about your event. Attendees will see this at the top of your event page. (140 characters max)",),
                DashboardTextform(text: "Type summary here*", width: 480,maxLine: 4,maxLength: 140,padding: 0,controller: subtitleController,validator: (value){
                  if(value==null)return "Summary is required";
                  if(value.length<=15)return "Summary must be at least 15 characters";
                  return null;
                },),
                height5,
                if(viewModel.editEvent==null)...[
                 const TitleText(text: "Date and time"),
                const DatePicker(),  
                height10,   
                ],
                const TitleText(text: "Event about",subtitle: "Add more details about your event and include what people can expect if they attend.",),
                DashboardTextform(
                    text: "Type about here*", width: 480, maxLine: 10, maxLength: 2500,padding: 0,controller: aboutController,validator: (value){
                  if(value==null)return "About is required";
                  if(value.length<=20)return "About must be at least 20 characters";
                  return null;
                },),
                height10,
                const TitleText(text: "Registration details"),
                DashboardTextform(
                    text: "Type registration details here", width: 480, maxLine: 10, maxLength: 150,padding: 0,controller: registrationController),
                height10,
                const TitleText(text: "Category"),
                Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 0.5,
                        color: isDarkTheme(context) ? Colors.white : Colors.black)),
                child: DropdownButton(
                  value: selectedType,
                  items: eventType
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  underline: const SizedBox(),
                  alignment: Alignment.center,
                  icon: null,
                  borderRadius: BorderRadius.circular(10),
                  onChanged: (value) => setState(() {
                    selectedType = value!;
                  }),
                ),
              ),
                height20,
                const TitleText(text: "How much do you want to charge for tickets?",subtitle: "Our tool can only generate one General Admission ticket for now. You can edit and add more ticket types later.",),
                Row(
                  children: [
                    SizedBox(width: 160,child: TextFormField(controller: ticketFeeController,decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),fillColor: Colors.transparent,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Price*"),)),
                  ],
                ),
                height10,
                 const TitleText(text: "What's the capacity for your event?",subtitle: "Event capacity is the total number of tickets you're willing to sell.",),
                Row(
                  children: [
                    SizedBox(width: 160,child: TextFormField(controller: ticketStockController,decoration: InputDecoration(contentPadding: const EdgeInsets.all(10),fillColor: Colors.transparent,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Total capacity*"),)),
                  ],
                ),
                height20,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(onPressed: ()async{
                    if(!key.currentState!.validate())return;
                    String? link;
                    if(viewModel.editEvent!=null)
                    {
                      if(viewModel.filePath!=null)link = await viewModel.getLink();
                      Map<String,dynamic> event = {
                      "title":titleController.text,
                      "poster":link??viewModel.editEvent!.poster,
                      "subtitle":subtitleController.text,
                      "about":aboutController.text,
                      "registration":registrationController.text,
                      "location":viewModel.editEvent!.location,
                      "category":selectedType,
                      "fee":ticketFeeController.text,
                      "stock":ticketStockController.text,
                      "id":viewModel.editEvent!.id,
                      "order":DateTime.now().microsecondsSinceEpoch,
                    };
                    context.read<DashboardViewModel>().updateEvent(event: event);
                    clear();
                    return;
                    }
                    final user = FirebaseAuth.instance.currentUser!;
                    link = await viewModel.getLink();
                    if(link==null)return;
                    Map<String,dynamic> event = {
                      "title":titleController.text,
                      "poster":link,
                      "subtitle":subtitleController.text,
                      "about":aboutController.text,
                      "registration":registrationController.text,
                      "starttime":viewModel.startTime.format(context),
                      "endtime":viewModel.endTime.format(context),
                      "date":viewModel.selectedDate.toString(),
                      "location":"online",
                      "category":selectedType,
                      "fee":ticketFeeController.text,
                      "stock":ticketStockController.text,
                      "creatername":user.displayName??user.email!.split("@").first,
                      "createrid":user.uid,
                      "id":DateTime.now().microsecondsSinceEpoch.toString(),
                      "order":DateTime.now().microsecondsSinceEpoch,
                    };
                    context.read<DashboardViewModel>().createEvent(event: event);
                    clear();
                  },minWidth: double.infinity,height: 60,color: AppColor.primaryColor,child: const Text("Create")),
                )
              ],
            ),
        ),
      ),
    );
  }

  void clear()
  {
    titleController.text = "";
    aboutController.text = "";
    subtitleController.text ="";
    ticketFeeController.text ="";
    ticketStockController.text ="";
    registrationController.text = "";
    // selectedType ="";
    imageLink = null;
    setState(() {
      
    });
  }
}
