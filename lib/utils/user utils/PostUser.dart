import 'package:client_data/utils/user%20utils/model%20user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class PostDataUser {
  static final PostDataUser _instance = new PostDataUser.internal();
  factory PostDataUser() => _instance;
  PostDataUser.internal();

  Future<dynamic> post(DonaloPostUser post) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String _key = getRandomString(26);
    final DonaloPostUser user = DonaloPostUser(
      postID: _key,
      // userID: _auth.currentUser.uid,
      Name: post.Name,
      userID: post.userID,
      // ports: post.ports,
      email: post.email,
      // offeredRate: post.offeredRate,
    );
    try {
      return await _firestore.collection('Users').doc(_key).set(user.toMap());
    } on FirebaseException catch (e) {
      print('Firebase Error ' + e.toString());
    } catch (e) {
      print('Error ' + e.toString());
    }
  }

  Stream<List<DonaloPostUser>> getPosts(
      {bool flag = false, String filter, dynamic key}) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    if (!flag)
      return _firestore.collection('Users').snapshots().map((event) =>
          event.docs.map((e) => DonaloPostUser.fromMap(e.data())).toList());
    else
      return _firestore
          .collection('Users')
          .where(filter, isEqualTo: key)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => DonaloPostUser.fromMap(e.data())).toList());
  }

  Future<void> deletePost(DonaloPostUser post) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection("Users").doc(post.postID).delete();
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
