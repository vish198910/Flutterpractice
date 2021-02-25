import 'package:auth_store/store_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyAwesomeAuthAndStore extends StatefulWidget {
  @override
  _MyAwesomeAuthAndStoreState createState() => _MyAwesomeAuthAndStoreState();
}

class _MyAwesomeAuthAndStoreState extends State<MyAwesomeAuthAndStore> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signout() async {
    await auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("Sign-in"),
                onPressed: () {
                  print(signInWithGoogle());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return StoreImage();
                  }));
                },
              ),
              RaisedButton(
                child: Text("Sign-out"),
                onPressed: () {
                  print(signout());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
