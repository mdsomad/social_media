
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class SplashServices {


  

  void isLogin(BuildContext , context){

    FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      
      SessionController().userid = user.uid.toString();

       Timer(Duration(seconds: 3),()=> Navigator.pushNamed(context, RouteName.dashboardScreen));

    }else{
       Timer(Duration(seconds: 3),()=> Navigator.pushNamed(context, RouteName.loginView));

    }
    
  }
  
}