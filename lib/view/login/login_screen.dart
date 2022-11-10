

import 'package:flutter/material.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            InputTextField(
              myController: emailController,
             focusNode: emailFocusNode,
              onFitedSubmittedValue:(newValue) {
                
              }, 
              onValidator: (value) {
                return value.isEmpty?"Enter email":null;
              },
               keyBoradType: TextInputType.emailAddress,
                hint: "Email", 
                obsureText: false

                ),

                SizedBox(
                  height: 30,
                ),
          
            RoundButton(
              loading: false,
              title: "Login",onPress: (){},)
          ],
        ),
      ),
    );
  }
}