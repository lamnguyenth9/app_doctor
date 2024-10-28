import 'package:doctor_apointment/main.dart';
import 'package:doctor_apointment/screens/doctor_details.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key,  required this.doctor, required this.isFav});
  
  final Map<String,dynamic> doctor;
  final bool isFav;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize*0.33,
                child: Image.network(
                  "http://10.0.2.2:8000/${doctor['doctor_profile']}"
                  ,fit: BoxFit.fill,),

              ),
              Flexible(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dr ${doctor['doctor_name']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "${doctor['category']}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.star_border,color: Colors.yellow,size: 16,),
                      Spacer(flex: 1,),
                      Text("4.5"),
                      Spacer(flex: 1,),
                      Text("Review"),
                      Spacer(flex: 1,),
                      Text("(20)"),
                      Spacer(flex: 7,),
                    ],
                  )
                ],
              ),))
            ],
          ),
        ),
        onTap: (){

          MyApp.navigatorKey.currentState!.push(MaterialPageRoute(builder: (_)=>DoctorDetails(
            doctor: doctor,
            isFav: isFav,
          )));
        },
      ),
    );
  }
}