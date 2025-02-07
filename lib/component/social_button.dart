import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.social});
  final String social;


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        side: BorderSide(
          width: 1,color: Colors.black
        )
      ),
      onPressed: (){},
      child: SizedBox(
        width: Config.widthSize*0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/$social.png",
            width: 40,
            height: 40,),
            Text(social.toUpperCase(),
            style: TextStyle(
              color: Colors.black
            ),)
          ],
        ),
      ),
    );
  }
}