import 'package:doctor_apointment/component/doctor_card.dart';
import 'package:doctor_apointment/model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(
      padding: EdgeInsets.only(top: 20,left: 20,right: 20),
      child: Column(
        children: [
          const Text(
            "My Favorite Doctor",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20,),
          Expanded(child: Consumer<AuthModel>(
            builder: (BuildContext context, AuthModel auth, Widget? child) { 
              return ListView.builder(
              itemCount: auth.getFavDoc.length,
              itemBuilder: (context, index) {
              return DoctorCard(doctor: auth.getFavDoc[index],isFav: true,);
            },);
             },
            
          ))
        ],
      ),
    ));
  }
}