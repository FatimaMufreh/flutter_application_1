import 'package:cremisan_app1/User/user_screens/CamerascanScreen.dart';
import 'package:cremisan_app1/User/user_screens/MapScreen.dart';
import 'package:cremisan_app1/User/user_screens/events_page.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bio.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> screens = [
    MapScreen(),
    Events(),
    Qrscan(),
    Biodiversity(),
  ];

  int index = 0;
  changeIndex(int v) {
    setState(() {
      index = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          screens[index],
          Positioned(
              bottom: -5,
              left: 0,
              right: 0,
              child: Container(
                  width: double.infinity,
                  height: 90,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 71,
                    margin:
                        EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 15,
                              spreadRadius: 15)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              changeIndex(0);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Icon(FontAwesomeIcons.home,
                                  size: 25,
                                  color: index == 0
                                      ? Color.fromARGB(255, 143, 197, 238)
                                      : AppColors.uniformColor),
                            )),
                        InkWell(
                            onTap: () {
                              changeIndex(1);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Icon(FontAwesomeIcons.calendar,
                                  size: 25,
                                  color: index == 1
                                      ? Color.fromARGB(255, 143, 197, 238)
                                      : AppColors.uniformColor),
                            )),
                        InkWell(
                            onTap: () {
                              changeIndex(2);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Icon(FontAwesomeIcons.camera,
                                  size: 25,
                                  color: index == 2
                                      ? Color.fromARGB(255, 143, 197, 238)
                                      : AppColors.uniformColor),
                            )),
                        InkWell(
                            onTap: () {
                              changeIndex(3);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Icon(FontAwesomeIcons.seedling,
                                  size: 25,
                                  color: index == 3
                                      ? Color.fromARGB(255, 143, 197, 238)
                                      : AppColors.uniformColor),
                            )),
                      ],
                    ),
                  )))
        ],
      ),
    ));
  }
}