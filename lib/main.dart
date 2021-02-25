import 'package:auth_store/auth_and_store.dart';
import 'package:auth_store/login.dart';
import 'package:auth_store/usermngmt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: AuthAndStore(),
    debugShowCheckedModeBanner: false,
  ));
}

class AuthAndStore extends StatefulWidget {
  _AuthAndStoreState createState() => _AuthAndStoreState();
}

class _AuthAndStoreState extends State<AuthAndStore> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Scaffold(
        body: Container(
          child: Text("$_error"),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Scaffold(
        body: Container(
          child: Text("Loading.........."),
        ),
      );
    }

    return UserManagement().handleAuth();
  }
}
