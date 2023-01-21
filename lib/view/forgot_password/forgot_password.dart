import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/view_model/Forgot_password_controller/forgot_password_controller.dart';



class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
 
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
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
          child: SingleChildScrollView(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Enter your email address\n to recover your password",
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
                          
                        ],
                      ),
                    )),
                  
                SizedBox(
                  height: 30,
                ),

               ChangeNotifierProvider(create:(context) => ForgotPasswordController(),
               child: Consumer<ForgotPasswordController>(
                builder: (context, provider, child) {
                  return    RoundButton(
                
                  loading: provider.loading,
                  title: "Recover",
                  onPress: () {
                
                    if(_formkey.currentState!.validate()){
                      provider.ForgotPassword(context,emailController.text.toString());
                    }
                  },
                );
                
               },),
               ),



                SizedBox(height: height*.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}