import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/app_colors.dart';
import '../admin_models/event.dart';
import '../admin_services/event_services.dart';
import 'DashboardAdmin.dart';
import 'add_event.dart';
import 'edit_event.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ListEvent extends StatefulWidget {
  const ListEvent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListEvent();
  }
}

class _ListEvent extends State<ListEvent> {
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
    var data = await FirebaseFirestore.instance.collection('events').get();

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
                  builder: (BuildContext context) => const EventForm(),
                ),
                (route) =>
                    false, 
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
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        // This Will Call When User Click On ListView Item
                        showDialogFunc(
                          context,
                          _resultsList[index]["image"],
                          _resultsList[index]['name'][lang],
                          _resultsList[index]["info"][lang],
                          _resultsList[index]["place"][lang],
                          _resultsList[index]["address"][lang],
                          _resultsList[index]["time"][lang],
                          _resultsList[index]["date"][lang],
                          _resultsList[index]['category'][lang],
                        );
                      },
                      leading:
                          _resultsList[index]["image"] == "assets/empty.png"
                              ? Image.asset(
                                  "assets/empty.png",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  _resultsList[index]["image"].toString(),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                      title: Text(
                        _resultsList[index]['name'][lang],
                      ),
                      subtitle: Row(
                        children: [
                          const SizedBox(
                            height: 13,
                          ),
                          Text(
                            _resultsList[index]['place'][lang],
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // popup menu button

                          PopupMenuButton<int>(
                            itemBuilder: (context) => [
                              // popupmenu item 1
                              PopupMenuItem(
                                value: 1,
                                // row has two child icon and text.
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        // Perform edit action
                                        Navigator.pushAndRemoveUntil<dynamic>(
                                          context,
                                          MaterialPageRoute<dynamic>(
                                            builder: (BuildContext context) =>
                                                EditEvent(
                                              event: Event(
                                                  docId: _resultsList[index].id,
                                                  image: _resultsList[index]
                                                      ['image'],
                                                  location_url: _resultsList[index]
                                                      ['location_url'],
                                                  time: _resultsList[index]
                                                      ['time'],
                                                  date: _resultsList[index]
                                                      ['date'],
                                                  placeEn: _resultsList[index]
                                                      ['place']['en'],
                                                  placeAr: _resultsList[index]
                                                      ['place']['ar'],
                                                  nameEn: _resultsList[index]
                                                      ['name']['en'],
                                                  nameAr: _resultsList[index]
                                                      ['name']['ar'],
                                                  infoEn: _resultsList[index]
                                                      ['info']['en'],
                                                  infoAr: _resultsList[index]
                                                      ['info']['ar'],
                                                  eventCategoryEn:
                                                      _resultsList[index]
                                                          ['event_category']['en'],
                                                  eventCategoryAr: _resultsList[index]['event_category']['ar'],
                                                  addressEn: _resultsList[index]['address']['en'],
                                                  addressAr: _resultsList[index]['address']['ar']),
                                            ),
                                          ),
                                          (route) =>
                                              false, //if you want to disable back feature set to false
                                        );
                                      },
                                    ),
                                    Text(AppLocalizations.of(context)?.edit ??
                                        "value becomes null")
                                  ],
                                ),
                              ),
                              // popupmenu item 2
                              PopupMenuItem(
                                value: 2,
                                // row has two child icon and text
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(AppLocalizations
                                                            .of(context)
                                                        ?.confirmtocompletedeleteprocess ??
                                                    "value becomes null"),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .resolveWith<
                                                                    Color>(
                                                          (Set<MaterialState>
                                                              states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .disabled)) {
                                                              return AppColors
                                                                  .disabledColor; // Color for disabled state
                                                            }
                                                            return AppColors
                                                                .uniformColor; // Default color
                                                          },
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        print(AppLocalizations
                                                                    .of(context)
                                                                ?.confirmtoapplydeletion ??
                                                            "value becomes null");

                                                        var response =
                                                            await FirebaseEvent
                                                                .deleteEvent(
                                                                    docId: _resultsList[
                                                                            index]
                                                                        .id);
                                                        if (response.code !=
                                                            200) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg: response
                                                                .message
                                                                .toString(),
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                          );
                                                        } else {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg: response
                                                                .message
                                                                .toString(),
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                          );

                                                          Navigator.pushAndRemoveUntil<
                                                                  dynamic>(
                                                              context,
                                                              MaterialPageRoute<
                                                                  dynamic>(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    DashboardAdmin(
                                                                        0),
                                                              ),
                                                              (route) =>
                                                                  false); //if you want to disable back feature set to false
                                                        }
                                                      },
                                                      child: Text(AppLocalizations
                                                                  .of(context)
                                                              ?.confirm ??
                                                          "value becomes null"))
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                    Text(AppLocalizations.of(context)?.delete ??
                                        "value becomes null")
                                  ],
                                ),
                              ),
                            ],
                            elevation: 2,
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

showDialogFunc(context, img, name, info, time, date, address, place, category) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(15),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)?.category ??
                      "value becomes null" "$category",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)?.place ??
                          "value becomes null" " $place - $address",
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)?.description ??
                          "value becomes null" " $info",
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      " \u{1F4C5}  $date",
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      " \u{1F55C}  $time",
                      maxLines: 3,
                      style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
