import 'package:color_notes_app/themes/colors.dart';
import 'package:flutter/material.dart';

showdialogboxwidget(BuildContext context,
    {String? title, VoidCallback? ontapYes, double? Hight}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: darkgreycolor,
          child: Container(
            width: double.infinity,
            height: Hight,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                Icon(
                  Icons.info,
                  color: lightgreycolor,
                  size: 40,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "No",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: ontapYes,
                      child: Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Text(
                          "yes",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
