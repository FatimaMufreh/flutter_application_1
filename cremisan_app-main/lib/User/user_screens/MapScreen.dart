import 'package:cremisan_app1/User/user_screens/MainDrawer.dart';
import 'package:cremisan_app1/User/user_screens/ProfilePage.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/BBQ-Areas.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/Organic_Garden.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/Playground.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/Simaan-Srouji-House.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/The-Flower-Gardens.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/Winery.dart';
import 'package:cremisan_app1/User/user_screens/cremisan_buildings/convert.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../utils/app_colors.dart';

const String defaultImageUrl = "assets/medium_map_horizental.png";

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String imageUrl = defaultImageUrl;
  bool isExpanded = false;
  int location = 0;
  bool isLoading = false;

  Future<void> _loadDefaultImage() async {
    setState(() {
      isLoading = true;
    });

    final image = Image.asset(imageUrl);

    // Use the image stream to listen for when the image is fully loaded
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, synchronousCall) {
          // Image is fully loaded, set isLoading to false
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadDefaultImage();
  }

  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // elevation: 3.9999,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Handle your profile navigation here
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            icon: Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          )
        ],

        title: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(131, 0, 0, 0),
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
              location = 0;
              imageUrl = defaultImageUrl;
            });
          },
          icon: IconTheme(
            data: IconThemeData(
              color:
                  Color.fromARGB(255, 255, 255, 255), // Change the color here
            ),
            child: Icon(Icons.arrow_drop_down),
          ),
          label: Text(
            AppLocalizations.of(context)?.attractions ?? "value becomes null",
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          shape: BeveledRectangleBorder(),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        child: MainDrawer(),
      ),
      body: Stack(
        children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 1, 108, 5),
                  ),
                )
              : PhotoView(
                  imageProvider: AssetImage(imageUrl),
                  minScale: PhotoViewComputedScale.covered,
                  maxScale: PhotoViewComputedScale.covered * 10.0,
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  enableRotation: false,
                  initialScale: PhotoViewComputedScale.covered,
                  basePosition: Alignment.bottomLeft,
                ),
          imageUrl != defaultImageUrl
              ? InkWell(
                  onTap: () {
                    _navigateToLocationScreen();
                  },
                  child: Center(
                    child: Container(
                      width: 350.0,
                      height: 350.0,
                      decoration: BoxDecoration(
                        // color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                )
              : Container(),
          Positioned(
            top: 60,
            left: 10.0,
            right: 10.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 8),
                  if (isExpanded)
                    ElevatedButton(
                      onPressed: () => _updateImage("assets/playground.png", 0),
                      child: Text(
                          AppLocalizations.of(context)?.playgroundMap ??
                              "value becomes null",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color.fromARGB(131, 0, 0, 0),
                      ),
                    ),
                  SizedBox(width: 8),
                  if (isExpanded)
                    ElevatedButton(
                      onPressed: () => _updateImage("assets/Convent.png", 1),
                      child: Text(
                          AppLocalizations.of(context)?.conventMap ??
                              "value becomes null",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color.fromARGB(131, 0, 0, 0),
                      ),
                    ),
                  SizedBox(width: 8),
                  if (isExpanded)
                    ElevatedButton(
                      onPressed: () => _updateImage("assets/factory.png", 2),
                      child: Text(
                          AppLocalizations.of(context)?.cremisanWinery ??
                              "value becomes null",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color.fromARGB(131, 0, 0, 0),
                      ),
                    ),
                  SizedBox(width: 8),
                  if (isExpanded)
                    ElevatedButton(
                      onPressed: () =>
                          _updateImage("assets/flowersGarden.png", 3),
                      child: Text(
                          AppLocalizations.of(context)?.flowergardensMap ??
                              "value becomes null",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color.fromARGB(131, 0, 0, 0),
                      ),
                    ),
                  SizedBox(width: 8),
                  if (isExpanded)
                    ElevatedButton(
                      onPressed: () => _updateImage("assets/bbq.png", 4),
                      child: Text(
                          AppLocalizations.of(context)?.bbqAreas ??
                              "value becomes null",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color.fromARGB(131, 0, 0, 0),
                      ),
                    ),
                  SizedBox(width: 8),
                  if (isExpanded)
                    ElevatedButton(
                      onPressed: () =>
                          _updateImage("assets/organicGarden.png", 5),
                      child: Text(
                          AppLocalizations.of(context)?.organicgarden ??
                              "value becomes null",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color.fromARGB(131, 0, 0, 0),
                      ),
                    ),
                  SizedBox(width: 8),
                  if (isExpanded)
                    ElevatedButton(
                      onPressed: () =>
                          _updateImage("assets/simaanHouse.png", 6),
                      child: Text(
                          AppLocalizations.of(context)?.simansrouji ??
                              "value becomes null",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Color.fromARGB(131, 0, 0, 0),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateImage(String newImageUrl, int newLocation) {
    setState(() {
      isLoading = true;
      imageUrl = newImageUrl;
      location = newLocation;
    });

    final image = Image.asset(newImageUrl);

    // Use the image stream to listen for when the new image is fully loaded
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, synchronousCall) {
          // New image is fully loaded, set isLoading to false
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }

  void _navigateToLocationScreen() {
    if (location == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => playground()),
      );
    } else if (location == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => convert()),
      );
    } else if (location == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Winery()),
      );
    } else if (location == 3) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Flower_Gardens()),
      );
    } else if (location == 4) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => BBQ()),
      );
    } else if (location == 5) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => organic_garden()),
      );
    } else if (location == 6) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Simaan_House()),
      );
    }
  }
}
