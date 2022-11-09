import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
  final bool loading;
  const RoundButton(
      {Key? key,
      required this.title,
      required this.onPress,
       this.color = AppColors.primaryColor,
       this.textColor = AppColors.whiteColor,
       this.loading = false
       })
      : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Material(
      color: color, 
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: loading ? null :onPress,
        
        child: Container(
          height: 50,
          width: double.infinity,
              child: loading ? Center(child: CircularProgressIndicator(color:Colors.white ,)):Center(
              child: Text(title,
                  style: Theme.of(context).textTheme .headline2!.copyWith(fontSize: 16,color: textColor))),
        ),
      ),
    );
  }
}
