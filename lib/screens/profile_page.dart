import 'package:doctor_apointment/main.dart';
import 'package:doctor_apointment/providers/dio_provider.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container(
          width: double.infinity,
          color: Config.primaryColor,
          child: Column(
            children: [
              SizedBox(height: 110,),
              CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage('assets/lam.jpg'),
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 10,),
              Text("Mr Lam",style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),),
              SizedBox(height: 10,),
              Text(
                "23 years old",style: TextStyle(
                  color: Colors.white,
                  fontSize: 15
                ),
              )
            ],
          ),
        )),
        Expanded(
          flex: 1,
          child:Container(
            color: Colors.white,
            child: Center(
              child: Card(
                margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: Container(
                  width: 300,
                  height: 250,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          "Profile",style: TextStyle(),
                        ),
                        Divider(color: Colors.grey[300],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person,color: Colors.blueAccent[400],size: 35,),
                            SizedBox(width: 20,),
                            TextButton(onPressed: (){}, 
                            child: Text("Profile",
                            style: TextStyle(
                              color: Config.primaryColor,
                              fontSize: 15
                            ),)),
                            
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.history,color: Colors.blueAccent[400],size: 35,),
                            SizedBox(width: 20,),
                            TextButton(onPressed: (){}, 
                            child: Text("History",
                            style: TextStyle(
                              color: Config.primaryColor,
                              fontSize: 15
                            ),)),
                            
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.logout_outlined,color: Colors.blueAccent[400],size: 35,),
                            SizedBox(width: 20,),
                            TextButton(onPressed: ()
                            async{
                              final SharedPreferences prefs= await SharedPreferences.getInstance();
                              final token=prefs.getString('token')??'';
                              if(token.isNotEmpty??token!=''){
                                final response=await DioProvider().logout(token);
                                if(response==200){
                                  await prefs.remove('token');
                                  setState(() {
                                    MyApp.navigatorKey.currentState!.pushReplacementNamed('/');
                                  });
                                }
                              }
                            }, 
                            child: Text("Log out",
                            style: TextStyle(
                              color: Config.primaryColor,
                              fontSize: 15
                            ),)),
                            
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ) ,
          ) )
      ],
    );
  }
}