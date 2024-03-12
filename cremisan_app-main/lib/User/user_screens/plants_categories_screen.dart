import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cremisan_app1/User/user_screens/ContactUs.dart';
import 'package:cremisan_app1/User/user_screens/DashboardScreen.dart';
import 'package:cremisan_app1/User/user_screens/instructionScreen.dart';
import 'package:cremisan_app1/User/user_screens/plants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cremisan_app1/User/user_screens/events_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/locale_provider.dart';
import 'MainDrawer.dart';
import 'bio.dart';

class PlantsCategoriesPage extends StatefulWidget {
  const PlantsCategoriesPage({Key? key}) : super(key: key);

  @override
  _PlantsCategoriesPageState createState() => _PlantsCategoriesPageState();
}

class _PlantsCategoriesPageState extends State<PlantsCategoriesPage> {
  List _resultsList = [];
  bool _isMounted = false;

  @override
  void initState() {
    print(window.locale.languageCode);
    _isMounted = true;
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  getData() async {
    try {
      var data =
          await FirebaseFirestore.instance.collection('plant_categories').get();
      if (_isMounted) {
        setState(() {
          _resultsList = data.docs;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  ///////////////////////////////////////////////

  List<String> pictures = [
    'assets/flower1.jpeg',
    'assets/flower2.jpeg',
    'assets/flower3.jpeg',
    'assets/flower4.jpeg'
  ];

  List<Widget> screens = [
    Plants(),
    const ContactUsScreen(),
    instractionScreen(),
    const Events(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    String lang = localeProvider.locale?.toString() ?? 'en';
    print(window.locale.languageCode);
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 76, 137),
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context)?.plant_categories ??
              "value becomes null",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              // Your onTap logic for each section goes here
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: GridView.builder(
                  itemCount: _resultsList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => Plants(
                              plantCategory: _resultsList[index]['name'][lang],
                            ),
                          ),
                          (route) =>
                              false, //if you want to disable back feature set to false
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 3, right: 3, top: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 1,
                                spreadRadius: 2,
                              )
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white10, Colors.black],
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                _resultsList[index]['image'],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child: Text(
                                    _resultsList[index]["name"][lang],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
