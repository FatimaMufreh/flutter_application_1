import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class organic_garden extends StatefulWidget {
  @override
  _organic_gardenPageState createState() => _organic_gardenPageState();
}

class _organic_gardenPageState extends State<organic_garden> {
  int _currentImageIndex = 0;

  bool isloading = false;

  final List<String> imagePaths = [
    "assets/organic1.jpg",
    "assets/organic2.jpg",
    "assets/organic3.jpg",
    "assets/organic4.jpg",

    // Add more image paths as needed
  ];
  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.transparent,
          elevation: 0.02,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
                child: isloading
                    ? Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 260.0,
                              width: double.infinity,
                              child: CarouselSlider(
                                // dotPosition: DotPosition.topCenter,
                                options: CarouselOptions(
                                  // Customize carousel options as needed
                                  height: 260,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  // aspectRatio: 16 / 9,
                                  viewportFraction: 1.0,
                                ),
                                items: imagePaths
                                    .map((item) => Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.asset(
                                            item,
                                            fit: BoxFit.cover,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)?.organicgarden ??
                                  "value becomes null",
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "'\u{26D4} " +
                                  (AppLocalizations.of(context)
                                          ?.entryforemployeesonly ??
                                      "value becomes null"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10),
                              child: Text(
                                AppLocalizations.of(context)
                                        ?.organicgardeninfo ??
                                    "value becomes null",
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ))));
  }
}
