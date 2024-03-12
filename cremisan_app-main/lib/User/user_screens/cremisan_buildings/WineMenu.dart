import 'package:cremisan_app1/User/user_screens/cremisan_buildings/LargeImageView.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WineMenu extends StatelessWidget {
  final List<String> entryLevelWines = [
    "Star of Bethlehem Red",
    "Star of Bethlehem White",
    "Messa Red (Medium Sweet)",
    "Messa White (Medium Sweet)"
  ];

  final List<String> nativeGrapeSeries = [
    "Baladi",
    "Rosé (Baladi)",
    "Hamdani Jandali",
    "Dabouki"
  ];

  final List<String> reservedWines = [
    "Reserve",
    "Cabernet Sauvignon"
  ];

  final List<String> superAlcohol = [
    "Brandy",
    "Arak"
  ];

  final List<String> liqueurs = [
    "Limoncello",
    "Lemon Cream",
    "Coffee Liqueur",
    "Cherry Liqueur"
  ];

  final List<String> nonAlcoholic = [
    "Grape Juice",
    "Vinegar",
    "Extra Virgin Olive Oil"
  ];
  final List<String> wines = [
    "assets/wine1.jpg",
    "assets/wine2.jpg",
    "assets/wine3.jpg",
  
    // Add more image paths as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryWidget("Entry Level / House Wines", entryLevelWines),
 
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: wines.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LargeImageView(
                                      imagePath: wines[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.all(8.0),
                                child: Image.asset(
                                  wines[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
         
         
           Divider(
              thickness: 1.0, // Adjust the thickness of the line
              color: AppColors.darkblueColor, // Set the color of the line
              indent: 10.0, // Adjust the starting point of the line
              endIndent: 10.0, // Adjust the ending point of the line
            ),
            SizedBox(height: 40,),
        CategoryWidget("Native Grape Series", nativeGrapeSeries),
        Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: wines.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LargeImageView(
                                      imagePath: wines[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.all(8.0),
                                child: Image.asset(
                                  wines[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                              SizedBox(height: 10,),
         
         
           Divider(
              thickness: 1.0, // Adjust the thickness of the line
              color: AppColors.darkblueColor, // Set the color of the line
              indent: 10.0, // Adjust the starting point of the line
              endIndent: 10.0, // Adjust the ending point of the line
            ),
            SizedBox(height: 40,),
            //////3
            //
        CategoryWidget("Reserved Wines", reservedWines),
        Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: wines.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LargeImageView(
                                      imagePath: wines[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.all(8.0),
                                child: Image.asset(
                                  wines[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                               SizedBox(height: 10,),
         
         
           Divider(
              thickness: 1.0, // Adjust the thickness of the line
              color: AppColors.darkblueColor, // Set the color of the line
              indent: 10.0, // Adjust the starting point of the line
              endIndent: 10.0, // Adjust the ending point of the line
            ),
            SizedBox(height: 40,),
            ///////////4
            ///
        CategoryWidget("Super Alcohol", superAlcohol),
        Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: wines.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LargeImageView(
                                      imagePath: wines[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.all(8.0),
                                child: Image.asset(
                                  wines[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                               SizedBox(height: 10,),
         
         
           Divider(
              thickness: 1.0, // Adjust the thickness of the line
              color: AppColors.darkblueColor, // Set the color of the line
              indent: 10.0, // Adjust the starting point of the line
              endIndent: 10.0, // Adjust the ending point of the line
            ),
            SizedBox(height: 40,),
            ////////5
            ///
        CategoryWidget("Liqueurs", liqueurs),
        Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: wines.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LargeImageView(
                                      imagePath: wines[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.all(8.0),
                                child: Image.asset(
                                  wines[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                               SizedBox(height: 10,),
         
         
           Divider(
              thickness: 1.0, // Adjust the thickness of the line
              color: AppColors.darkblueColor, // Set the color of the line
              indent: 10.0, // Adjust the starting point of the line
              endIndent: 10.0, // Adjust the ending point of the line
            ),
            SizedBox(height: 40,),
            ///////6
            ///
        CategoryWidget("Non-alcoholic", nonAlcoholic),
        Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: wines.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LargeImageView(
                                      imagePath: wines[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.all(8.0),
                                child: Image.asset(
                                  wines[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                              SizedBox(height: 10,),
         
         
           Divider(
              thickness: 1.0, // Adjust the thickness of the line
              color: AppColors.darkblueColor, // Set the color of the line
              indent: 10.0, // Adjust the starting point of the line
              endIndent: 10.0, // Adjust the ending point of the line
            ),
        
            /////////
      ],
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String category;
  final List<String> items;

  CategoryWidget(this.category, this.items);

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