import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({this.uid, this.id, this.author, this.dateCreation, this.dateLastEdit, this.text});
  final String uid;
  final String id;
  final String author;
  final DateTime dateCreation;
  final DateTime dateLastEdit;
  final String text;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
