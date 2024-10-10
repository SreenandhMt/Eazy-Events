import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppbarActionsIcons extends StatefulWidget {
  const AppbarActionsIcons({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  State<AppbarActionsIcons> createState() => _AppbarActionsIconsState();
}

class _AppbarActionsIconsState extends State<AppbarActionsIcons> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: widget.onTap,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon),
              Text(
                widget.text,
              )
            ],
          ),
    );
  }
}