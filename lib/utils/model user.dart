import 'package:cloud_firestore/cloud_firestore.dart';

class DonaloPostUser {
  final String userID;
  final String Name;
  final String email;
  final String postID;

  DonaloPostUser({this.userID, this.Name, this.email,this.postID});
  DonaloPostUser.fromMap(Map<String, dynamic> map)
      : this(userID: map['userID'], Name: map['Name'],postID: map['postID'],email: map['email']);

  Map<String, dynamic> toMap() => {
        'cusName': Name,
        'userID': userID,
        'email': email,
        'postID': postID,
      };
}
