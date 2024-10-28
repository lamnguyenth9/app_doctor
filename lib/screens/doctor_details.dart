import 'package:doctor_apointment/component/button.dart';
import 'package:doctor_apointment/component/custom_appbar.dart';
import 'package:doctor_apointment/model/auth_model.dart';
import 'package:doctor_apointment/providers/dio_provider.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key, required this.doctor, required this.isFav});
  final Map<String,dynamic> doctor;
  final bool isFav;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  Map<String,dynamic> doctor={};
  bool isFav=false;
  @override
  void initState() {
    doctor=widget.doctor;
    isFav=widget.isFav;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   // final Map<String,dynamic> doctor=ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar:  CustomAppbar(
        appTitle: "Doctor detail",
        icon: FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(onPressed: (){}, icon: IconButton(
            onPressed: ()async{
              final list=Provider.of<AuthModel>(context,listen: false).getFav;
              if(list.contains(doctor['doc_id'])){
                list.removeWhere((id)=>id==doctor['doc_id']);
              }else{
                list.add(doctor['doc_id']);
              }
              Provider.of<AuthModel>(context,listen: false).setFavList(list);
              final SharedPreferences prefs=await 
              SharedPreferences.getInstance();
              final token=prefs.getString('token')??'';
              if(token.isNotEmpty && token!=''){
                final respose=await DioProvider().storeFavDoc(token, list);
                if(respose==200){
                  setState(() {
                isFav= !isFav;
              });
                }
              }
              
            },
            icon: FaIcon(isFav?Icons.favorite_rounded:Icons.favorite_outline,color: Colors.red,),
          ))
        ],
      ),
      body: SingleChildScrollView(child: Column(
        children: [
            AboutDoctor(doctor: doctor,),
            DetailBody(doctor: doctor,),
            
            Padding(padding: EdgeInsets.all(20),
            child: Button(
              width: double.infinity, 
              title: "Book Apointment", 
              disable: false, 
              onPressed: (){
                Navigator.pushNamed(context, 'booking_page',arguments: {'doctor_id':doctor['doc_id']});
              }),)
        ],
      )),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({super.key, required this.doctor});
  final Map<String,dynamic> doctor;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          CircleAvatar(
            radius: 65,
            backgroundImage: NetworkImage("http://10.0.2.2:8000/${doctor['doctor_profile']}"),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text("Dr. ${doctor['doctor_name']}",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize*0.75,
            child:  Text(
              "Trần Duy Hưng là một bác sĩ, Thị trưởng Hà Nội, Chủ tịch Ủy ban Hành chính đầu tiên của Hà Nội, Thứ trưởng Bộ Nội vụ, Thứ trưởng Bộ Y tế Chính phủ Việt Nam Dân chủ Cộng hòa",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
           SizedBox(
            width: Config.widthSize*0.75,
            child:  Text(
              "Bệnh viện Ung Bướu",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          
        ],
      ),
    );
  }
}
class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.doctor});
  final Map<String,dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Config.spaceSmall,
            DoctorInfor(patients: doctor['patients'], exp: doctor['experience'],),
            Config.spaceBig,
            Text(
              "About Doctor",style: TextStyle(
                fontWeight: FontWeight.w600,fontSize: 18
              ),
              
            ),
            Config.spaceSmall,
            Text(
              "${doctor['doctor_name']} sinh tại phố Hàng Bông - Thợ Nhuộm ngày 16 tháng 1 năm 1912. Quê nội là làng Hòe Thị thuộc tổng Phương Canh, phủ Hoài Đức, tỉnh Hà Đông (nay là phường Phương Canh, quận Nam Từ Liêm, Hà Nội). Ông học ngành y cùng với các ông Tôn Thất Tùng, Đặng Văn Ngữ, Nguyễn Hữu Thuyết, Huỳnh Kham, Nhữ Thế Bảo, Ngô Trâm, Lê Đức Mạnh.",
              style: TextStyle(
                height: 1.5,
                fontWeight: FontWeight.w500
              ),
              softWrap: true,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
class DoctorInfor extends StatelessWidget {
  const DoctorInfor({super.key, required this.patients, required this.exp});
  final int patients;
  final int exp;
  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
        InforCard(value: "${patients}", lable: "Patients"),
        SizedBox(width: 15,),
        InforCard(value: "${exp} years", lable: "Experience"),
        SizedBox(width: 15,),
        InforCard(value: "4.5", lable: "rating")
      ],
    );
  }
}
class InforCard extends StatelessWidget {
  const InforCard({super.key, required this.value, required this.lable});
  final String value;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Config.primaryColor
            ),
            padding: EdgeInsets.symmetric(vertical:10,horizontal: 15),
            child: Column(
              children: [
                Text(
                  lable,style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 10,),
                   Text(
                  value,style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                  ),
                ),
              ],
            ),
          ),
    );
  }
}