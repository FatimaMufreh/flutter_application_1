import 'package:cremisan_app1/provider/locale_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../user_widgets/custom_drop_down.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppLocalizations.of(context)?.settings ?? "value becomes null",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.yellow[800],
                ),
                SizedBox(
                  width: 8,
                  height: 30,
                ),
                Text(
                  AppLocalizations.of(context)?.account ?? "value becomes null",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(
                context,
                AppLocalizations.of(context)?.changePassword ??
                    "value becomes null"),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(
                context,
                AppLocalizations.of(context)?.contentSettings ??
                    "value becomes null"),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context,
                AppLocalizations.of(context)?.social ?? "value becomes null"),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow1(context,
                AppLocalizations.of(context)?.language ?? "value becomes null"),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(
                context,
                AppLocalizations.of(context)?.privacyandSecurity ??
                    "value becomes null"),
            SizedBox(
              height: 40,
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 227, 170, 26),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {},
                child: Text(
                    AppLocalizations.of(context)?.logout ??
                        "value becomes null",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  CustomDropDownWidget buildAccountOptionRow1(
      BuildContext context, String title) {
    String selectedLanguage = 'English'; // Default language
    final provider = Provider.of<LocaleProvider>(context);

    return CustomDropDownWidget(provider: provider);
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
