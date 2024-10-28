import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(
      {super.key,
      required this.width,
      required this.title,
      required this.disable,
      required this.onPressed});
  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(onPressed:disable?null: onPressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Config.primaryColor,
        foregroundColor: Colors.white
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      )),
    );
  }
}
