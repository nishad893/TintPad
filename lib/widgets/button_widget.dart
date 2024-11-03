

import 'package:color_notes_app/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const ButtonWidget({ Key? key, required this.icon,  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap ,
      child: Container(

        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: buttonBackgroundcolor,
          borderRadius: BorderRadius.circular(10)
        ),
        child:  Center(
          child: Icon(icon,color: whitecolor,),
        ),

      ),
    );
  }
}


class nameButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? ontap;
  final double Height;
  final double Width;
  const nameButtonWidget({ Key? key, required this.text,  this.ontap, required this.Height, required this.Width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:ontap ,
      child: Container(

        width: Width,
        height: Height,
        decoration: BoxDecoration(
            color: buttonBackgroundcolor,
            borderRadius: BorderRadius.circular(10)
        ),
        child:  Center(
          child: Text(text,style: TextStyle(color: Colors.white,fontSize: 20),),
        ),

      ),
    );
  }
}

