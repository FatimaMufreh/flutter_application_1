import 'package:cremisan_app1/auth/varifyEmail.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showProgress = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phonenumberControler = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;
  var role = "User";
  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                            height: 160,
                            width: 200,
                            child: Image.asset(
                              "assets/logo66.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)?.registerNow ??
                              "value becomes null",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[400],
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: AppLocalizations.of(context)?.username ??
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
                                      ?.usernamecannotbeempty ??
                                  "value becomes null";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: AppLocalizations.of(context)?.email ??
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
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return AppLocalizations.of(context)
                                      ?.pleaseenteravalidemail ??
                                  "value becomes null";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password_outlined),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: AppLocalizations.of(context)?.password ??
                                "value becomes null",
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            enabled: true,
                          ),
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)
                                      ?.passwordcannotbeempty ??
                                  "value becomes null";
                            }
                            if (!regex.hasMatch(value)) {
                              return AppLocalizations.of(context)
                                      ?.pleaseenteravalidpassword ??
                                  "value becomes null";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmPassController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password_sharp),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText:
                                AppLocalizations.of(context)?.confirmPassword ??
                                    "value becomes null",
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            enabled: true,
                          ),
                          validator: (value) {
                            if (confirmPassController.text !=
                                passwordController.text) {
                              return AppLocalizations.of(context)
                                      ?.passwordsdonotmatch ??
                                  "value becomes null";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_city),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: AppLocalizations.of(context)?.location ??
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
                                      ?.locationcannotbeempty ??
                                  "value becomes null";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phonenumberControler,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText:
                                AppLocalizations.of(context)?.phoneNumber ??
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
                                      ?.phonenumbercannotbeempty ??
                                  "value becomes null";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: birthdateController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.date_range_outlined),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: AppLocalizations.of(context)?.birthday ??
                                "value becomes null",
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (selectedDate != null) {
                                  final formattedDate =
                                      "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                                  birthdateController.text = formattedDate;
                                }
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)
                                      ?.birthdaydatecannotbeempty ??
                                  "value becomes null";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.darkblueColor,
                          child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              setState(() {
                                showProgress = true;
                              });
                              signUp(
                                emailController.text,
                                passwordController.text,
                                role,
                                usernameController.text,
                                cityController.text,
                                phonenumberControler.text,
                                birthdateController.text,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)?.register ??
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
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.navigate_before),
                                Text(
                                  AppLocalizations.of(context)?.back ??
                                      "value becomes null",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password, String role, String username,
      String city, String phoneNumber, String birthday) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        postDetailsToFirestore(
            email, role, username, city, phoneNumber, birthday);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          final errorMessage =
              AppLocalizations.of(context)?.emailalreadyinuse ??
                  "value becomes null";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              duration: Duration(seconds: 3),
            ),
          );

          // Check if the email is not verified
        }
        final user = _auth.currentUser;
        if (user != null && !user.emailVerified) {
          // If not verified, navigate to the verification page
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
        } else {
          print("Registration error: $e");
        }
      }
    }

    // Send email verification after user creation
    final user = _auth.currentUser;
    await user?.sendEmailVerification();
  }

  void postDetailsToFirestore(String email, String role, String username,
      String city, String phoneNumber, String birthday) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'email': emailController.text,
      'role': "user",
      'username': username,
      'city': city,
      'phoneNumber': phoneNumber,
      'birhday': birthday,
      'uid': user.uid,
    });
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => EmailVerificationPage()));
  }
}
