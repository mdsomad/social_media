import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/utlis.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class SignUpController with ChangeNotifier {


  final auth = FirebaseAuth.instance;
  final  ref = FirebaseDatabase.instance.ref().child("User");
  final firestore = FirebaseFirestore.instance.collection('User');

  

   
  bool _loading = false;
  bool get loading => _loading;

  setLoading (bool value){
     _loading = value;
     notifyListeners();
  }


  void signup (BuildContext context , String username,String email,String password)async{
    print(email);
    setLoading(true);
     try {
       await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
        ).then((value){
            SessionController().userid = value.user!.uid.toString();
           ref.child(value.user!.uid.toString()).set({
              'uid':value.user!.uid.toString(),
              'email':value.user!.email.toString(),
              'onlineStatus':'noOne',
              'phone':'',
              'userName':username,
              "profile":'',
           }).then((value){
            Navigator.pushNamed(context, RouteName.dashboardScreen);
            setLoading(false);
           }).onError((error, stackTrace){
              setLoading(false);
              Utlis().toastMessage(error.toString());
           });
          
        });

     } catch (e) {
       Utlis().toastMessage(e.toString());
       setLoading(false);
     }
  }
  
}