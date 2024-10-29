import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:event_manager/home/models/event_model.dart';

import '/core/colors.dart';
import '/core/size.dart';
import '/dashboard/view_models/dashboard_view_model.dart';
import '/utils/appbar.dart';
import '/utils/loading_screen.dart';

String? selectedDate;


//TODO: Make full user event controlls and event add the location and location feed

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.shell,
  });
  final StatefulNavigationShell shell;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context.read<DashboardViewModel>().getMyEvents());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    if(viewModel.loading)
    {
      return const LoadingScreen();
    }
    return Scaffold(
      drawer: screenSize.width<=900?DashBoardDrawer(shell: widget.shell):null,
      appBar: customAppBar(screenSize,context),
      body: Row(
        children: [
          if(screenSize.width>900)
          DashBoardDrawer(shell: widget.shell),
          if(widget.shell.currentIndex==3&&screenSize.width>900)
          ...[
            Expanded(child: widget.shell),
          ]
          else
          Expanded(child: widget.shell)
        ],
      ),
    );
  }
}

class DashBoardDrawer extends StatefulWidget {
  const DashBoardDrawer({
    super.key,
    required this.shell,
  });
  final StatefulNavigationShell shell;

  @override
  State<DashBoardDrawer> createState() => _DashBoardDrawerState();
}

class _DashBoardDrawerState extends State<DashBoardDrawer> {
  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    return Container(margin: const EdgeInsets.all(10),padding: const EdgeInsets.all(10),width: 240,height: double.infinity,decoration: BoxDecoration(color: AppColor.secondaryColor(context),borderRadius: BorderRadius.circular(4)),child: Column(
            children: [
               width30,
              const CircleAvatar(radius: 40,backgroundColor: AppColor.primaryColor,child: Icon(Icons.account_circle),),
              Text(viewModel.userModel!.name,style: GoogleFonts.aBeeZee(fontSize: 30,fontWeight: FontWeight.w800),maxLines: 1,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              const Icon(Icons.circle,size: 4,),
              width5,
              Text("${viewModel.userModel!.followers.length} Following"),
                ],
              ),
              height35,
              DashBoardDrawerButton(onTap: () => widget.shell.goBranch(0),selected: widget.shell.currentIndex==0, title: "Events"),
              DashBoardDrawerButton(onTap: () => widget.shell.goBranch(1),selected: widget.shell.currentIndex==1, title: "Category"),
              DashBoardDrawerButton(onTap: () => widget.shell.goBranch(2),selected: widget.shell.currentIndex==2, title: "Orders"),
              DashBoardDrawerButton(onTap: () => widget.shell.goBranch(3),selected: widget.shell.currentIndex==3, title: "Create"),
              // GestureDetector(onTap: () => widget.shell.goBranch(0),child: Card(margin: const EdgeInsets.all(0),child: Container(margin: const EdgeInsets.only(bottom: 7),width: double.infinity,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: const Color.fromARGB(255, 77, 77, 77)),child: const Center(child: Text("Events"),),))),
              // GestureDetector(onTap: () => widget.shell.goBranch(1),child: Card(margin: const EdgeInsets.all(0),child: Container(margin: const EdgeInsets.only(bottom: 7),width: double.infinity,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: const Color.fromARGB(255, 77, 77, 77)),child: const Center(child: Text("Categorys"),),))),
              // GestureDetector(onTap: () => widget.shell.goBranch(2),child: Card(margin: const EdgeInsets.all(0),child: Container(margin: const EdgeInsets.only(bottom: 7),width: double.infinity,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: const Color.fromARGB(255, 77, 77, 77)),child: const Center(child: Text("Orders"),),))),
              // // GestureDetector(onTap: () => widget.shell.goBranch(2),child: Card(margin: const EdgeInsets.all(0),child: Container(margin: const EdgeInsets.only(bottom: 7),width: double.infinity,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: const Color.fromARGB(255, 77, 77, 77)),child: const Center(child: Text("Payments"),),))),
              // GestureDetector(onTap: () => widget.shell.goBranch(3),child: Card(margin: const EdgeInsets.all(0),child: Container(margin: const EdgeInsets.only(bottom: 7),width: double.infinity,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: const Color.fromARGB(255, 77, 77, 77)),child: const Center(child: Text("Create"),),))),
              const Spacer(),
              TextButton(onPressed: ()=>FirebaseAuth.instance.signOut(), child: const Text("SignOut")),
              height30,
            ],
          ),);
  }
}

