import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cremisan_app1/Admin/admin_screens/DashboardAdmin.dart';
import 'package:cremisan_app1/User/user_screens/DashboardScreen.dart';
import 'package:cremisan_app1/auth/login.dart';
import 'package:cremisan_app1/auth/register.dart';
import 'package:cremisan_app1/auth/varifyEmail.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'l10n/l10n.dart';
import 'provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return GetMaterialApp(
          builder: (context, child) {
            return Directionality(
              textDirection: provider.locale == Locale('ar')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue[900],
          ),
          supportedLocales: L10n.all,
          locale: provider.locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: const MyAppHome(),
        );
      },
    );
  }
}

class MyAppHome extends StatefulWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    checkIfLogin();
  }

  Future<void> checkIfLogin() async {
    _auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      // Check the authentication state changes
      future: _auth.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Get user data from the snapshot
          final user = snapshot.data;

          // Check if the user is logged in
          return isLogin
              ? (user != null && user.emailVerified
                  ? FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      // Fetch additional user data from Firestore
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .get(),
                      builder: (context, roleSnapshot) {
                        if (roleSnapshot.connectionState ==
                            ConnectionState.done) {
                          // Extract user role from Firestore data
                          final userRole =
                              roleSnapshot.data?.data()?['role'] as String?;

                          // Navigate based on user role
                          return userRole == 'Admin'
                              ? DashboardAdmin(0) // Show admin dashboard
                              : DashboardScreen(); // Show regular user dashboard
                        } else {
                          // Show a loading indicator while fetching role data
                          return Container(
                              color: Colors.white,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Hero(
                                      tag: 'logo',
                                      child: Image.asset(
                                        'assets/logo44.png',
                                        height: 250,
                                        width: 300,
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    CircularProgressIndicator()
                                  ]));
                        }
                      },
                    )
                  : EmailVerificationPage()) // Show email verification page if user not verified
              : LoginPage(); // Show login page if not logged in
        } else {
          // Show a loading indicator while checking authentication state
          return Container(
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/logo44.png',
                        height: 250,
                        width: 300,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    CircularProgressIndicator(
                      color: AppColors.uniformColor,
                    )
                  ]));
          ;
        }
      },
    );
  }
}
