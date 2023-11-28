import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IconBackgroundTextfield extends StatelessWidget {
  final String hintText;
  final String icons;
  final double borderRadius;
  final double height;
  final bool readOnly;
  Color? bgColor=Color(0xFFE7EBF6);
  Color? borderColor=Color(0xFFE7EBF6);
  final bool isNumber;
  final bool isValueChnged;
  final bool isemail;
  final bool iconsLats;
  final Function(String)? tap;
  TextEditingController? controller;
  IconBackgroundTextfield({required this.controller,
  required this.hintText,required this.readOnly,
  required this.isNumber,this.bgColor,this.borderColor, this.tap,  this.isValueChnged=false,  this.isemail=false,  required this.icons,  this.iconsLats=false,  this.borderRadius=40.0,  this.height=16});

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          if(isNumber){
            return "Enter a valid mobile number";
          }else if(isemail){
            return "Enter a valid email address";
          }else{
            return "Fill the field";
          }
        }else{
          String pattern =
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
              r"{0,253}[a-zA-Z0-9])?)*$";
          RegExp regex = RegExp(pattern);

          if(isNumber){
            return value.length < 11 ?'invalid number':null;
          }
          else if(isemail){
           return !regex.hasMatch(value)?'invalid email':null;
          } else{
            return null;
          }
        }
      },
      keyboardType: isNumber?TextInputType.number:TextInputType.text,
      inputFormatters:isNumber? [
        LengthLimitingTextInputFormatter(11),
      ]:[],
      readOnly: readOnly,
      controller: controller,

      onChanged: isValueChnged?tap:null,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFFCBD5E0),fontSize: 12),
        suffixIcon:iconsLats? Padding(
          padding: EdgeInsets.all(10.0),
          child: SvgPicture.asset(icons,color: Color(0xFFA0ACC3),), // icon is 48px widget.
        ):null,
        prefixIcon:!iconsLats?  Padding(
          padding: EdgeInsets.all(10.0),
          child: SvgPicture.asset(icons,color: Color(0xFFA0ACC3),), // icon is 48px widget.
        ):null,
        fillColor: bgColor,
        filled: true,
        isDense: true,
        contentPadding:
        EdgeInsets.symmetric(vertical: height, horizontal: height),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color:borderColor!, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color:borderColor!, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
    );
  }
}
