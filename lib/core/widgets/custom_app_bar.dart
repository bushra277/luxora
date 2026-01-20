import 'package:flutter/material.dart';
import 'package:task_flutter/core/utils/responsive.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key , required this.title , this.actions , this.leading});
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title , style: TextStyle(fontSize: context.sp(60) , fontWeight: FontWeight.bold),),
      centerTitle: true,
      actions: actions,
      leading: leading,
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}