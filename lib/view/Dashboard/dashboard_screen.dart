import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/Dashboard/profile/profile.dart';
import 'package:tech_media/view/Dashboard/user/user_list_Screen.dart';
import 'package:tech_media/view_model/services/session_manager.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final controller = PersistentTabController(initialIndex: 0);
  

  List<Widget>_buildScreen(){
    return [
       Text("Home"),
       Text("Chat"),
       Text("add"),
       UserListScreen(),
       ProfileScreen()
    ];

  }

  List<PersistentBottomNavBarItem> _navBarItem(){
    return [
      PersistentBottomNavBarItem(icon: 
       Icon(Icons.home),
       activeColorPrimary: AppColors.primaryIconColor,
       inactiveIcon: Icon(Icons.home_outlined,color: Colors.grey.shade100,)
       
       ),
      PersistentBottomNavBarItem(icon: 
       Icon(Icons.message),
       activeColorPrimary: AppColors.primaryIconColor,
       inactiveIcon: Icon(Icons.message,color: Colors.grey.shade100,)
       
       ),
      PersistentBottomNavBarItem(icon: 
       Icon(Icons.add),
       activeColorPrimary: AppColors.primaryIconColor,
       inactiveIcon: Icon(Icons.add,color: Colors.grey.shade100,)
       ),
      PersistentBottomNavBarItem(icon: 
       Icon(Icons.add),
         activeColorPrimary: AppColors.primaryIconColor,
       inactiveIcon: Icon(Icons.message,color: Colors.grey.shade100,)
       ),
      PersistentBottomNavBarItem(icon: 
       Icon(Icons.person),
         activeColorPrimary: AppColors.primaryIconColor,
       inactiveIcon: Icon(Icons.person_outline,color: Colors.grey.shade100,)
       )
    ];
  }
  
  
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      controller: controller,
      backgroundColor: AppColors.otpHintColor,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.red,
        borderRadius: BorderRadius.circular(1)
      ),
      navBarStyle:NavBarStyle.style15 ,
    );
  }
}







// ? <-- This Question Use Symbol  Color blue
// ! <-- This Nahin Karna hai ke liya Use Symbol  Color red
// * <-- This yah kam jaruri or important hai ke liya Use Symbol  Color red
// TODO <-- This Kuchh Create karna hai ke liya Use Symbol  Color Orange
