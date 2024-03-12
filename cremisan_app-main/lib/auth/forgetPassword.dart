import 'package:cremisan_app1/auth/login.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class forgetPassword extends StatefulWidget {
  const forgetPassword({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<forgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void resetpassword(
    String email,
  ) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text)
          // .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(
                    msg: AppLocalizations.of(context)?.senttoemail ??
                        "value becomes null",
                    textColor: Colors.green),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage())),
              });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = AppLocalizations.of(context)
                  ?.youremailaddressappearstobemalformed ??
              "value becomes null";

          break;
        case "wrong-password":
          errorMessage =
              AppLocalizations.of(context)?.wrongpasswordprovidedforthatuser ??
                  "value becomes null";
          break;
        case "Email-not-found":
          errorMessage =
              AppLocalizations.of(context)?.userwiththisemaildoesntexist ??
                  "value becomes null";
          break;
        case "user-disabled":
          errorMessage =
              AppLocalizations.of(context)?.userwiththisemailhasbeendisabled ??
                  "value becomes null";
          break;
        case "too-many-requests":
          errorMessage = AppLocalizations.of(context)?.toomanyrequests ??
              "value becomes null";
          break;
        case "operation-not-allowed":
          errorMessage = AppLocalizations.of(context)
                  ?.signinginwithEmailandPasswordisnotenabled ??
              "value becomes null";
          break;
        default:
          errorMessage =
              AppLocalizations.of(context)?.anundefinedErrorhappened ??
                  "value becomes null";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
  }

  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      body: SingleChildScrollView(
          child: Container(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack(
          //  children: [
          //ClipPath(
          //  clipper: DrawClip(),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/logo22.png',
              width: 250,
              height: 250,
              //  fit:BoxFit.fill
            ),
            //   ),
            //  ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Text(
              AppLocalizations.of(context)?.passwordReset ??
                  "value becomes null",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
// //email
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                //  key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
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
                                    ?.pleaseenteravalidemail ??
                                "value becomes null";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // _name = value;
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.darkblueColor,
                        child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              resetpassword(_emailController.text);
                            },
                            child: Text(
                              AppLocalizations.of(context)?.send ??
                                  "value becomes null",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(height: 40),
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
                    ]),
              ))
        ],
      ))),
    ));
  }
}
