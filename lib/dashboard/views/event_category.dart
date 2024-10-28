import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:event_manager/home/models/event_model.dart';
import 'package:provider/provider.dart';

import '../view_models/dashboard_view_model.dart';

class EventCategoryDashBoard extends StatefulWidget {
  const EventCategoryDashBoard({super.key});

  @override
  State<EventCategoryDashBoard> createState() => EventCategoryDashBoardState();
}

class EventCategoryDashBoardState extends State<EventCategoryDashBoard> {
  @override
  Widget build(BuildContext context) {
    DashboardViewModel viewModel = context.watch<DashboardViewModel>();
    return ListView(
      children: List.generate(viewModel.categoryFilter.length, (index) {
        final category = viewModel.categoryFilter[index];
        return CategoryListWidget(event: category, category: category.first.category);
      },),
    );
  }
}

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({
    super.key,
    required this.event,
    required this.category,
  });
  final List<EventModel> event;
  final String category;

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.category,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
         Theme(
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
                  margin: const EdgeInsets.only(left: 50,right: 50,bottom: 20,top: 10),
                  decoration:BoxDecoration(
                    color: Colors.grey.shade600,
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
                        widget.event.length,
                        (index) => DataRow(color: WidgetStatePropertyAll(DateTime.parse(widget.event[index].date).microsecondsSinceEpoch < DateTime.now().microsecondsSinceEpoch?Colors.red.shade200:Colors.transparent),cells: [
                          DataCell(CachedNetworkImage(
                              imageUrl: widget.event[index].poster,
                              width: 60,
                              height: 50)),
                          DataCell(SizedBox(
                              width: 150,
                              child:
                                  Text(widget.event[index].title, maxLines: 1))),
                          DataCell(
                            Text(widget.event[index].fee),
                          ),
                          DataCell(Text(widget.event[index].stock)),
                          DataCell(IconButton(onPressed: (){},icon: Icon(Icons.edit))),//TODO: add edit
                          const DataCell(Icon(Icons.delete,color: Colors.red))//TODO: add Delete with conformation
                        ]),
                      ),
                    ),
                  ),
                ),
      ],
    );
  }
}