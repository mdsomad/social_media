

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/Utlis.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../utils/routes/route_name.dart';

class LoginController with ChangeNotifier{
  
final auth = FirebaseAuth.instance;


  

   
  bool _loading = false;
  bool get loading => _loading;

  setLoading (bool value){
     _loading = value;
     notifyListeners();
  }


  void login (BuildContext context ,String email,String password)async{
    print(email);
    setLoading(true);
     try {
       await auth.signInWithEmailAndPassword(
        email: email, 
        password: password
        ).then((value){
            SessionController().userid = value.user!.uid.toString();
            Navigator.pushNamed(context, RouteName.dashboardScreen);
            setLoading(false);
          
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