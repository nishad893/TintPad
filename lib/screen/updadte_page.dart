import 'package:color_notes_app/model/notes_model.dart';
import 'package:color_notes_app/themes/colors.dart';
import 'package:color_notes_app/utils/utility.dart';
import 'package:color_notes_app/widgets/button_widget.dart';
import 'package:color_notes_app/widgets/form_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database/database_handler.dart';
import '../widgets/showdialog_widget.dart';

class updadtepage extends StatefulWidget {
  final Notemdel notemdel;
  const updadtepage({super.key, required this.notemdel});

  @override
  State<updadtepage> createState() => _updadtepageState();
}

class _updadtepageState extends State<updadtepage> {
 bool   _isNoteEditing = false;
  TextEditingController? _titlrcontrollar ;
  TextEditingController? _bodycontrollar ;
  int selectedcolor = 4294967295;
  @override
  void initState() {
    // TODO: implement initState

    _titlrcontrollar =TextEditingController(text: widget.notemdel.title);
    _bodycontrollar = TextEditingController(text: widget.notemdel.body);
     selectedcolor = widget.notemdel.color!;

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titlrcontrollar!.dispose();
    _bodycontrollar!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:_isNoteEditing == true? lightgreycolor: darkbackgroundcolor,
      body: AbsorbPointer(
        absorbing: _isNoteEditing,
        child: Stack(alignment: Alignment.center,
          children:[
            _isNoteEditing == true
                ? Image.asset(
              "assets/Iphone-spinner-2.gif",
              width: 60,
              height: 60,
            )
                : Container(),Padding(
            padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                      ),
                      nameButtonWidget(text: "Save", Height: 40, Width: 60,
                      ontap: (){
                        showdialogboxwidget(context,

                            Hight: 200,
                            title: "Save Changes",
                            ontapYes: (){
                             _Editnote();
                            }
                        );
                      },)
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  textFormfeild(
                    controller: _titlrcontrollar!,
                    hintText: "Title",
                    fontSize: 40,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  textFormfeild(
                    Maxlines: 15,
                    controller: _bodycontrollar!,
                    hintText: "Start typing",
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: PredefinedColors.length,
                        itemBuilder: (context, index) {
                          final Singlecolor = PredefinedColors[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedcolor = Singlecolor.value;
                              });
                            },
                            child: Container(
                              height: 60,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Singlecolor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3,
                                      color: selectedcolor == Singlecolor.value
                                          ? Colors.white
                                          : Colors.transparent)),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
  _Editnote() {
    setState(() {
      _isNoteEditing = true;

      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        if (_titlrcontrollar!.text.isEmpty) {
          Fluttertoast.showToast(msg: "Enter Title");
          setState(() {
            _isNoteEditing = false;
          });
          return;
        }
        if (_bodycontrollar!.text.isEmpty) {
          Fluttertoast.showToast(msg: "Type something in body");
          setState(() {
            _isNoteEditing = false;
          });
          return;
        }
        DatabaseHandler.updatenote(Notemdel(
          id: widget.notemdel.id,
            title: _titlrcontrollar!.text,
            body: _bodycontrollar!.text,
            color: selectedcolor))
            .then((value) {
          _isNoteEditing = false;
          Navigator.pop(context);
        });
      });
    });
  }
}
