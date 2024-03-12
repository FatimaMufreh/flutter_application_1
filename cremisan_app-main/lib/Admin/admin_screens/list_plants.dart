import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cremisan_app1/Admin/admin_screens/main_plants.dart';
import 'package:cremisan_app1/Admin/admin_services/plant_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/app_colors.dart';
import '../admin_models/plants.dart';
import 'DashboardAdmin.dart';
import 'add_plant.dart';
import 'edit_plant.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ListPlants extends StatefulWidget {
  const ListPlants({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListPlants();
  }
}

class _ListPlants extends State<ListPlants> {
  final TextEditingController _searchController = TextEditingController();
  Icon customIcon = const Icon(Icons.search);
  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  String isDataFound = "Empty Data";
  @override
  void initState() {
    getData();
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getData();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text.isNotEmpty) {
      for (int i = 0; i < _allResults.length; i++) {
        String nameEn = _allResults[i]["name"]["en"].toLowerCase();
        String nameAr = _allResults[i]["name"]["ar"].toLowerCase();

        if (nameEn.contains(_searchController.text.toLowerCase()) ||
            nameAr.contains(_searchController.text.toLowerCase())) {
          showResults.add(_allResults[i]);
        }
      }
    } else {
      isDataFound = "Empty";
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getData() async {
    var data = await FirebaseFirestore.instance.collection('plants').get();

    setState(() {
      _allResults = data.docs;
    });

    searchResultsList();
    return "complete";
  }

  bool isShowUsers = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    String lang = provider.locale?.toString() ?? 'en';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable the default back arrow

        backgroundColor: AppColors.uniformColor,

        title: Form(
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.search ??
                    "value becomes null",
                icon: Icon(Icons.search, color: Colors.white),
                labelStyle: TextStyle(color: Colors.white)),
            style: const TextStyle(color: Colors.white),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              print(_);
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => PlantForm(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
          )
        ],
      ),
      body: _resultsList.isEmpty
          ? Container(
              child: Center(
                child: Text(
                  isDataFound,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
            )
          : ListView.builder(
              itemCount: _resultsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.all(0), // Ensure no extra padding
                      leading: Container(
                        width: 80,
                        height: 80,
                        child:
                            _resultsList[index]["image"] == "assets/empty.png"
                                ? Image.asset(
                                    "assets/empty.png",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    _resultsList[index]["image"].toString(),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                      title: Text(_resultsList[index]['name'][lang]),
                      // subtitle:
                      //     Text(_resultsList[index]['location'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Perform edit action
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => EditPlant(
                                    plant: Plant(
                                      uid: _resultsList[index].id,
                                      image: _resultsList[index]['image'],
                                      en_name: _resultsList[index]['name']
                                          ['en'],
                                      ar_name: _resultsList[index]['name']
                                          ['ar'],
                                      en_info: _resultsList[index]['info']
                                          ['en'],
                                      ar_info: _resultsList[index]['info']
                                          ['ar'],
                                      en_plant_category: _resultsList[index]
                                          ['plant_category']['en'],
                                      ar_plant_category: _resultsList[index]
                                          ['plant_category']['ar'],
                                      en_species_name: _resultsList[index]
                                          ['species_name']['en'],
                                      ar_species_name: _resultsList[index]
                                          ['species_name']['ar'],
                                      en_family: _resultsList[index]['family']
                                          ['en'],
                                      ar_family: _resultsList[index]['family']
                                          ['ar'],
                                    ),
                                  ),
                                ),
                                (route) =>
                                    false, //if you want to disable back feature set to false
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(AppLocalizations.of(context)
                                              ?.confirmtocompletedeleteprocess ??
                                          "value becomes null"),
                                      actions: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return AppColors
                                                        .disabledColor; // Color for disabled state
                                                  }
                                                  return AppColors
                                                      .uniformColor; // Default color
                                                },
                                              ),
                                            ),
                                            onPressed: () async {
                                              print(AppLocalizations.of(context)
                                                      ?.confirmtoapplydeletion ??
                                                  "value becomes null");

                                              var response = await FirebasePlant
                                                  .deletePlant(
                                                      docId: _resultsList[index]
                                                          .id);
                                              if (response.code != 200) {
                                                Fluttertoast.showToast(
                                                  msg: response.message
                                                      .toString(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                );
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg: response.message
                                                      .toString(),
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                );

                                                Navigator.pushAndRemoveUntil<
                                                        dynamic>(
                                                    context,
                                                    MaterialPageRoute<dynamic>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          DashboardAdmin(2),
                                                    ),
                                                    (route) =>
                                                        false); //if you want to disable back feature set to false
                                              }
                                            },
                                            child: Text(
                                                AppLocalizations.of(context)
                                                        ?.confirm ??
                                                    "value becomes null"))
                                      ],
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
