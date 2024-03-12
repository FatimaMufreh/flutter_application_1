import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import '../../l10n/l10n.dart';
import '../../provider/locale_provider.dart';
import 'custom_drop_down.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/logo44.png',
                height: 350,
                width: 400,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showLanguageSelectionDialog(provider);
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 2, 32, 200),
                fixedSize: Size(200, 60),
              ),
              child: Text('Select App Language',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelectionDialog(LocaleProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: CustomDropDownWidget(provider: provider),
        );
      },
    );
  }
}
