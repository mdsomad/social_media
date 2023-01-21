

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/Utlis.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../utils/routes/route_name.dart';

class ForgotPasswordController with ChangeNotifier{
  
final auth = FirebaseAuth.instance;


  

   
  bool _loading = false;
  bool get loading => _loading;

  setLoading (bool value){
     _loading = value;
     notifyListeners();
  }


  void ForgotPassword(BuildContext context ,String email)async{
    print(email);
    setLoading(true);
     try {
       await auth.sendPasswordResetEmail(
        email: email, 
        ).then((value){
            setLoading(false);
            Navigator.pushNamed(context, RouteName.loginView);
            Utlis().toastMessage("Please check your email to recover your password");
          
        }).onError((error, stackTrace){
          setLoading(false);
           Utlis().toastMessage(error.toString());
        });

     } catch (e) {
       Utlis().toastMessage(e.toString());
       setLoading(false);
     }
  }



}