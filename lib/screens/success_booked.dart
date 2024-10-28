import 'package:doctor_apointment/component/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessBooked extends StatelessWidget {
  const SuccessBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Expanded(
            flex: 3,
            child: Lottie.asset('assets/success.json')),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Spacer(),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            child: Button(
              width: double.infinity, 
              title: 'Back to home page', 
              disable: false, 
              onPressed: (){
                Navigator.pushNamed(context, 'main');
              }),)
        ],
      )),
    );
  }
}