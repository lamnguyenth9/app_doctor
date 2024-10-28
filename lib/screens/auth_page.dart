import 'package:doctor_apointment/component/login_form.dart';
import 'package:doctor_apointment/component/sign_up_form.dart';
import 'package:doctor_apointment/component/social_button.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:doctor_apointment/utlis/text.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isSignIn=true;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body:Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      child: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppText.enText['welcome_text']!,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold
          ),
          ),
          Config.spaceSmall,
          
          Text(
            _isSignIn
            ?
            AppText.enText['signIn_text']!
            :AppText.enText['register_text']!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),),
          Config.spaceSmall,
          _isSignIn? LoginForm():SignUpForm(),
          Config.spaceSmall,
          
          _isSignIn ?Center(
            child: 
            TextButton(
              onPressed: (){},
              child: Text(
                AppText.enText['forgot-password']!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
              ),
            ),
          ):Container(),
          Spacer(),
          Center(
            child: Text(
              AppText.enText['social-login']!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade500
          ),
            ),
            
          ),
          Config.spaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SocialButton(social: "google"),
              SocialButton(social: "facebook")
            ],
          ),
          Config.spaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isSignIn?
              AppText.enText['signUp_text']!
              :AppText.enText['register_text']!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade500
          ),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  _isSignIn=!_isSignIn;
                });
              },
              child: Text(
               _isSignIn? "Sign Up":"Sign In",
                style: TextStyle(
                  fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
                ),
              ),
            )
            ],
          )
        ],
      )),)
    );
  }
}