class DashBoardDrawerButton extends StatefulWidget {
  const DashBoardDrawerButton({
    super.key,
    this.onTap,
    required this.selected,
    required this.title,
  });
  final void Function()? onTap;
  final bool selected;
  final String title;

  @override
  State<DashBoardDrawerButton> createState() => _DashBoardDrawerButtonState();
}

class _DashBoardDrawerButtonState extends State<DashBoardDrawerButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:widget.selected? AppColor.primaryColor: AppColor.tertiaryColor(context)),
            child: Center(
              child: Text(widget.title),
            ),
          ),
        ));
  }
}

class DashBoardEventPage extends StatefulWidget {
  const DashBoardEventPage({super.key});

  @override
  State<DashBoardEventPage> createState() => _DashBoardEventPageState();
}

class _DashBoardEventPageState extends State<DashBoardEventPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    return SingleChildScrollView(
      child: Column(
        children: [
          height20,
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              GestureDetector(onTap: ()=>context.read<DashboardViewModel>().showAllEvents(),child: DashBoardCard(title: "All Events",icon: Icons.article_outlined, progress: 0.1, amount: viewModel.myEvents.length.toString(), color: const Color.fromARGB(255, 77, 255, 83))),
              GestureDetector(onTap: ()=>context.read<DashboardViewModel>().showOutOfStockEvents(),child: DashBoardCard(title: "Out of Stock",icon: Icons.add_business_rounded, progress: 0.1, amount: viewModel.outOfStockEvents.length.toString(), color: const Color.fromARGB(255, 240, 255, 77))),
              GestureDetector(onTap: ()=>context.read<DashboardViewModel>().showExpairedEvents(),child: DashBoardCard(title: "Expaire Events",icon: Icons.add_home_work_outlined, progress: 0.1, amount: viewModel.expairedEvents.length.toString(), color: const Color.fromARGB(255, 255, 124, 77))), 
            ],
          ),
          if(screenSize.width<=1000)
          LimitedBox(maxHeight: (70*(viewModel.selectedEvents.length+1.5)).toDouble(),child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: DashBoardTable(selectedEvents: viewModel.selectedEvents),
              ),
            ],
          ),)
          else
          DashBoardTable(selectedEvents: viewModel.selectedEvents),
        ],
      ),
    );
  }
}

class DashBoardTable extends StatefulWidget {
  const DashBoardTable({
    Key? key,
    required this.selectedEvents,
  }) : super(key: key);
  final List<EventModel> selectedEvents;

  @override
  State<DashBoardTable> createState() => _DashBoardTableState();
}

