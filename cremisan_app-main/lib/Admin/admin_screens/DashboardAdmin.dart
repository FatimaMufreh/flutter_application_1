import 'package:cremisan_app1/Admin/admin_screens/main_animals.dart';
import 'package:cremisan_app1/Admin/admin_screens/main_plants.dart';
import 'package:cremisan_app1/Admin/admin_screens/manage_events.dart';
import 'package:cremisan_app1/Admin/admin_screens/view_users.dart';
import 'package:cremisan_app1/User/user_screens/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/app_colors.dart';

class DashboardAdmin extends StatefulWidget {
  int index = 0;

  DashboardAdmin(this.index);

  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  List<Widget> screens = [
    EventScreen(),
    MainAnimals(),
    MainPlants(),
    ViewUsers(),
    ProfilePage()
  ];

  changeIndex(int v) {
    setState(() {
      widget.index = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            screens[widget.index],
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
                  margin: EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 10,
                    bottom: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        spreadRadius: 15,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          changeIndex(0);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(FontAwesomeIcons.calendar,
                              size: 25,
                              color: widget.index == 0
                                  ? Color.fromARGB(255, 143, 197, 238)
                                  : AppColors.uniformColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeIndex(1);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(FontAwesomeIcons.paw,
                              size: 25,
                              color: widget.index == 1
                                  ? Color.fromARGB(255, 143, 197, 238)
                                  : AppColors.uniformColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeIndex(2);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(FontAwesomeIcons.seedling,
                              size: 25,
                              color: widget.index == 2
                                  ? Color.fromARGB(255, 143, 197, 238)
                                  : AppColors.uniformColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeIndex(3);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.people,
                              size: 25,
                              color: widget.index == 3
                                  ? Color.fromARGB(255, 143, 197, 238)
                                  : AppColors.uniformColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeIndex(4);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.person,
                              size: 25,
                              color: widget.index == 4
                                  ? Color.fromARGB(255, 143, 197, 238)
                                  : AppColors.uniformColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
