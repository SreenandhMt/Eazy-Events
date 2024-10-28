import 'package:flutter/material.dart';

class AppbarActionsIcons extends StatefulWidget {
  const AppbarActionsIcons({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
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