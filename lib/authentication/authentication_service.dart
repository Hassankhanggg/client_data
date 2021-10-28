import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

   Future<UserCredential> register(String email, String password) async {
    UserCredential userCredential;
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Do something with exception. This try/catch is here to make sure
      // that even if the user creation fails, app.delete() runs, if is not,
      // next time Firebase.initializeApp() will fail as the previous one was
      // not deleted.
    }

    await app.delete();
    return Future.sync(() => userCredential);
  }

  // Future<String> register(String email, String password) async {
  //   // ignore: deprecated_member_use
  //   FirebaseApp app = await FirebaseApp.configure(
  //       // ignore: deprecated_member_use
  //       name: 'Secondary',
  //       // ignore: deprecated_member_use
  //       options: await FirebaseApp.instance.options);
  //   // ignore: deprecated_member_use

  //           try {
  //                   // ignore: deprecated_member_use
  //     await     FirebaseAuth.fromApp(app)
  //       .createUserWithEmailAndPassword(email: email, password: password);
  //     return "Signed in";
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  //  Future<UserCredential> register1(String email, String password) async {
  //   UserCredential userCredential;
  //   FirebaseApp app = await Firebase.initializeApp(
  //       name: 'Secondary', options: Firebase.app().options);
  //   try {
  //     userCredential = await FirebaseAuth.instanceFor(app: app)
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     print("User creation failed");
  //   }

  //   await app.delete();
  //   return Future.sync(() => userCredential);
  // }
}
