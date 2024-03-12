import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cremisan_app1/User/user_screens/MainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../provider/locale_provider.dart';
import '../user_widgets/custom_drop_down.dart';
import '../user_widgets/event_card.dart';
import 'event_details.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _AttractionPageState();
}

class _AttractionPageState extends State<Events> {
  int clicked = 0;
  String lang = window.locale.languageCode;
  String _selectedCategory = "all";
  List _allResults = [];
  List _resultsList = [];
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;

  // Define the categories map
  Map<String, Map<String, String>> _categories = {
    'all': {'en': "All", 'ar': 'الكل'},
    'edu': {'en': 'Educational', 'ar': 'تعليمي'},
    'env': {'en': 'Envionmental', 'ar': 'بيئي'},
    'relg': {'en': 'Religious', 'ar': 'ديني'},
    'recr': {'en': 'Recreational', 'ar': 'ترفيهي'},
  };

  // Function to set the default language
  // void _setDefaultLanguage() {
  //   Future.delayed(Duration.zero, () {
  //     setState(() {
  //       var localeProvider =
  //           Provider.of<LocaleProvider>(context, listen: false);

  //       // Check if the mobile language is 'ar' or 'en', set it as the app language
  //       // Otherwise, set the default language to 'en'
  //       if (window.locale.languageCode == 'ar' ||
  //           window.locale.languageCode == 'en') {
  //         lang = window.locale.languageCode;
  //       } else {
  //         lang = 'en';
  //       }
  //     });
  //   });
  // }

  @override
  void initState() {
    // _setDefaultLanguage();

    print(lang);

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
    getData();
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
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getData() async {
    QuerySnapshot data;
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    setState(() {
      lang = localeProvider.locale?.toString() ?? 'en';
    });
    if (_selectedCategory == 'all') {
      data = await FirebaseFirestore.instance.collection('events').get();
    } else {
      data = await FirebaseFirestore.instance
          .collection('events')
          .where('event_category.$lang',
              isEqualTo: _categories[_selectedCategory]![lang]!)
          .get();
    }

    setState(() {
      _allResults = data.docs;
      isLoading = false;
    });

    searchResultsList();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    var localeProvider2 = Provider.of<LocaleProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Form(
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)?.search ?? "Search",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                suffixIcon: Icon(Icons.search, color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              onFieldSubmitted: (String _) {
                getData();
              },
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[900],
        ),
        body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: myHeight * 0.03,
                  left: myWidth * 0.06,
                  right: myWidth * 0.06,
                ),
                child: SizedBox(
                  height: myHeight * 0.06,
                  width: myWidth,
                  child: ListView.builder(
                    itemCount: _categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return categoryWidget(index, lang);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _resultsList.isEmpty
                      ? Center(
                          child: Text(
                          AppLocalizations.of(context)?.noData ??
                              "value becomes null",
                        ))
                      : Expanded(
                          child: GridView.builder(
                            itemCount: _resultsList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: EventCard(
                                  image: _resultsList[index]['image'],
                                  name: _resultsList[index]['name'][lang],
                                  location: _resultsList[index]['place'][lang],
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EventDetailScreen(
                                            _resultsList[index]['image'],
                                            _resultsList[index]['name'][lang],
                                            _resultsList[index]['place'][lang],
                                            _resultsList[index]['info'][lang],
                                            _resultsList[index]['time'],
                                            _resultsList[index]['address']
                                                [lang],
                                            _resultsList[index]['date'],
                                            _resultsList[index]['location_url'],
                                            _resultsList[index]['phoneNo'],
                                          )));
                                },
                              );
                            },
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(int index, String lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: GestureDetector(
        onTap: () {
          setState(() {
            clicked = index;
            _selectedCategory =
                _selectedCategory = _categories.keys.toList()[index];
            print(_selectedCategory);
            getData();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
          decoration: clicked == index
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 15, 72, 171),
                      Color.fromARGB(255, 70, 93, 157),
                    ],
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 3,
                    ),
                  ],
                ),
          child: Center(
            child: Text(
              _categories[_categories.keys.toList()[index]]?[lang!] ??
                  "Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: clicked == index ? Colors.white : Colors.grey,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
