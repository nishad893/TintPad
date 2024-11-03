
 import 'package:flutter/material.dart';

class Singlenote extends StatelessWidget {
  final String? title;
  final String? body;
  final int? color;
  final VoidCallback ? onTap;
  final VoidCallback ? onpressed;
  const Singlenote({super.key, this.title, this.body, this.color, this.onTap, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,

      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 25),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(color!),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [Text(title!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),),
                SizedBox(height: 5,),
                Text(body!,style: TextStyle(color: Colors.black,fontSize: 16),),
              ],

            ),
            IconButton(onPressed:onpressed , icon: Icon(Icons.delete,size:30,color: Colors.black,))
          ],


        ),
      ),
    );
  }
}
