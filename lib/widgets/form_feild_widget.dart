

import 'package:flutter/material.dart';

class textFormfeild extends StatelessWidget {
  final double ? fontSize;
  final int? Maxlines;
  final TextEditingController controller;
  final String hintText;
  const textFormfeild({super.key, this.fontSize,  this.Maxlines, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: Maxlines,
      style: TextStyle(fontSize: fontSize,color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white
        ),
        border: InputBorder.none
      ),


    );
  }
}
