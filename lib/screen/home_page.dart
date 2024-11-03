import 'package:color_notes_app/database/database_handler.dart';
import 'package:color_notes_app/model/notes_model.dart';
import 'package:color_notes_app/screen/create_note_page.dart';
import 'package:color_notes_app/screen/updadte_page.dart';
import 'package:color_notes_app/themes/colors.dart';
import 'package:color_notes_app/widgets/button_widget.dart';
import 'package:color_notes_app/widgets/showdialog_widget.dart';
import 'package:color_notes_app/widgets/singlenote_widget.dart';
import 'package:flutter/material.dart';

class tintpadhome extends StatefulWidget {
  const tintpadhome({super.key});

  @override
  State<tintpadhome> createState() => _tintpadhomeState();
}

class _tintpadhomeState extends State<tintpadhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkbackgroundcolor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: darkbackgroundcolor,
          title: Text(
            "Notes",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          actions: [
            ButtonWidget(icon: Icons.search),
            SizedBox(
              width: 10,
            ),
            ButtonWidget(icon: Icons.info),
            SizedBox(
              width: 10,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateNotePage()));
          },
          backgroundColor: Colors.black45,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder<List<Notemdel>>(
            stream: DatabaseHandler.getnote(), //get data from fire base
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Image.asset(
                    "assets/Iphone-spinner-2.gif",
                    width: 60,
                    height: 60,
                  ),
                );
              }if(snapshot.hasData == false){
                return Center(
                  child: _noNotesWidget()
                );
              }if(snapshot.data!.isEmpty){
                return _noNotesWidget();
              }if(snapshot.hasData){
                final notes = snapshot.data;
                return ListView.builder(
                    itemCount: notes!.length,
                    itemBuilder: (context, index) {
                      return Singlenote(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => updadtepage(notemdel: notes[index],)));
                        },
                        onpressed: () {
                          showdialogboxwidget(context,
                              Hight: 250,
                              title:
                              "Are you sure you want \nto delete this note?",
                              ontapYes: () {
                            DatabaseHandler.deletenote(notes[index].id!);
                            Navigator.pop(context);

                              });
                        },
                        title: notes[index].title,
                        body: notes[index].body,
                        color: notes[index].color,
                      );
                    });
              }
              return Center(
                child: Image.asset(
                  "assets/Iphone-spinner-2.gif",
                  width: 60,
                  height: 60,
                ),
              );
            }));
  }

  _noNotesWidget(){
    return Center(
      child:
      Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            height: 250,
            width: 250,
            child:Image.asset("assets/6727288fd62618000966aeeb.png",fit:BoxFit.fill,) ,
          ),
          SizedBox(height: 15,),

          Text("Create Colorful Notes",style: TextStyle(
            fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white
          ),textAlign: TextAlign.center,)

        ],
      ),
    );
  }

}
