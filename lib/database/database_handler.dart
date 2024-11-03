


import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_notes_app/model/notes_model.dart';

class DatabaseHandler{


  //Create note

  static Future<void>createnote(Notemdel note)async{

    final noteCollection = FirebaseFirestore.instance.collection("notes");

    final id= noteCollection.doc().id;

    final newNote = Notemdel(


      id: id,
      title: note.title,
      body: note.body,
      color: note.color,
    ).toDocument();


    try{
      noteCollection.doc(id).set(newNote);

    }catch(e){

      print("some error occure $e");

    }


  }

  // read date from firebase

static Stream<List<Notemdel>>getnote(){
  final noteCollection = FirebaseFirestore.instance.collection("notes");
  return noteCollection.snapshots().map((querySnapshot)=> querySnapshot.docs.map((e) => Notemdel.fromSnapshot(e)).toList());
}

// update/edit notes

static Future<void>updatenote(Notemdel note)async{

  final noteCollection = FirebaseFirestore.instance.collection("notes");

  final newNote = Notemdel(


    id:note.id,
    title: note.title,
    body: note.body,
    color: note.color,
  ).toDocument();



  try{
    await  noteCollection.doc(note.id).update(newNote);
  }catch(e){
    print("Some occured error $e");
  }

}

// delete data from firebase


static Future<void>deletenote(String id)async{


  final noteCollection = FirebaseFirestore.instance.collection("notes");

  try{
    await noteCollection.doc(id).delete();
  }catch(e){
    print("Some occured error $e");

  }

}

}
