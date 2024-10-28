import 'package:doctor_apointment/main.dart';
import 'package:doctor_apointment/providers/dio_provider.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApointmentCard extends StatefulWidget {
  const ApointmentCard({super.key, required this.doctor, required this.color});
  final Map<String,dynamic> doctor;
  final Color color;
  @override
  State<ApointmentCard> createState() => _ApointmentCardState();
}

class _ApointmentCardState extends State<ApointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10)
      ),
      child:  Material(
        color: Colors.transparent,
        child: Padding(padding: EdgeInsets.all(20),
        child: Column(
          children: [
           Row(
            children: [
              CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage("http://10.0.2.2:8000${widget.doctor['doctor_profile']}"),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dr ${widget.doctor['doctor_name']}",style: TextStyle(color: Colors.white),),
                SizedBox(height: 2,),
                Text("${widget.doctor['category']}",style: TextStyle(color: Colors.black))
              ],
            )
            ],
           ),
           Config.spaceSmall,
           SchedualWidget(appointment:widget.doctor['apointments'],),
           Config.spaceSmall,
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                onPressed: (){}, 
                child: Text("Cancel",style: TextStyle(color: Colors.white),))),
              const SizedBox(width: 20,),
              Expanded(child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: ()async{
                  showDialog(context: context, builder: (context) {
                    return RatingDialog(
                      initialRating: 1.0,
                      title: Text("Rate the Doctor",textAlign: TextAlign.center,style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 25
                      ),), 
                      message: Text("Please help us to rate the doctor ",textAlign: TextAlign.center,style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 25
                      ),),
                      image: FlutterLogo(size: 100,),
                      submitButtonText: 'Submit', 
                      commentHint: 'Your review',
                      onSubmitted: (response)async{
                         final SharedPreferences prefs=await SharedPreferences.getInstance();
                         final token=prefs.getString('token')??'';
                         final rating=await DioProvider().storeReview(response.comment, response.rating, widget.doctor['apointments']['id'],  widget.doctor['doc_id'], token);
                         if(rating==200&&rating!=''){
                          MyApp.navigatorKey.currentState!.pushNamed('main');
                         }
                      }) ;
                  },);
                }, 
                child: Text("Complete",style: TextStyle(color: Colors.white),))),
            ],
           )
          ],
        ),),
      ),
    );
  }
}
class SchedualWidget extends StatelessWidget {
   SchedualWidget({super.key,required this.appointment});
  Map<String,dynamic> appointment;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),

      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today,color: Colors.white,size: 15,),
          SizedBox(width: 5,),
          Text(
            "${appointment['day']}, ${appointment['date']}",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 20,),
          Icon(Icons.access_alarm,color: Colors.white,size: 17,),
          SizedBox(width: 5,),
          Flexible(child: Text("${appointment["time"]}",style: TextStyle(color: Colors.white),))
          
        ],
      ),
    );
  }
}