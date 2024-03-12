import 'package:cremisan_app1/User/user_screens/DashboardScreen.dart';
import 'package:cremisan_app1/auth/varifyEmail.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'forgetPassword.dart';
import 'register.dart';
import 'package:cremisan_app1/Admin/admin_screens/DashboardAdmin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 240,
                width: 300,
                child: Image.asset(
                  "assets/logo22.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(12),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText:
                              AppLocalizations.of(context)?.enteryourEmail ??
                                  "value becomes null",
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)
                                    ?.emailcannotbeempty ??
                                "value becomes null";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return AppLocalizations.of(context)
                                    ?.pleaseenteravalidemail ??
                                "value becomes null";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure3,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure3
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure3 = !_isObscure3;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText:
                              AppLocalizations.of(context)?.enteryourPassword ??
                                  "value becomes null",
                          prefixIcon: const Icon(Icons.vpn_key),
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          enabled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)
                                    ?.passwordcannotbeempty ??
                                "value becomes null";
                          }
                          if (value.length < 6) {
                            return AppLocalizations.of(context)
                                    ?.pleaseenteravalidpassword ??
                                "value becomes null";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.darkblueColor,
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Text(
                            AppLocalizations.of(context)?.login ??
                                "value becomes null",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const forgetPassword(),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)?.forgetPassword ??
                                  "value becomes null",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)?.donthaveanaccount ??
                                "value becomes null",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)?.signUp ??
                                  "value becomes null",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardAdmin(0),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
        }
      } else {
        print('Document does not exist in the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Check if the user's email is verified
        User? user = userCredential.user;
        if (user != null && user.emailVerified) {
          // If email is verified, proceed to the dashboard
          route();
        } else {
          // If email is not verified, show a message to the user
          final errorMessage = AppLocalizations.of(context)
                  ?.pleaseverifyyouremailbeforeloggingin ??
              "value becomes null";

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              duration: Duration(seconds: 3),
              action: SnackBarAction(
                label: AppLocalizations.of(context)?.verifyEmail ??
                    "value becomes null",
                onPressed: () {
                  // Navigate to the verification page when the action is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmailVerificationPage(),
                    ),
                  );
                  user?.sendEmailVerification();
                },
              ),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage =
            AppLocalizations.of(context)?.anerroroccurredwhileloggingin ??
                "value becomes null";

        if (e.code == 'user-not-found') {
          errorMessage =
              AppLocalizations.of(context)?.nouserfoundforthatemail ??
                  "value becomes null";
        } else if (e.code == 'wrong-password') {
          errorMessage =
              AppLocalizations.of(context)?.wrongpasswordprovidedforthatuser ??
                  "value becomes null";
        } else {
          errorMessage = e.message ?? errorMessage;
        }

        // Show a SnackBar with the error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
