import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.appTitle, this.route, this.icon, this.actions});
  @override
  Size get preferredSize=>const Size.fromHeight(60);

  final String?  appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        widget.appTitle!,style: TextStyle(
          fontSize: 20,
          color: Colors.black
        ),
      ),
      leading: widget.icon!=null?Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Config.primaryColor
        ),
        child: IconButton(
          icon: widget.icon!,
          iconSize: 16,
          color: Colors.white,
          onPressed: () {
            if(widget.route != null){
              Navigator.of(context).pushNamed(widget.route!);
            }else{
              Navigator.pop(context);
            }
          },
        ),
      ):null,
      actions: widget.actions ?? null,
    );
  }
}