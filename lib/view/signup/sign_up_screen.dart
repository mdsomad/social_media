import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/routes/Utlis.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/signup/signup_controller.dart';

import '../../res/component/input_text_field.dart';
import '../../res/component/round_button.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

   final  ref = FirebaseDatabase.instance.ref().child("User");
  
  
   final _formkey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final userNameFocusNode = FocusNode();

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    userNameFocusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ChangeNotifierProvider(create: (context) => SignUpController(),
          child: Consumer<SignUpController>(
            builder: (context, value, child) {
               return SingleChildScrollView(

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
                  "Enter your email address\n to register to your account",
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
                              myController: userNameController,
                              focusNode: userNameFocusNode,
                              onFitedSubmittedValue: (newValue) {},
                              onValidator: (value) {
                                return value.isEmpty ? "Creat UserName" : null;
                              },
                              keyBoradType: TextInputType.emailAddress,
                              hint: "UserName",
                              obsureText: false),
                          SizedBox(height:height * 0.01,),
                          InputTextField(
                              myController: emailController,
                              focusNode: emailFocusNode,
                              onFitedSubmittedValue: (newValue) {
                                Utlis.fieldFocus(context, emailFocusNode, passwordFocusNode);
                              },
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
                              obsureText: true
                              ),
                        ],
                      ),
                    )),
                  
                SizedBox(
                  height: 30,
                ),
                RoundButton(
                
                  loading: value.loading,
                  title: "SignUp",
                  onPress: () {
                
                    if(_formkey.currentState!.validate()){
                      value.signup(context,userNameController.text.toString(), emailController.text.toString(), passwordController.text.toString());
                    }
                  },
                ),
                SizedBox(height: height*.03),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.loginView);
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Alread have an account?",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 15,
                          ),
                      children: [
                        TextSpan(
                          text: "Login in",
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
          );
          },),
          )
        ),
      ),
    );
  }
}