class _DashBoardTableState extends State<DashBoardTable> {
  @override
  Widget build(BuildContext context) {
    return Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              dividerTheme: const DividerThemeData(
                color: Colors.transparent,
                space: 0,
                thickness: 0,
                indent: 0,
                endIndent: 0,
              ),
            ),
            child: Container(
            margin: const EdgeInsets.only(bottom: 20,top: 10),
            padding: const EdgeInsets.all(10),
            decoration:BoxDecoration(
              color: AppColor.secondaryColor(context),
              borderRadius: BorderRadius.circular(7)
            ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Poster')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Stock')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Delete')),
                ],
                border: null,
                showBottomBorder: false,
                dividerThickness: 0.0,
                dataRowHeight: 70,
                rows: List.generate(
                  widget.selectedEvents.length,
                  (index) => DataRow(cells: [
                    DataCell(CachedNetworkImage(
                        imageUrl: widget.selectedEvents[index].poster,
                        width: 60,
                        height: 50)),
                    DataCell(SizedBox(
                        width: 150,
                        child:
                            Text(widget.selectedEvents[index].title, maxLines: 1))),
                    DataCell(
                      Text(widget.selectedEvents[index].fee),
                    ),
                    DataCell(Text(widget.selectedEvents[index].stock)),
                    DataCell(IconButton(onPressed: (){
                      context.read<DashboardViewModel>().setEventToEdit(widget.selectedEvents[index]);
                       context.go("/manage/update/${widget.selectedEvents[index].id}");
                    },icon: const Icon(Icons.edit))),
                    DataCell(IconButton(onPressed: () {
                      showDialog(context: context, builder: (context) => Dialog(child: SizedBox(
                        height: 100,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Are you sure to delete"),
                            height10,
                            MaterialButton(onPressed: () {
                              context.read<DashboardViewModel>().deleteEvent(widget.selectedEvents[index]);
                              context.pop();
                            },child: Text("Delete"),color: AppColor.primaryColor)
                          ],
                        ),
                      ),));
                    },icon: const Icon(Icons.delete,color: Colors.red)))
                  ]),
                ),
              ),
            ),
          );
  }
}

class DashBoardCard extends StatefulWidget {
  const DashBoardCard({
    super.key,
    required this.icon,
    required this.progress,
    required this.amount,
    required this.title,
    required this.color,
  });
  final IconData icon;
  final double progress;
  final String amount;
  final String title;
  final Color color;

  @override
  State<DashBoardCard> createState() => _DashBoardCardState();
}

class _DashBoardCardState extends State<DashBoardCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(10),
      child: Card(
        child: Container(
                    padding: const EdgeInsets.all(15),
                    width: 240,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.tertiaryColor(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(widget.icon,color: widget.color,size: 50),
                        height5,
                        Text(widget.title),
                        height5,
                        LinearProgressIndicator(borderRadius: BorderRadius.circular(5),color: AppColor.primaryColor,value: 90,),
                        height5,
                        Text("${widget.amount} events"),
                      ],
                    ),
                  ),
      ),
    );
  }
}

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({
//     super.key,
//     required this.eventModel,
//   });
//   final EventModel eventModel;

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 500,
//       height: 550,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Event Details'),
//           actions: [IconButton(onPressed: (){context.read<EventViewModel>().setEventData(widget.eventModel);
//                    AppNavigation.eventDetailsPage(context,widget.eventModel.id);}, icon: const Icon(Icons.open_in_full_rounded))],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildCard('Tickets Sold', 'Existing sold ${widget.eventModel.stock}'),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               const Text(
//                 'Share',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
              
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'https://$url.com/#/details/${widget.eventModel.id}',
//                       style: const TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.copy),
//                     onPressed: () {
//                       Clipboard.setData(ClipboardData(text: 'https://$url.com/#/details/${widget.eventModel.id}'));
//                       context.read<DashboardViewModel>().showMessage(ToastificationStyle.fillColored, ToastificationType.success, "Successfully copied to clipboard");
//                     },
//                   ),
//                   IconButton(
//                       icon: const Icon(Icons.share),
//                       onPressed: () {
//                         Share.share('Check out my event https://$url.com/#/details/${widget.eventModel.id}');
//                       },
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Edit',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               height10,
//               // MaterialButton(color: AppColor.primaryColor,padding: const EdgeInsets.all(15),child: const Center(child: Text("Edit Event")),onPressed: ()=>showDialog(context: context,builder: (context) => Dialog(shape: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),child: EventCreatingPage(eventModel: widget.eventModel)),)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCard(String title, String content) {
//     return GestureDetector(
//       onTap: (){
//         AppNavigation.showEventTickets(context, widget.eventModel.id);
//       },
//       child: Container(
//         margin: const EdgeInsets.all(5),
//         padding: const EdgeInsets.all(50),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           // borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: AppColor.primaryColor,width: 2)
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: GoogleFonts.aBeeZee(fontSize: 20)
//             ),
//             const SizedBox(height: 10),
//             Text(
//               content,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
