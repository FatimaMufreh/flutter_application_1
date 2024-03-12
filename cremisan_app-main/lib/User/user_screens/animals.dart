import 'package:cremisan_app1/User/user_screens/animal_details.dart';
import 'package:cremisan_app1/User/user_screens/animals_categories_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import '../../provider/locale_provider.dart';

class Animals extends StatefulWidget {
  final String? animalCategory;

  const Animals({Key? key, this.animalCategory}) : super(key: key);

  @override
  _AnimalsState createState() => _AnimalsState();
}

class _AnimalsState extends State<Animals> {
  late Future<List<DocumentSnapshot>> resultsLoaded;
  List<DocumentSnapshot> _animals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    resultsLoaded = getData();
  }

  Future<List<DocumentSnapshot>> getData() async {
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    String lang = localeProvider.locale?.toString() ?? 'en';
    try {
      var animalsData = await FirebaseFirestore.instance
          .collection('animals')
          .where('animal_category.$lang',
              isEqualTo: widget
                  .animalCategory) // Assuming 'en' is the key for English in the 'animal_category' map
          .get();
      print(animalsData.docs.length);
      setState(() {
        _animals = animalsData.docs;
        isLoading = false;
      });

      return _animals;
    } catch (e) {
      // Handle errors, e.g., show an error message or log the error
      print('Error fetching data: $e');
      return [];
    }
  }

  Locale? initialValue;

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    String lang = localeProvider.locale?.toString() ?? 'en';
    print('==================');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.animalCategory ?? 'Animals',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightBlue[900],
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigate back to the previous screen
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => AnimalsCategoriesPage(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : _animals.isEmpty
                ? Center(
                    child: Text(
                    AppLocalizations.of(context)?.noData ??
                        "value becomes null",
                  ))
                : ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: _animals.length,
                    itemBuilder: (context, index) {
                      return PestCard(pestData: _animals[index], lang: lang);
                    },
                  ));
  }
}

class PestCard extends StatelessWidget {
  final DocumentSnapshot pestData;
  final lang;

  const PestCard({required this.pestData, this.lang});

  @override
  Widget build(BuildContext context) {
    String name = pestData['name'][this.lang].toString();
    String image = pestData['image'].toString();

    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color.fromARGB(255, 239, 242, 247),
        child: Column(
          children: [
            Stack(
              children: [
                Ink.image(
                  image: NetworkImage(image),
                  height: 240,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimalDetails(
                      name,
                      image,
                      pestData['info'][this.lang],
                      pestData['animal_category'][this.lang],
                    )));
      },
    );
  }
}
