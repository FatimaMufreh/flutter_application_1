import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListUsers();
  }
}

class _ListUsers extends State<ListUsers> {
  //FirebaseFirestore.instance.collection('Employee').snapshots();
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
        String username = _allResults[i]["username"].toLowerCase();
        String city = _allResults[i]["city"].toLowerCase();

        if (city.contains(_searchController.text.toLowerCase()) ||
            username.contains(_searchController.text.toLowerCase())) {
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
    var data = await FirebaseFirestore.instance.collection('users').get();

    setState(() {
      _allResults = data.docs;
    });

    searchResultsList();
    return "complete";
  }

  bool isShowUsers = false;

  //////////////////////////
  ///

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    var localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    String lang = localeProvider.locale?.toString() ?? 'en';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColors.uniformColor,
        title: Form(
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
                labelText: AppLocalizations.of(context)?.search ??
                    "value becomes null",
                icon: Icon(Icons.search, color: Colors.white),
                labelStyle: TextStyle(color: Colors.white)),
            style: const TextStyle(color: Colors.black),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              print(_);
            },
          ),
        ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        // This Will Call When User Click On ListView Item
                        // showDialogFunc(
                        //   context,
                        //   _resultsList[index]['username'][lang]
                        // );
                      },
                      // leading: Text(
                      //   _resultsList[index]['username'],
                      // ),
                      title: Text(
                        _resultsList[index]['username'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        _resultsList[index]['city'],
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// showDialogFunc(context, img, name, info, time, date, address, place, category) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return Center(
//         child: Material(
//           type: MaterialType.transparency,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             padding: const EdgeInsets.all(15),
//             height: 320,
//             width: MediaQuery.of(context).size.width * 0.7,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     fontSize: 25,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   AppLocalizations.of(context)?.category ??
//                       "value becomes null" "$category",
//                   style: const TextStyle(
//                     fontSize: 25,
//                     color: Colors.grey,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   // width: 200,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       AppLocalizations.of(context)?.place ??
//                           "value becomes null" " $place - $address",
//                       maxLines: 3,
//                       style: TextStyle(fontSize: 15, color: Colors.grey[500]),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   // width: 200,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       AppLocalizations.of(context)?.description ??
//                           "value becomes null" " $info",
//                       maxLines: 3,
//                       style: TextStyle(fontSize: 15, color: Colors.grey[500]),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   // width: 200,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       " \u{1F4C5}  $date",
//                       maxLines: 3,
//                       style: TextStyle(fontSize: 15, color: Colors.grey[500]),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   // width: 200,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       " \u{1F55C}  $time",
//                       maxLines: 3,
//                       style: TextStyle(fontSize: 15, color: Colors.grey[500]),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
