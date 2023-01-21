import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/utlis.dart';
import 'package:tech_media/view_model/services/session_manager.dart';





class MessageScreen extends StatefulWidget {
  final String image, name,email,receiverId;
  const MessageScreen({Key? key,required this.image,required this.name,required this.email,required this.receiverId}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
   
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Chat");
  final messageController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name.toString()),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Expanded(child: ListView.builder(
              itemCount: 100,
              itemBuilder:(context, index) {
                 return Text(index.toString());
             },)),
      
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: Row(
                children: [
                  Expanded(
                    child: Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: TextFormField(
        
        controller: messageController,
        cursorColor: AppColors.primaryTextTextColor,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0 ,fontSize: 19),
        decoration: InputDecoration(
          suffixIcon:  InkWell(
            onTap: (){
              sendMessage();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CircleAvatar(
                        child: Icon(Icons.send),
                      ),
            ),
          ),
          hintText: "Enter message",
          contentPadding: const EdgeInsets.all(15),
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0 ,color: AppColors.primaryTextTextColor.withOpacity(0.8)),
          
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldDefaultFocus),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),

          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),

          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.alertColor),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
            borderRadius: BorderRadius.all(Radius.circular(50))
          )
        ),
      ),
    )
                    ),
                 
                ],
               ),
             )
             
             
          ]
          ),
      ),
    );
  }


 sendMessage(){
   if(messageController.text.isEmpty){
    Utlis().toastMessage("Enter Message");
   }else{
     final timeStam = DateTime.now().microsecondsSinceEpoch.toString();
     ref.child(timeStam).set({
       'isSeen':false,
       'message':messageController.text.toString(),
       'sender':SessionController().userid.toString(),
       'receiver':widget.receiverId,
       'type':'text',
       'time':timeStam.toString()
     }).then((value){
       messageController.clear();
     });
   }
 }
  
}