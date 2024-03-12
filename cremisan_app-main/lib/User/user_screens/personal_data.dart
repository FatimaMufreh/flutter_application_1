import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:intl/intl.dart';

class UserInformationPage extends StatefulWidget {
  @override
  _UserInformationPageState createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  Map<String, dynamic> userData = {};
  bool isEditingUsername = false;
  TextEditingController usernameController = TextEditingController();
  bool isEditingcity = false;
  bool isEditingPhoneNumber = false;
  TextEditingController cityController = TextEditingController();
  DateTime? selectedDate;
  bool isEditingBirthday = false;
  TextEditingController BirthdayController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference userDoc = firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      setState(() {
        userData = docSnapshot.data() as Map<String, dynamic>;
      });
    }
  }

  void editBirthday() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        final formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
        setState(() {
          isEditingUsername = false;
          selectedDate = pickedDate;
          updateUserData({'birhday': formattedDate});
        });
      }
    });
  }

  void saveBirthday() {
    final selectedDate =
        DateFormat('dd-MM-yyyy').parse(BirthdayController.text);
    final birthdayTimestamp = Timestamp.fromDate(selectedDate);

    setState(() {
      isEditingBirthday = false;
      userData['birthday'] = birthdayTimestamp;
      updateUserData({'birthday': birthdayTimestamp});
    });
  }

  void editUsername() {
    setState(() {
      isEditingUsername = true;
      usernameController.text = userData['username'];
    });
  }

  void saveUsername() {
    setState(() {
      isEditingUsername = false;
      userData['username'] = usernameController.text;
      updateUserData({'username': userData['username']});
    });
  }

  void editcity() {
    setState(() {
      isEditingcity = true;
      cityController.text = userData['city'];
    });
  }

  void editphoneNumber() {
    setState(() {
      isEditingPhoneNumber = true;
      phoneNumberController.text = userData['phoneNumber'];
    });
  }

  void savePhoneNumber() {
    setState(() {
      isEditingPhoneNumber = false;
      userData['phoneNumber'] = phoneNumberController.text;
      updateUserData({'phoneNumber': userData['phoneNumber']});
    });
  }

  void savecity() {
    setState(() {
      isEditingcity = false;
      userData['city'] = cityController.text;
      updateUserData({'city': userData['city']});
    });
  }

  void updateUserData(Map<String, dynamic> data) {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    userDoc.update(data);
  }

  String selectedLanguage = 'English'; // Default language
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            (AppLocalizations.of(context)?.userManagment ??
                    "value becomes null") +
                "       ",
          ),
        ),
        backgroundColor: AppColors.darkblueColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      AppLocalizations.of(context)?.email ??
                          "value becomes null",
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Container(
                      padding: EdgeInsets.only(
                          top: 8.0), // Adjust the value to control the spacing
                      child: Text(
                        userData['email'] ?? 'Loading...',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.lock_rounded),
                      onPressed: showlockMessage,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.username ??
                              "value becomes null",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                    subtitle: isEditingUsername
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                            ?.editusername ??
                                        "value becomes null",
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: saveUsername,
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors
                                      .darkblueColor, // Set the button color
                                  onPrimary: Colors.white, // Set the text color
                                ),
                                child: Text(
                                  AppLocalizations.of(context)?.save ??
                                      "value becomes null",
                                ),
                              ),
                            ],
                          )
                        : Text(
                            userData['username'] ?? 'Loading...',
                            style: TextStyle(fontSize: 17),
                          ),
                    trailing: isEditingUsername
                        ? SizedBox.shrink() // Hide the edit icon while editing
                        : IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: editUsername,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.location ??
                              "value becomes null",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                    subtitle: isEditingcity
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: cityController,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                            ?.editlocation ??
                                        "value becomes null",
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: savecity,
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors
                                      .darkblueColor, // Set the button color
                                  onPrimary: Colors.white, // Set the text color
                                ),
                                child: Text(
                                  AppLocalizations.of(context)?.save ??
                                      "value becomes null",
                                ),
                              ),
                            ],
                          )
                        : Text(
                            userData['city'] ?? 'Loading...',
                            style: TextStyle(fontSize: 18),
                          ),
                    trailing: isEditingcity
                        ? SizedBox.shrink()
                        : IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: editcity,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.phoneNumber ??
                              "value becomes null",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                    subtitle: isEditingPhoneNumber
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                            ?.editphonenumber ??
                                        "value becomes null",
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: savePhoneNumber,
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors
                                      .darkblueColor, // Set the button color
                                  onPrimary: Colors.white, // Set the text color
                                ),
                                child: Text(
                                  AppLocalizations.of(context)?.save ??
                                      "value becomes null",
                                ),
                              ),
                            ],
                          )
                        : Text(
                            userData['phoneNumber'] ?? 'Loading...',
                            style: TextStyle(fontSize: 18),
                          ),
                    trailing: isEditingPhoneNumber
                        ? SizedBox.shrink()
                        : IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: editphoneNumber,
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.birthday ??
                              "value becomes null",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                    subtitle: isEditingBirthday
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: BirthdayController,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                            ?.editbirthday ??
                                        "value becomes null",
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            userData['birhday'] ?? 'Loading...',
                            style: TextStyle(fontSize: 18),
                          ),
                    trailing: isEditingBirthday
                        ? SizedBox.shrink()
                        : IconButton(
                            icon: Icon(Icons.calendar_month),
                            onPressed: editBirthday,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showlockMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)?.sorryyoucannotedittheEmail ??
              "value becomes null",
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
