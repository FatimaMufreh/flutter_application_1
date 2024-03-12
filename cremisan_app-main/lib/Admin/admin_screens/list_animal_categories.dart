import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/app_colors.dart';
import '../admin_models/category.dart';
import '../admin_services/animal_categories_services.dart';
import 'DashboardAdmin.dart';
import 'add_animal_category.dart';
import 'edit_animal_category.dart';
import 'main_animals.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ListAnimalCategories extends StatefulWidget {
  const ListAnimalCategories({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListAnimalCategoriesState();
  }
}

class _ListAnimalCategoriesState extends State<ListAnimalCategories> {
  final TextEditingController _searchController = TextEditingController();
  late Future<void> resultsLoaded;
  List<DocumentSnapshot> _allResults = [];
  List<DocumentSnapshot> _resultsList = [];
  String isDataFound = "Empty Data";

  @override
  void initState() {
    super.initState();
    resultsLoaded = getData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text.isNotEmpty) {
      for (int i = 0; i < _allResults.length; i++) {
        String title = _allResults[i]["name"]["en"].toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(_allResults[i]);
        }
      }
    } else {
      isDataFound = "Empty";
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = List<DocumentSnapshot<Object?>>.from(showResults);
    });
  }

  Future<void> getData() async {
    var data =
        await FirebaseFirestore.instance.collection('animal_categories').get();

    setState(() {
      _allResults = data.docs;
    });

    searchResultsList();
  }

  Locale? initialValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    String lang = provider.locale?.toString() ?? 'en';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.uniformColor,
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText:
                (AppLocalizations.of(context)?.search ?? "value becomes null"),
            icon: Icon(Icons.search, color: Colors.white),
            labelStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(color: Colors.white),
          onFieldSubmitted: (_) {
            setState(() {
              // If you want to do something on submission
            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => AddAnimalCategory(),
                ),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: _resultsList.isEmpty
          ? Center(
              child: Text(
                isDataFound,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: _resultsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            _resultsList[index]["name"][lang],
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil<dynamic>(
                                  context,
                                  MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          EditAnimalCategory(
                                            category: CategoryModel(
                                                uid: _resultsList[index].id,
                                                arabic_name: _resultsList[index]
                                                    ["name"]["ar"],
                                                english_name:
                                                    _resultsList[index]["name"]
                                                        ["en"],
                                                image: _resultsList[index]
                                                    ['image']
                                                // Pass other parameters as needed
                                                ),
                                          )),
                                  (route) => false,
                                );
                              },
                              child: Text(AppLocalizations.of(context)?.edit ??
                                  "value becomes null"),
                            ),
                            TextButton(
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
                                          onPressed: () async {
                                            var response =
                                                await FirebaseAnimalCategories
                                                    .deleteCategory(
                                              docId: _resultsList[index].id,
                                            );

                                            if (response.code != 200) {
                                              Fluttertoast.showToast(
                                                msg:
                                                    response.message.toString(),
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                              );
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    response.message.toString(),
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                              );

                                              Navigator.pushAndRemoveUntil<
                                                  dynamic>(
                                                context,
                                                MaterialPageRoute<dynamic>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          DashboardAdmin(1),
                                                ),
                                                (route) => false,
                                              );
                                            }
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)
                                                      ?.confirm ??
                                                  "value becomes null"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                  AppLocalizations.of(context)?.delete ??
                                      "value becomes null"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
