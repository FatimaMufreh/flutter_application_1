import 'package:flutter/material.dart';

import 'MainDrawer.dart';
import 'ProfilePage.dart';
import 'animals_categories_screen.dart';
import 'plants_categories_screen.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class Biodiversity extends StatelessWidget {
  List<Widget> screens = [
    PlantsCategoriesPage(),
    AnimalsCategoriesPage(),
  ];
  Locale? initialValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 2: Welcome Header
            Container(
              padding: EdgeInsets.fromLTRB(20, 50, 25, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)?.wlcCremisan ??
                        "value becomes null",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 91, 80),
                      fontFamily: 'SignikaNegative',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    AppLocalizations.of(context)?.bioIntro ??
                        "value becomes null",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 112, 111, 111),
                      fontFamily: 'SignikaNegative',
                    ),
                  ),
                ],
              ),
            ),

            // Section 3: Horizontal Row with Image and Arrow
            buildHorizontalRow(
                context,
                AppLocalizations.of(context)?.plants ?? "value becomes null",
                'assets/plant_background.png',
                0),

            SizedBox(height: 20.0), // Add space between rows

            buildHorizontalRow(
                context,
                AppLocalizations.of(context)?.animals ?? "value becomes null",
                'assets/animals_background.jpg',
                1),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalRow(
      BuildContext context, imageText, String imagePath, int index) {
    return Container(
      height: 200.0,
      margin: EdgeInsets.symmetric(horizontal: 11.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Stack(
          children: [
            // Background Image with Dark Overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                ),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // ListTile at the center
            Center(
              child: ListTile(
                title: Text(
                  imageText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 35,
                  color: Colors.white,
                  onPressed: () {
                    // Your onTap logic for each section goes here
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => screens[index]));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
