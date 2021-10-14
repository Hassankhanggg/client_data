import 'package:client_data/screens/users/UserScreen.dart';
import 'package:client_data/authentication/authentication_service.dart';
import 'package:client_data/authentication/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        home: AuthenticationWrapper(),
        theme: new ThemeData(scaffoldBackgroundColor: Colors.cyan),
        // darkTheme: ThemeData(
        //   brightness: Brightness.light,
        //   /* dark theme settings */
        // ),
        // themeMode: ThemeMode.dark,
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return UserScreen();
    }
    return Signin();
  }
}
