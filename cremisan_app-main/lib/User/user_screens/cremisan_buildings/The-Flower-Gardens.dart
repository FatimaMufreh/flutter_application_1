import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class Flower_Gardens extends StatefulWidget {
  @override
  _GardensPageState createState() => _GardensPageState();
}

class _GardensPageState extends State<Flower_Gardens> {
  int _currentImageIndex = 0;

  bool isloading = false;
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  ///
  final List<String> imagePaths = [
    "assets/flowergarden1.jpg",
    "assets/flowergarden2.jpg",
    "assets/flowergarden3.jpg",
    "assets/flowergarden4.jpg",
    "assets/flowergarden5.jpg",
    "assets/flowergarden6.jpg",
    "assets/flowergarden7.jpg",

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
                              AppLocalizations.of(context)?.flowergardens ??
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
                                AppLocalizations.of(context)?.flowerinfo ??
                                    "value becomes null",
                                // textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                String phoneNumber2 =
                                    AppLocalizations.of(context)?.number1 ??
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
                                      text: AppLocalizations.of(context)
                                              ?.number1 ??
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
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ))));
  }

  void _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
