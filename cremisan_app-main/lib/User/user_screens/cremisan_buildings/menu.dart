import 'package:cremisan_app1/User/user_screens/cremisan_buildings/BBQ-Areas.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/Organic_Garden.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/Playground.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/Simaan-Srouji-House.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/The-Flower-Gardens.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/Winery.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/convert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class buildings_menu extends StatefulWidget {
  const buildings_menu({Key? key}) : super(key: key);

  @override
  _buildings_menu createState() => _buildings_menu();
}

class _buildings_menu extends State<buildings_menu> {
  Card makeDashboardItem(String title, String img, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Color(0xFF0D47A1),
                    Color(0xFFffffff),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Colors.cyan,
                    Colors.amber,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //1.item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => convert(),
                ),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Flower_Gardens(),
                ),
              );
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BBQ(),
                ),
              );
            }
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Simaan_House(),
                ),
              );
            }
            if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => playground(),
                ),
              );
            }
            if (index == 5) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => organic_garden(),
                ),
              );
            }
            if (index == 6) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Winery(),
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  img,
                  height: 80,
                  width: 90,
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Cremisan Buildings",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(2),
              children: [
                makeDashboardItem(
                    AppLocalizations.of(context)?.convent ??
                        "value becomes null",
                    "assets/convent11.png",
                    0),
                makeDashboardItem(
                    AppLocalizations.of(context)?.flowergardens ??
                        "value becomes null",
                    "assets/flowers11.png",
                    1),
                makeDashboardItem(
                    AppLocalizations.of(context)?.bbqAreas ??
                        "value becomes null",
                    "assets/BBQ11.png",
                    2),
                makeDashboardItem(
                    AppLocalizations.of(context)?.simansrouji ??
                        "value becomes null",
                    "assets/home11.png",
                    3),
                makeDashboardItem(
                    AppLocalizations.of(context)?.playground ??
                        "value becomes null",
                    "assets/playground11.png",
                    4),
                makeDashboardItem(
                    AppLocalizations.of(context)?.organicgarden ??
                        "value becomes null",
                    "assets/garden11.png",
                    5),
                makeDashboardItem(
                    AppLocalizations.of(context)?.cremisanWinery ??
                        "value becomes null",
                    "assets/wine11.png",
                    6),
              ],
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}
