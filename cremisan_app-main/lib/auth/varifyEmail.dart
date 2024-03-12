import 'package:cremisan_app1/User/user_screens/DashboardScreen.dart';
import 'package:cremisan_app1/auth/login.dart';
import 'package:cremisan_app1/main.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import '../User/user_widgets/onboarding_page.dart';

enum Status { LOADING, NULL, VERIFIED, NOT_VERIFIED }

class UserVerificationStatus {
  final Status status;

  UserVerificationStatus({required this.status});
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class EmailVerificationPage extends StatefulWidget {
  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

bool isloading = false;

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserVerificationStatus> checkUserVerified() async* {
    bool verified = false;
    yield UserVerificationStatus(status: Status.LOADING);
    while (!verified) {
      await Future.delayed(Duration(seconds: 5));
      User? user = _auth.currentUser;
      if (user != null) await user.reload();
      if (user == null) {
        yield UserVerificationStatus(status: Status.NULL);
      } else {
        print("isemailverified ${user.emailVerified}");
        await user.reload();
        verified = user.emailVerified;
        if (verified) {
          yield UserVerificationStatus(status: Status.VERIFIED);
        } else {
          yield UserVerificationStatus(status: Status.NOT_VERIFIED);
        }
      }
    }
  }

  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 150,
              width: 200,
              child: Image.asset(
                "assets/email.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
              child: Text(
            AppLocalizations.of(context)?.verifyyourEmailAddress ??
                "value becomes null",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
          SizedBox(
            height: 40,
          ),
          Center(
              child: Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context)?.verifyEmailDescription ??
                "value becomes null",
            style: TextStyle(
              fontSize: 18,
            ),
          )),
          SizedBox(
            height: 40,
          ),
          StreamBuilder<UserVerificationStatus>(
            stream: checkUserVerified(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final status = snapshot.data!.status;
                switch (status) {
                  case Status.LOADING:
                    return CircularProgressIndicator();
                  case Status.NULL:
                    return Text(AppLocalizations.of(context)
                            ?.nouseriscurrentlyloggedin ??
                        "value becomes null");
                  case Status.VERIFIED:
                    //return Text('No user is currently logged in.');

                    push(context);

                    return CircularProgressIndicator();
                  //   MaterialApp(
                  //home: push(context),

                  case Status.NOT_VERIFIED:
                    return Text(AppLocalizations.of(context)
                            ?.emailisnotverifiedPleasecheckyouremail ??
                        "value becomes null");
                }
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: AppColors.darkblueColor),
            onPressed: () {
              _sendEmailVerification(context);
            },
            child: Text(
              AppLocalizations.of(context)?.resendVerificationEmail ??
                  "value becomes null",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward, // Replace with the desired icon
                  color: AppColors.darkblueColor,
                ),
                SizedBox(
                    width: 8), // Adjust the spacing between the icon and text
                Text(
                  AppLocalizations.of(context)?.backtoLogin ??
                      "value becomes null",
                  style: TextStyle(
                    color: AppColors.darkblueColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  // Your push method remains the same
  push(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingPage(),
      ),
    );
  }
}

void _sendEmailVerification(BuildContext context) async {
  final user = _auth.currentUser;
  await user?.sendEmailVerification();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
          AppLocalizations.of(context)?.verificationemailsentCheckyourinbox ??
              "value becomes null"),
    ),
  );
}
