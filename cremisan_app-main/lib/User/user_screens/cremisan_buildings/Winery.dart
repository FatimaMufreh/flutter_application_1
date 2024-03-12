import 'package:cremisan_app1/User/user_screens/cremisan_buildings/LargeImageView.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import 'menuWine.dart';

class winary extends StatelessWidget {
  final String category;
  final List<String> items;

  winary(this.category, this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) => ListTile(title: Text(item))).toList(),
        ),
      ],
    );
  }
}

class Winery extends StatefulWidget {
  @override
  _WineryPageState createState() => _WineryPageState();
}

class _WineryPageState extends State<Winery> {
  int _currentImageIndex = 0;

  bool isloading = false;
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  final List<String> imagePaths = [
    "assets/winary6.jpg",
    "assets/winary5.jpg",

    "assets/winary7.jpg",
    "assets/winary1.jpg",

    "assets/winary4.jpg",
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
                          options: CarouselOptions(
                            height: 260,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                          ),
                          items: imagePaths
                              .map((item) => Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LargeImageView(
                                              imagePath: item,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        item,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)?.cremisanWinery ??
                            "value becomes null",
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "'\u{1F4DD} " +
                            (AppLocalizations.of(context)
                                    ?.reservationRequired ??
                                "value becomes null"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          AppLocalizations.of(context)?.winaryinfo1 ??
                              "value becomes null",
                          // textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          AppLocalizations.of(context)?.winaryinfo2 ??
                              "value becomes null",
                          // textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10),
                        child: Text(
                          AppLocalizations.of(context)?.winaryinfo3 ??
                              "value becomes null",
                          // textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),

                      Card(
                        color: AppColors.darkblueColor,
                        elevation: 0.5,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          // Replace with your desired color

                          title: Text(
                            " \u{1F377} " +
                                (AppLocalizations.of(context)
                                        ?.productsoftheWinery ??
                                    "value becomes null"),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              // Add your logic here, e.g., navigate to a new screen.
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WineParts();
                              }));
                            },
                            child: Icon(
                              Icons.chevron_right,
                              // Replace with your desired color
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      //  Text(
                      //   "Products of the Winery",
                      //   textAlign: TextAlign.start,
                      // style: TextStyle(
                      //   fontSize: 20,
                      //   fontWeight: FontWeight.bold,
                      //  ),
                      // ),
                      //SizedBox(height: 50),
                      // Display Wine Menu
                      //  WineMenu(),

                      SizedBox(
                        height: 40,
                      ),

                      GestureDetector(
                        onTap: () {
                          String phoneNumber2 =
                              AppLocalizations.of(context)?.number2 ??
                                  "value becomes null";
                          launch("tel:// $phoneNumber2");
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: (AppLocalizations.of(context)
                                            ?.forreservationpleasecall ??
                                        "value becomes null") +
                                    " ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)?.number2 ??
                                    "value becomes null",
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
