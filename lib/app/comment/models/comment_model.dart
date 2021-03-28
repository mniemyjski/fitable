import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String uid;
  final String id;
  final String author;
  final DateTime dateCreation;
  final DateTime dateLastEdit;
  final String text;

  Comment({this.uid, this.id, this.author, this.dateCreation, this.dateLastEdit, this.text});

  // factory Comment.fromFirestore(DocumentSnapshot document) {
  //   Map data = document.data;
  //
  //   return Comment(
  //     uid: data['uid'],
  //     id: document.documentID,
  //     author: data['author'],
  //     dateCreation: data['dateCreation'].toDate(),
  //     dateLastEdit: data['dateLastEdit'].toDate(),
  //     text: data['text'],
  //   );
  // }
}
