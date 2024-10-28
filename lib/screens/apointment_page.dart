import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor_apointment/providers/dio_provider.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApointmentPage extends StatefulWidget {
  const ApointmentPage({super.key});

  @override
  State<ApointmentPage> createState() => _ApointmentPageState();
}

enum FilterStatus { upcoming, complete, cancel }

class _ApointmentPageState extends State<ApointmentPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.center;
  List<dynamic> schedules = [
    
  ];
  Future<void> getAppointments()async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    final token=prefs.getString('token')??'';
    final appointment=await DioProvider().getAppointment(token);
    if(appointment!='Error'){
      setState(() {
        schedules=json.decode(appointment);
        print(schedules.toString());
      });
    }
  }
  @override
  void initState() {
    getAppointments();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<dynamic> filterSchedules = schedules.where((var schedule) {
      switch (schedule['status']) {
        case 'upcoming':
          schedule['status'] = FilterStatus.upcoming;
          break;
        case 'complete':
          schedule['status'] = FilterStatus.complete;
          break;
        case 'cancel':
          schedule['status'] = FilterStatus.cancel;
          break;
      }
      return schedule['status']==status;
    }).toList();
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Schedule apointment",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Config.spaceSmall,
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for(FilterStatus filterStatus in FilterStatus.values)
                    Expanded(child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if(filterStatus==FilterStatus.upcoming){
                            status=FilterStatus.upcoming;
                            _alignment=Alignment.centerLeft;
                          } else if(filterStatus==FilterStatus.complete){
                            status=FilterStatus.complete;
                            _alignment=Alignment.center;
                          } else if(filterStatus==FilterStatus.cancel){
                            status=FilterStatus.cancel;
                            _alignment=Alignment.centerRight;
                          }
                        });
                      },
                      child: Center(
                        child: Text(filterStatus.name),
                      ),
                    ))
                  ],
                ),
              ),
              AnimatedAlign(
                alignment: _alignment, 
                duration: Duration(milliseconds: 200),
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Config.primaryColor,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text(
                       status.name,
                       style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                       ),
                    ),
                  ),
                ),)
            ],
          ),
          Config.spaceSmall,
          Expanded(child: ListView.builder(
            itemCount: filterSchedules.length,
            itemBuilder: (context, index) {
              
              var _schedule=filterSchedules[index];
              bool _isLastElement=filterSchedules.length+1==index;
              return Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(20)
                ),
                margin: !_isLastElement?EdgeInsets.only(bottom: 20):EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(_schedule['doctor_profile']),
                          ),
                          Config.spaceSmall,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _schedule['doctor_name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                _schedule['category'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      SchedualWidget(),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: OutlinedButton(
                            onPressed: (){}, 
                            child: Text(
                              "Cancel",style: TextStyle(color: Config.primaryColor),
                            ))),
                            SizedBox(width: 20,),
                            Expanded(child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Config.primaryColor
                              ),
                            onPressed: (){}, 
                            child: Text(
                              "ReSchedule",style: TextStyle(color: Colors.white),
                            ))),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },))
        ],
      ),
    ));
  }
}
class SchedualWidget extends StatelessWidget {
  const SchedualWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),

      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.calendar_today,color: Config.primaryColor,size: 15,),
          SizedBox(width: 5,),
          Text(
            "Monday, 10/10/2024",
            style: TextStyle(color: Config.primaryColor),
          ),
          SizedBox(width: 20,),
          Icon(Icons.access_alarm,color: Config.primaryColor,size: 17,),
          SizedBox(width: 5,),
          Flexible(child: Text("2:00 AM",style: TextStyle(color: Config.primaryColor),))
          
        ],
      ),
    );
  }
}