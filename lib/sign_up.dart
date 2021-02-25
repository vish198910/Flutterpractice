import 'package:auth_store/login.dart';
import 'package:auth_store/store_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      title: TextFormField(
                        cursorColor: Colors.purpleAccent,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter an Email";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "please enter an valid email";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Enter your Email",
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.purpleAccent)),
                        controller: emailController,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(6),
                    child: ListTile(
                      title: TextFormField(
                        cursorColor: Colors.purpleAccent,
                        controller: passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please type a password";
                          }
                          if (value.length < 6) {
                            return "Password length must be 6 or more";
                          } else {
                            return null;
                          }
                        },
                        obscureText: passwordVisible ? false : true,
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.purpleAccent),
                        ),
                      ),
                      trailing: GestureDetector(
                        child: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onTap: () {
                          setState(() {
                            if (passwordVisible) {
                              passwordVisible = false;
                            } else {
                              passwordVisible = true;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(6),
                    child: ListTile(
                      title: TextFormField(
                        obscureText: confirmPasswordVisible ? false : true,
                        cursorColor: Colors.purpleAccent,
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please type a password";
                          }
                          if (value.length < 6) {
                            return "Password length must be 6 or more";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: Colors.purpleAccent),
                        ),
                      ),
                      trailing: GestureDetector(
                        child: Icon(confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onTap: () {
                          setState(() {
                            if (confirmPasswordVisible) {
                              confirmPasswordVisible = false;
                            } else {
                              confirmPasswordVisible = true;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          try {
                            if (passwordController.value.text ==
                                confirmPasswordController.value.text) {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: emailController.value.text,
                                      password: passwordController.value.text);
                              print(userCredential.toString());
                            } else {}
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                         Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return StoreImage();
                        }));
                      },
                      elevation: 5.0,
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 18, 40, 18),
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a user?  ",
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          child: Text(
                            "Login Here",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
