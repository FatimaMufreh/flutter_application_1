import 'package:cremisan_app1/User/user_screens/AboutUs.dart';
import 'package:cremisan_app1/User/user_screens/ContactUs.dart';
import 'package:cremisan_app1/User/user_screens/DashboardScreen.dart';
import 'package:cremisan_app1/User/user_screens/ProfilePage.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:cremisan_app1/User/user_screens/instructionScreen.dart';
import 'package:cremisan_app1/auth/login.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:flutter_test_1/views/auth_screens/LoginScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'MapScreen.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);
  Locale? initialValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return SingleChildScrollView(
        child: Container(
      child: Column(children: <Widget>[
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/logo22.png',
                    fit: BoxFit.contain,
                    height: 240,
                    width: 250,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        //Now let's Add the button for the Menu
        //and let's copy that and modify it
        ListTile(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DashboardScreen()));
          },
          leading: Icon(
            Icons.home,
            color: Colors.black,
            size: 30,
          ),
          title: Text(
            AppLocalizations.of(context)?.home ?? "value becomes null",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 7.0,
        ),
        ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AboutUs()));
          },
          leading: Icon(
            Icons.info,
            color: Colors.black,
            size: 30,
          ),
          title: Text(
            AppLocalizations.of(context)?.about ?? "value becomes null",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        SizedBox(
          height: 7.0,
        ),
        ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          leading: Icon(
            Icons.person,
            color: Colors.black,
            size: 30,
          ),
          title: Text(
            AppLocalizations.of(context)?.profile ?? "value becomes null",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        ListTile(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ContactUsScreen()));
          },
          leading: Icon(
            Icons.call,
            color: Colors.black,
            size: 30,
          ),
          title: Text(
            AppLocalizations.of(context)?.contact ?? "value becomes null",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        SizedBox(
          height: 7.0,
        ),
        ListTile(
          onTap: () => launch(
              'https://www.google.com/maps/place/%D8%AF%D9%8A%D8%B1+%D9%83%D8%B1%D9%85%D9%8A%D8%B2%D8%A7%D9%86%E2%80%AD/@31.7265593,35.1828682,15z/data=!4m10!1m2!2m1!1scremisan+biet+jala!3m6!1s0x1502d84ae8ca0297:0x5c353959c82184bb!8m2!3d31.727104!4d35.172569!15sChJjcmVtaXNhbiBiZWl0IGphbGGSAQZjaHVyY2jgAQA!16s%2Fg%2F1tj93shg?entry=ttu'),
          leading: Icon(
            Icons.location_on,
            color: Colors.black,
            size: 30,
          ),
          title: Text(
            AppLocalizations.of(context)?.visitus ?? "value becomes null",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 7.0,
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => instractionScreen()));
          },
          leading: Icon(
            Icons.help,
            color: Colors.black,
            size: 30,
          ),
          title: Text(
            AppLocalizations.of(context)?.instructions ?? "value becomes null",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 7.0,
        ),

        ListTile(
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                    AppLocalizations.of(context)?.areYousuredoyouwanttologout ??
                        "value becomes null"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      logout();
                    },
                    child: Text(
                      AppLocalizations.of(context)?.yes ?? "value becomes null",
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(13, 71, 161, 1)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: Text(
                      AppLocalizations.of(context)?.cancel ??
                          "value becomes null",
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(13, 71, 161, 1)),
                    ),
                  )
                ],
              ),
            );
          },
          leading: Icon(
            Icons.logout,
            color: Colors.black,
            size: 30,
          ),
          title: Text(
            AppLocalizations.of(context)?.logout ?? "value becomes null",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 80,
        ),
      ]),
    ));
  }
}

void logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  Get.offAll(() => LoginPage());
}
