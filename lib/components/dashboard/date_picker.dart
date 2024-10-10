import 'package:event_manager/utils/dark_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dashboard/view_models/dashboard_view_model.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    return Center(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 2,child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(onTap: (){
                showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2060)).then((value) {
                  if(value==null)return;
                  context.read<DashboardViewModel>().setDate(value);
                },);
              },child: Container(alignment: Alignment.center,margin: const EdgeInsets.all(5),height: 60,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),border: Border.all(width: 0.5,color: isDarkTheme(context)?Colors.white:Colors.black)),child: Text(viewModel.selectedDate.toString().split(" ").first),)),
              const Text(" ")            
            ],
          )),
          Expanded(flex: 1,child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                  if(value==null)return;
                  context.read<DashboardViewModel>().setStartTime(value);
                },);
              },child: Container(alignment: Alignment.center,margin: const EdgeInsets.all(5),height: 60,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),border: Border.all(width: 0.5,color: isDarkTheme(context)?Colors.white:Colors.black)),child: Text(viewModel.startTime.format(context)),)),
            const Text("Start Time")
            ],
          )),
          Expanded(flex: 1,child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                  if(value==null)return;
                  context.read<DashboardViewModel>().setEndTime(value);
                },);
              },child: Container(alignment: Alignment.center,margin: const EdgeInsets.all(5),height: 60,decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),border: Border.all(width: 0.5,color: isDarkTheme(context)?Colors.white:Colors.black)),child: Text(viewModel.endTime.format(context)),)),
              const Text("End Time")
            ],
          )),
        ],
      ),
    );
  }
}