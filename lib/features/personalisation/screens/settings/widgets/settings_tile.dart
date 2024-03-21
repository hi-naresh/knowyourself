import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({super.key, required this.title, required this.subtitle, required this.icon, this.trailing, this.onTap});
  final String title,subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge,),
      leading: Icon(icon),
      subtitle: Text(subtitle,style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
