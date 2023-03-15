import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //---------------------------------------------------------------------------------------------------------------------------
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  bool isLoginPage = false;
  //---------------------------------------------------------------------------------------------------------------------------

  startauthentication() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validity) {
      _formkey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      if (isLoginPage) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid = authResult.user!.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .set({'username': username, 'email': email});
      }
    } catch (err) {
      return (err);
    }
  }

//---------------------------------------------------------------------------------------------------------------------------
  signInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // User cancelled the sign-in flow
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

//----------------------------------------------------------------------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff001222),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 10, left: 10, top: 30),
            child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isLoginPage)
                      TextFormField(
                        style: const TextStyle(color: Color(0xff16deff)),
                        keyboardType: TextInputType.emailAddress,
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value == null) {
                            return 'Incorrect Username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                        decoration: InputDecoration(
                          label: const Text(
                            'Username',
                          ),
                          labelStyle: const TextStyle(
                            color: Color(0xff04F6C1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xff04F6C1),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xff16deff),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Color(0xff16deff)),
                      keyboardType: TextInputType.emailAddress,
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          'Email',
                        ),
                        labelStyle: const TextStyle(
                          color: Color(0xff04F6C1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xff04F6C1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xff16deff),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Color(0xff16deff)),
                      keyboardType: TextInputType.emailAddress,
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value == null) {
                          return 'Incorrect Password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: InputDecoration(
                        label: const Text(
                          'Password',
                        ),
                        labelStyle: const TextStyle(
                          color: Color(0xff04F6C1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xff04F6C1),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xff16deff),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        startauthentication();
                      },
                      backgroundColor: const Color.fromARGB(255, 3, 159, 125),
                      child: const Icon(Icons.done_rounded),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLoginPage = !isLoginPage;
                        });
                      },
                      child: isLoginPage
                          ? const Text(
                              'Not a Member',
                              style: TextStyle(color: Color(0xff16deff)),
                            )
                          : const Text(
                              'Already a Member ?',
                              style: TextStyle(color: Color(0xff16deff)),
                            ),
                    ),
                    if (!isLoginPage)
                      FloatingActionButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: Image.asset(
                          'assets/log.png',
                          fit: BoxFit.cover,
                        ),
                        backgroundColor: Colors.white,
                      )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
