

import 'package:cloud_firestore/cloud_firestore.dart';

class Notemdel{
  final String? id;
  final String? title;
  final String? body;
  final int? color;

  Notemdel({this.id, this.title, this.body, this.color});

  //  to convert this in to document for cloud firestore


factory Notemdel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>>snapshot){

  return Notemdel(
    title: snapshot["title"],
    id: snapshot["id"],
    body: snapshot["body"],
    color: snapshot["color"],
  );
}

Map<String,dynamic> toDocument() => {
  "title" : title,
  "id" : id,
  "body" : body,
  "color" : color,
};


}