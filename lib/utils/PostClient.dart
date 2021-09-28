import 'package:client_data/utils/model.dart';
import 'package:client_data/utils/modelclient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class PostDataClient {
  static final PostDataClient _instance = new PostDataClient.internal();
  factory PostDataClient() => _instance;
  PostDataClient.internal();

  Future<dynamic> post(DonaloPostClient post) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
    String _key = getRandomString(26);
    final DonaloPostClient = DonaloPost(
      postID: _key,
      userID: _auth.currentUser.uid,
      cusName: post.cusName,
      ports: post.ports,
      dest: post.dest,
      offeredRate: post.offeredRate,
    );
    try {
      return await _firestore
          .collection('clients')
          .doc(_key)
          .set(DonaloPostClient.toMap());
    } on FirebaseException catch (e) {
      print('Firebase Error ' + e.toString());
    } catch (e) {
      print('Error ' + e.toString());
    }
  }

  Stream<List<DonaloPostClient>> getPosts(
      {bool flag = false, String filter, dynamic key}) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    if (!flag)
      return _firestore.collection('clients').snapshots().map((event) =>
          event.docs.map((e) => DonaloPostClient.fromMap(e.data())).toList());
    else
      return _firestore
          .collection('posts')
          .where(filter, isEqualTo: key)
          .snapshots()
          .map((event) => event.docs
              .map((e) => DonaloPostClient.fromMap(e.data()))
              .toList());
  }

  Future<void> deletePost(DonaloPostClient post) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection("clients").doc(post.postID).delete();
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
