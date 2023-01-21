import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFitedSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyBoradType;
  final String hint;
  final bool obsureText;
  final bool enable, outoFocus;

  const InputTextField(
      {super.key,
      required this.myController,
      required this.focusNode,
      required this.onFitedSubmittedValue,
      required this.onValidator,
      required this.keyBoradType,
      required this.hint,
      required this.obsureText,
       this.enable = true,
       this.outoFocus = false
       });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: TextFormField(
        obscureText: obsureText,
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFitedSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoradType ,
        cursorColor: AppColors.primaryTextTextColor,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0 ,fontSize: 19),
        decoration: InputDecoration(
          hintText: hint,
          enabled: enable,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(height: 0 ,color: AppColors.primaryTextTextColor.withOpacity(0.8)),
          
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldDefaultFocus),
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),

          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),

          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.alertColor),
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
            borderRadius: BorderRadius.all(Radius.circular(8))
          )
        ),
      ),
    );
  }
}
