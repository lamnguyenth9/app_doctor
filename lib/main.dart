
import 'package:doctor_apointment/model/auth_model.dart';
import 'package:doctor_apointment/screens/apointment_page.dart';
import 'package:doctor_apointment/screens/booking_page.dart';
import 'package:doctor_apointment/screens/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth_page.dart';
import 'screens/main_layout.dart';
import 'screens/success_booked.dart';
import 'utlis/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //this is for push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    //define ThemeData here
    return ChangeNotifierProvider<AuthModel>(
      create: (_)=>AuthModel(),
      child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Flutter Doctor App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            //pre-define input decoration
            inputDecorationTheme: const InputDecorationTheme(
              focusColor: Config.primaryColor,
              border: Config.outlineBorder,
              focusedBorder: Config.focusBorder,
              errorBorder: Config.errorBorder,
              enabledBorder: Config.outlineBorder,
              floatingLabelStyle: TextStyle(color: Config.primaryColor),
              prefixIconColor: Colors.black38,
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Config.primaryColor,
              selectedItemColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.grey.shade700,
              elevation: 10,
              type: BottomNavigationBarType.fixed,
            ),
          ),
          initialRoute: '/', 
          routes: {
            '/': (context) => const AuthPage(),
            'main': (context) => const MainLayout(),
           // 'doc_details':(context)=>DoctorDetails(),
            'booking_page':(context)=>BookingPage(),
            'success_booking':(context)=>SuccessBooked()
          },
        ),
    );
   
  }
}