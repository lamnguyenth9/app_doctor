import 'dart:convert';

import 'package:doctor_apointment/component/button.dart';
import 'package:doctor_apointment/main.dart';
import 'package:doctor_apointment/model/auth_model.dart';
import 'package:doctor_apointment/providers/dio_provider.dart';
import 'package:doctor_apointment/utlis/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
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
                  title: 'Sign in',
                  disable: false,
                  onPressed: () async {
                    final token = await DioProvider()
                        .getToken(_emailController.text, _passController.text);
                    if (token) {
                      //auth.loginSuccess();
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final tokenValue = prefs.getString('token') ?? '';
                      if (tokenValue.isNotEmpty && tokenValue != '') {
                        final response = await DioProvider().getUser(tokenValue);
                        if (response != null) {
                          setState(() {
                            Map<String,dynamic> appointment={};
                           final user = json.decode(response);
                           print("haha $user");
                            for (var doctorData in user['doctor']) {
                              if (doctorData['apointments'] != null) {
                                appointment = doctorData;
                              }
                            }
                            auth.loginSuccess(user, appointment);
                            MyApp.navigatorKey.currentState!.pushNamed('main');
                          });
                        }
                      }
                      
                    }
                  },
                );
              },
            )
          ],
        ));
  }
}
