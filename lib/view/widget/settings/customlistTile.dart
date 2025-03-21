import 'package:flutter/material.dart';

class CostumListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final subtitle;
  final Function()? onTap;
  const CostumListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      subtitle: subtitle != null ? Text(subtitle) : null,
    );
  }
}