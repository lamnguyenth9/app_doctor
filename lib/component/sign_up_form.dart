import 'package:doctor_apointment/component/button.dart';
import 'package:doctor_apointment/main.dart';
import 'package:doctor_apointment/model/auth_model.dart';
import 'package:doctor_apointment/providers/dio_provider.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  hintText: 'User Name',
                  labelText: 'User Name',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person_outlined),
                  prefixIconColor: Config.primaryColor),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  hintText: 'Email Adress',
                  labelText: 'Email',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: Config.primaryColor),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obsecurePass,
              cursorColor: Config.primaryColor,
              decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(
                    Icons.password_outlined,
                  ),
                  prefixIconColor: Config.primaryColor,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecurePass = !_obsecurePass;
                        });
                      },
                      icon: _obsecurePass
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: Config.primaryColor,
                            ))),
            ),
            Config.spaceSmall,
            Consumer<AuthModel>(
              builder: (context, auth, child) {
                return Button(
                  width: double.infinity,
                  title: 'Sign Up',
                  disable: false,
                  onPressed: () async {
                    final userRegistration=await DioProvider().registerUser(_nameController.text, _emailController.text, _passController.text);
                    if(userRegistration){
                       final token = await DioProvider()
                        .getToken(_emailController.text, _passController.text);
                        print(token);
                    if (token) {
                      auth.loginSuccess({},{});
                      MyApp.navigatorKey.currentState!.pushNamed('main');
                    }
                    }else{
                      print('Registration not success');
                    }
                    
                  },
                  
                );
              },
            )
          ],
        ));
  }
}