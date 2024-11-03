import 'package:color_notes_app/database/database_handler.dart';
import 'package:color_notes_app/model/notes_model.dart';
import 'package:color_notes_app/themes/colors.dart';
import 'package:color_notes_app/utils/utility.dart';
import 'package:color_notes_app/widgets/button_widget.dart';
import 'package:color_notes_app/widgets/form_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  int selectedcolor = 4294967295;
  TextEditingController _titlrcontrollar = TextEditingController();
  TextEditingController _bodycontrollar = TextEditingController();

  bool _isNoteCreating = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _titlrcontrollar.dispose();
    _bodycontrollar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: _isNoteCreating == true? lightgreycolor: darkbackgroundcolor,
      body: AbsorbPointer(
        absorbing: _isNoteCreating,
        child: Stack(alignment: Alignment.center, children: [
          _isNoteCreating == true
              ? Image.asset(
                  "assets/Iphone-spinner-2.gif",
                  width: 60,
                  height: 60,
                )
              : Container(),
          Padding(
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
                      ButtonWidget(
                        icon: Icons.done,
                        onTap: () {
                          _CreateNote();
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  textFormfeild(
                    controller: _titlrcontrollar,
                    hintText: "Title",
                    fontSize: 40,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  textFormfeild(
                    Maxlines: 15,
                    controller: _bodycontrollar,
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

  _CreateNote() {
    setState(() {
      _isNoteCreating = true;

      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        if (_titlrcontrollar.text.isEmpty) {
          Fluttertoast.showToast(msg: "Enter Title");
          setState(() {
            _isNoteCreating = false;
          });
          return;
        }
        if (_bodycontrollar.text.isEmpty) {
          Fluttertoast.showToast(msg: "Type something in body");
          setState(() {
            _isNoteCreating = false;
          });
          return;
        }
        DatabaseHandler.createnote(Notemdel(
                title: _titlrcontrollar.text,
                body: _bodycontrollar.text,
                color: selectedcolor))
            .then((value) {
          _isNoteCreating = false;
          Navigator.pop(context);
        });
      });
    });
  }
}
