import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
    this.color,
  });
  final Color? color;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color:widget.color?? Colors.red,));
  }
}