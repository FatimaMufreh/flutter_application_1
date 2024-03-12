// plants.dart
import 'package:cremisan_app1/User/user_screens/plants_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:provider/provider.dart';
import '../../provider/locale_provider.dart';
import 'plant_details.dart';

class Plants extends StatefulWidget {
  final String? plantCategory;

  const Plants({Key? key, this.plantCategory}) : super(key: key);

  @override
  _Plants createState() => _Plants();
}

class _Plants extends State<Plants> {
  late Future<List<DocumentSnapshot>> resultsLoaded;
  List<DocumentSnapshot> _plants = [];
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
      // Fetch data without delaying the UI
      var plantsData = await FirebaseFirestore.instance
          .collection('plants')
          .where('plant_category.$lang', isEqualTo: widget.plantCategory)
          .get();

      setState(() {
        _plants = plantsData.docs;
        isLoading = false;
      });

      return _plants;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    String lang = localeProvider.locale?.toString() ?? 'en';

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.plantCategory ?? 'Plants',
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
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => PlantsCategoriesPage(),
                ),
                (route) => false,
              );
            },
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : _plants.isEmpty
                ? Center(
                    child: Text(
                    AppLocalizations.of(context)?.noData ??
                        "value becomes null",
                  ))
                : ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: _plants.length,
                    itemBuilder: (context, index) {
                      return PestCard(pestData: _plants[index], lang: lang);
                    },
                  ));
  }
}

class PestCard extends StatelessWidget {
  final DocumentSnapshot pestData;
  final String lang;

  const PestCard({required this.pestData, required this.lang});

  @override
  Widget build(BuildContext context) {
    String name = pestData['name'][lang].toString();
    String image = pestData['image'].toString();

    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
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
              builder: (context) => PlantDetails(
                  pestData['name']['en'],
                  pestData['name']['ar'],
                  image,
                  pestData['info'][lang],
                  pestData['species_name'][lang],
                  pestData['family'][lang])),
        );
      },
    );
  }
}
