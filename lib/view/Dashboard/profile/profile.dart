

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final ref = FirebaseDatabase.instance.ref('User');

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(context) => ProfileController(),
    child: Consumer<ProfileController>(builder: (context, provider, child) {
       return Scaffold(
        resizeToAvoidBottomInset: false,
      body: SafeArea(
        
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: StreamBuilder(
              stream: ref.child(SessionController().userid.toString()).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                     Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 10),
                           child: Center(
                        child: Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.secondaryTextColor,
                                      width: 3)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child:provider.image == null? map["profile"] == ""
                                      ? Icon(
                                          Icons.person,
                                          size: 36,
                                        )
                                      : Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(map['profile']),
                                          loadingBuilder:
                                              (context, child, loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              child: Icon(
                                                Icons.error_outline,
                                                color: AppColors.alertColor,
                                              ),
                                            );
                                          },
                                        ):Stack(
                                          children: [
                                            Image.file(
                                          File(provider.image!.path).absolute
                                           ),
                                           Center(child: CircularProgressIndicator())
                                          ],
                                        )
                                        )
                                        ),
                      ),
                         ),
                      InkWell(
                        onTap: (){
                          provider.pickImage(context);
                        },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.primaryIconColor,
                        child: Icon(Icons.add,size: 18,color: Colors.white),
                        ),
                      )
                     
                      ],
                     ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: (){
                          provider.showUserNameDialogAlert(context, map['userName']);
                        },
                        child: ReusbaleRow(
                            title: "UserName",
                            value: map['userName'],
                            iconData: Icons.person),
                      ),
                      GestureDetector(
                        onTap: (){
                          provider.showPhoneDialogAlert(context, map['phone']);
                        },
                        child: ReusbaleRow(
                            title: "Phone",
                            value:
                                map['phone'] == "" ? "xxx-xxx-xxx" : map['phone'],
                            iconData: Icons.phone_outlined),
                      ),
                      ReusbaleRow(
                          title: "Email",
                          value: map['email'],
                          iconData: Icons.email),

                          RoundButton(
                            title: "Logout", onPress: (){
                                 final auth = FirebaseAuth.instance;
                                 auth.signOut().then((value){
                                     SessionController().userid = '';
                                     Navigator.pushNamed(context, RouteName.loginView);
                                 });
                                
                            })
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      "Something went wrong..",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                }
              },
            )),
      ),
    );
    },),
    );
  }
}

class ReusbaleRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;

  const ReusbaleRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          trailing: Text(value, style: Theme.of(context).textTheme.subtitle2),
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.4),
        )
      ],
    );
  }
}
