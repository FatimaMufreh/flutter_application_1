import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class instractionScreen extends StatelessWidget {
  instractionScreen({Key? key}) : super(key: key);

  Locale? initialValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);

                        /////////////////////////// to backkk
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        AppLocalizations.of(context)?.instructionsTitle ??
                            "value becomes null",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),

                    SizedBox(
                      width: 50,
                    ),

                    // Icon(Icons.notifications_outlined)
                  ],
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          AppLocalizations.of(context)?.visitors ??
                              "value becomes null",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.hello ??
                              "value becomes null",
                          AppLocalizations.of(context)?.welcometocremisan ??
                              "value becomes null",
                          Icons.star),
                      const SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.highlight ??
                              "value becomes null",
                          AppLocalizations.of(context)?.look ??
                              "value becomes null",
                          Icons.landscape),
                      SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.educate ??
                              "value becomes null",
                          AppLocalizations.of(context)?.cremisan ??
                              "value becomes null",
                          Icons.eco),
                      SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.share ??
                              "value becomes null",
                          AppLocalizations.of(context)?.did ??
                              "value becomes null",
                          Icons.recycling),
                      SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.personal ??
                              "value becomes null",
                          AppLocalizations.of(context)?.each ??
                              "value becomes null",
                          Icons.cleaning_services),
                      SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.inspire ??
                              "value becomes null",
                          AppLocalizations.of(context)?.community ??
                              "value becomes null",
                          Icons.people),
                      SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.future ??
                              "value becomes null",
                          AppLocalizations.of(context)?.think ??
                              "value becomes null",
                          Icons.child_care),
                      SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.request ??
                              "value becomes null",
                          AppLocalizations.of(context)?.kindly ??
                              "value becomes null",
                          FontAwesomeIcons.handshake),
                      SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                          AppLocalizations.of(context)?.positive ??
                              "value becomes null",
                          AppLocalizations.of(context)?.appreciate ??
                              "value becomes null",
                          Icons.volunteer_activism),
                      SizedBox(
                        height: 15,
                      ),
                      iteminstraction(
                        AppLocalizations.of(context)?.gratitude ??
                            "value becomes null",
                        AppLocalizations.of(context)?.thank ??
                            "value becomes null",
                        Icons.favorite,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]))
              ],
            ),
          ]),
        ));
  }
}

iteminstraction(
  String title,
  String subtitle,
  IconData iconData,
) {
  return Container(
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                color: Colors.black.withOpacity(.2),
                spreadRadius: 5,
                blurRadius: 15)
          ]),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.teal.shade700,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(subtitle,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            )),
        leading: Icon(
          iconData,
          color: Colors.black,
        ),
        //tileColor: Colors.white,
      ),
    ),
  );
}
