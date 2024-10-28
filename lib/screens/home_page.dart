import 'dart:convert';

import 'package:doctor_apointment/component/apointment_card.dart';
import 'package:doctor_apointment/component/doctor_card.dart';
import 'package:doctor_apointment/model/auth_model.dart';
import 'package:doctor_apointment/providers/dio_provider.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.userDoctor,
      "category": "General",
    },
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Cardiology",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Respirations",
    },
    {
      "icon": FontAwesomeIcons.hand,
      "category": "Dermatology",
    },
    {
      "icon": FontAwesomeIcons.personPregnant,
      "category": "Gynecology",
    },
    {
      "icon": FontAwesomeIcons.teeth,
      "category": "Dental",
    },
  ];
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctor = {};
  List<dynamic> favList=[];

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user=Provider.of<AuthModel>(context,listen: false).getUser;
    doctor=Provider.of<AuthModel>(context,listen: false).getAppointment;
    favList=Provider.of<AuthModel>(context,listen: false).getFav;
    return user.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user['name'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("assets/lam.jpg"),
                        ),
                      )
                    ],
                  ),
                  Config.spaceMedium,
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Config.spaceSmall,
                  SizedBox(
                    height: Config.heightSize * 0.05,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(medCat.length, (index) {
                        return Card(
                          margin: const EdgeInsets.only(right: 20),
                          color: Config.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FaIcon(
                                  medCat[index]['icon'],
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  medCat[index]['category'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Config.spaceSmall,
                  const Text(
                    "Apointment today",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Config.spaceSmall,
                 doctor.isNotEmpty? ApointmentCard(doctor: doctor,color: Config.primaryColor,):Container(),
                  Config.spaceSmall,
                  const Text(
                    "Top Doctors",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Config.spaceMedium,
                  Column(
                    children: List.generate(user['doctor'].length, (index) {
                      return DoctorCard(
                       doctor: user['doctor'][index],
                       isFav: favList.contains(user['doctor'][index]['doc_id'])?true:false,
                      );
                    }),
                  )
                ],
              ),
            )),
          ));
  }
}
