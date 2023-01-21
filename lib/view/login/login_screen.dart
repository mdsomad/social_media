import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

import '../../utils/routes/route_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Weclcome to app",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Enter your email address\n to connect to your account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Form(
                    key: _formkey,
                    child: Padding(
                      padding:  EdgeInsets.only(top: height *.06,bottom: height * 0.01),
                      child: Column(
                        children: [
                          InputTextField(
                              myController: emailController,
                              focusNode: emailFocusNode,
                              onFitedSubmittedValue: (newValue) {},
                              onValidator: (value) {
                                return value.isEmpty ? "Enter email" : null;
                              },
                              keyBoradType: TextInputType.emailAddress,
                              hint: "Email",
                              obsureText: false),
                          SizedBox(height:height * 0.01,),
                          InputTextField(
                              myController: passwordController,
                              focusNode: passwordFocusNode,
                              onFitedSubmittedValue: (newValue) {},
                              onValidator: (value) {
                                return value.isEmpty ? "Enter password" : null;
                              },
                              keyBoradType: TextInputType.emailAddress,
                              hint: "password",
                              obsureText: true),
                        ],
                      ),
                    )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RouteName.forgotScreen);
                      },
                      child: Text("Forgot password?",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 15,
                              decoration: TextDecoration.underline
                            )
                      ),
                    ),
                  ),
                  
                SizedBox(
                  height: 30,
                ),

               ChangeNotifierProvider(create:(context) => LoginController(),
               child: Consumer<LoginController>(
                builder: (context, value, child) {
                  return    RoundButton(
                
                  loading: value.loading,
                  title: "Login",
                  onPress: () {
                
                    if(_formkey.currentState!.validate()){
                      value.login(context,emailController.text.toString(), passwordController.text.toString());
                    }
                  },
                );
                
               },),
               ),



                SizedBox(height: height*.03),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.signUpScreen);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account?",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 15,
                          ),
                      children: [
                        TextSpan(
                          text: "Sing up",
                          style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 15,
                            decoration: TextDecoration.underline
                          )
                        )
                      ]
                    ),
                    
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
