

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_media/res/color.dart';

class Utlis {

  static void fieldFocus(BuildContext context,FocusNode currentFocus,FocusNode nextFocus){
   currentFocus.unfocus();
   FocusScope.of(context).requestFocus(nextFocus);
  }


  toastMessage(String message){
     Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.primaryTextTextColor,
      textColor: AppColors.whiteColor,
      fontSize: 16
     
     );
  }
  
  
}