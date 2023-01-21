
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/utils/routes/utlis.dart';
import 'package:tech_media/view_model/services/session_manager.dart';  //* Inpoton user

class ProfileController with ChangeNotifier{



final nameController = TextEditingController();
final phoneController = TextEditingController();
final nameFocusNode = FocusNode();
final phoneFocusNode = FocusNode();

DatabaseReference ref = FirebaseDatabase.instance.ref().child("User");
firebase_storage.FirebaseStorage  storage = firebase_storage.FirebaseStorage.instance;

final picker = ImagePicker();

XFile? _image;
XFile? get image => _image;





 bool _loading = false;
bool get loading => _loading;

  setLoading (bool value){
     _loading = value;
     notifyListeners();
  }




// * Yah hai Image pick karna ka Method
Future pickGalleryImage(BuildContext  context)async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);

    if(pickedFile != null){
      _image = XFile(pickedFile.path);
      uplaodImage(context);
      notifyListeners();
      
    }
}






// * Yah hai Image pick karna ka code Method
Future pickCameraImage(BuildContext  context)async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality: 100);

    if(pickedFile != null){
      _image = XFile(pickedFile.path);
      uplaodImage(context);
      notifyListeners();
    
    }  
    
}





//* Yah hai Image pick karne ka DialogBox
void pickImage(context){
  showDialog(
    context: context,
     builder: (BuildContext context){
      return AlertDialog(
        content: Container(
        height: 120,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.pop(context);
                pickCameraImage(context);    //* <-- Call This pickCameraImage() function
              },
              leading: Icon(Icons.camera,color: AppColors.primaryIconColor,),
              title: Text('Camera'),
            ),

            ListTile(
              onTap: (){
                 Navigator.pop(context);
                 pickGalleryImage(context);   //* <-- Call This pickGalleryImage() function
              },
              leading: Icon(Icons.image,color: AppColors.primaryIconColor,),
              title: Text('Gallery'),
            ),
          ],
        ),
      ),
      );
     }
     
     );
  
}





//* Yah hai Profile pick update karne ka code
void uplaodImage(BuildContext context)async{

  setLoading(true);

  //* Upload Image Firebase Storage code
   firebase_storage.Reference  storageFef = firebase_storage.FirebaseStorage.instance.ref('/profileImage'+SessionController().userid.toString());
   firebase_storage.UploadTask uploadTask = storageFef.putFile(File(image!.path).absolute);
                                              
   await Future.value(uploadTask);
   final newUrl = await storageFef.getDownloadURL();

   ref.child(SessionController().userid.toString()).update({
      "profile":newUrl
   }).then((value){
    Utlis().toastMessage("Profile Update");
    setLoading(false);
    _image = null;
   }).onError((error, stackTrace){
    Utlis().toastMessage(error.toString());
    setLoading(false);
   });
}






//* Yah hai UserName update karne ka code
Future<void> showUserNameDialogAlert(BuildContext context,String name){
  nameController.text = name;
   return showDialog(context: context, builder:(context) {
       return AlertDialog(
        title: Text("Update username"),
         content:SingleChildScrollView(
          child: Column(
            children: [
                InputTextField(
                  myController: nameController,
                   focusNode: nameFocusNode, 
                   onFitedSubmittedValue: (value){

                   }, 
                   onValidator: (value) {
                     
                   }, 
                   keyBoradType: TextInputType.text,
                    hint: "Enter name", 
                    obsureText: false)
            ],
              
          ),
          
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel",style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),)),
            TextButton(onPressed: (){
               Navigator.pop(context);
               ref.child(SessionController().userid.toString()).update({
                  "userName":nameController.text.toString().trim()
               }).then((value){
                nameController.clear();
               });
               
            }, child: Text("Ok",style:Theme.of(context).textTheme.subtitle2))
          ],
       );
       
   },);
}









//* Yah hai UserName update karne ka code
Future<void> showPhoneDialogAlert(BuildContext context,String phone){
  phoneController.text = phone;
   return showDialog(context: context, builder:(context) {
       return AlertDialog(
        title: Text("Update Phone"),
         content:SingleChildScrollView(
          child: Column(
            children: [
                InputTextField(
                  myController: phoneController,
                   focusNode: phoneFocusNode, 
                   onFitedSubmittedValue: (value){

                   }, 
                   onValidator: (value) {
                     
                   }, 
                   keyBoradType: TextInputType.text,
                    hint: "Enter name", 
                    obsureText: false)
            ],
              
          ),
          
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel",style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppColors.alertColor),)),
            TextButton(onPressed: (){
               Navigator.pop(context);
               ref.child(SessionController().userid.toString()).update({
                  "phone":phoneController.text.toString().trim()
               }).then((value){
                phoneController.clear();
               });
               
            }, child: Text("Ok",style:Theme.of(context).textTheme.subtitle2))
          ],
       );
       
   },);
}
  
}