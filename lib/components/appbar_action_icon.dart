import 'package:flutter/widgets.dart';

class AppbarActionsIcons extends StatefulWidget {
  const AppbarActionsIcons({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final String text;

  @override
  State<AppbarActionsIcons> createState() => _AppbarActionsIconsState();
}

class _AppbarActionsIconsState extends State<AppbarActionsIcons> {
  @override
  Widget build(BuildContext context) {
    return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon),
            Text(
              widget.text,
            )
          ],
        );
  }
}