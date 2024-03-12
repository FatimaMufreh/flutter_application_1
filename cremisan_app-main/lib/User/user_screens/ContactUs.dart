import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // Default text color
  Color textColor = AppColors.darkblueColor;

  Locale? initialValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: textColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          /////////////////////////// to backkk
                        },
                      ),
                      SizedBox(width: 20),
                      // Icon(Icons.notifications_outlined)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            AppLocalizations.of(context)?.contact ??
                                "value becomes null",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: AppColors.darkblueColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)?.inquiries ??
                              "value becomes null",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  itemContact(
                    AppLocalizations.of(context)?.callme ??
                        "value becomes null",
                    '+97022744025',
                    CupertinoIcons.phone,
                    textColor, // Pass the current text color
                    () => changeColor(),
                    () => launch('tel: 02-274 2605'),
                  ),
                  const SizedBox(height: 50),
                  itemContact(
                    AppLocalizations.of(context)?.emailus ??
                        "value becomes null",
                    ' cremisan@donboscomor.org',
                    CupertinoIcons.mail,
                    textColor, // Pass the current text color
                    () => changeColor(),
                    () => launch(
                      'mailto:rajatrrpalankar@gmail.com?subject=This is Subject Title&body=This is Body of Email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          color: Colors.black.withOpacity(.2),
                          spreadRadius: 5,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)?.socialmedia ??
                              "value becomes null",
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.uniformColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.facebook,
                                        size: 50,
                                        color: AppColors.uniformColor,
                                      ),
                                      onPressed: () => launch(
                                          'https://www.facebook.com/people/Cremisan-Salesian-Convent/100082275753257/'),
                                      iconSize: 50,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                                  ?.facebook ??
                                              "value becomes null", // Subtitle for Facebook
                                          style: TextStyle(
                                            color: AppColors.darkblueColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                                  ?.followusonfacebok ??
                                              "value becomes null",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.instagram,
                                        size: 50,
                                        color: Colors.pink,
                                      ),
                                      onPressed: () => launch(
                                          'https://www.instagram.com/cremisan.salesian.convent?igshid=OGQ5ZDc2ODk2ZA== '),
                                      iconSize: 50,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                                  ?.instgram ??
                                              "value becomes null", // Subtitle for Instagram
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkblueColor,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                                  ?.followusoninstagram ??
                                              "value becomes null",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeColor() {
    setState(() {
      // Change the text color to a new color (e.g., red)
      textColor = Colors.red;
    });
  }

  Widget itemContact(
    String title,
    String subtitle,
    IconData iconData,
    Color textColor,
    VoidCallback? onLongPress,
    final VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.black.withOpacity(.2),
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: AppColors.darkblueColor,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              color: Colors.grey,
            ),
          ),
          leading: Icon(
            iconData,
            color: Colors.grey,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
