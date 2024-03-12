import 'package:flutter/material.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUs> {
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.transparent,
          elevation: 0.00,
          centerTitle: true,
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/logo22.png',
                        fit: BoxFit.contain,
                        height: 240,
                        width: 250,
                      ),
                    ),
                  ])),
              SizedBox(
                height: 30.0,
              ),
              Text(
                AppLocalizations.of(context)?.st ?? "value becomes null",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.salesians ??
                      "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.work ?? "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.saint ?? "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.help ?? "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.don ?? "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.today ?? "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.holy ?? "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.queen ?? "value becomes null",
                  // textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.belongs ?? "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  AppLocalizations.of(context)?.area ?? "value becomes null",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(height: 50),
            ]),
          ),
        ));
  }
}
