import 'package:cremisan_app1/User/user_screens/DashboardScreen.dart';
import 'package:cremisan_app1/User/user_screens/personal_data.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:cremisan_app1/auth/login.dart';
import 'dart:io';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import '../user_widgets/custom_drop_down.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imageFile;
  Locale? initialValue;

  Map<String, dynamic> userData = {};
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    _imageFile = null; // Initialize as null
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    isloading = true;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference userDoc = firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      setState(() {
        userData = docSnapshot.data() as Map<String, dynamic>;
        isloading = false;
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
      await _uploadImageToFirebaseStorage(image.path);
    }
  }

  Future<void> _getImageFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
      await _uploadImageToFirebaseStorage(image.path);
    }
  }

  Future<void> _uploadImageToFirebaseStorage(String imagePath) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('profile_image.jpg');

    await storageReference.putFile(File(imagePath));

    final imageUrl = await storageReference.getDownloadURL();
    saveProfileImage(imageUrl);
  }

  void saveProfileImage(String imageUrl) {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    userDoc.update({
      'profile_image_url': imageUrl,
    });
  }

  Future<void> removePhoto() async {
    if (userData != null && userData['profile_image_url'] != null) {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child('profile_image.jpg');

      try {
        await storageReference.delete();
      } catch (e) {
        print("Error deleting image: $e");
      }

      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      try {
        await userDoc.update({
          'profile_image_url': null,
        });

        setState(() {
          userData['profile_image_url'] = null;
        });
      } catch (e) {
        print("Error updating user document: $e");
      }
    }
  }

  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          AppLocalizations.of(context)?.profile ?? "value becomes null",
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)
                          ?.areYousuredoyouwanttologout ??
                      "value becomes null"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        logout(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)?.yes ??
                            "value becomes null",
                        style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(13, 71, 161, 1)),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: Text(
                        AppLocalizations.of(context)?.cancel ??
                            "value becomes null",
                        style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(13, 71, 161, 1)),
                      ),
                    )
                  ],
                ),
              );
            },
            icon: Icon(Icons.power_settings_new,
                color: Colors.black // Adjust the opacity value (0.0 to 1.0)
                ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: isloading
            ? Center(
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Remove the Container and use CircleAvatar directly
                      CircleAvatar(
                        radius: screenWidth / 5, // Adjust the radius as needed
                        backgroundImage: _imageFile != null
                            ? FileImage(File(_imageFile!.path))
                            : (userData != null &&
                                    userData['profile_image_url'] != null &&
                                    userData['profile_image_url'] is String
                                ? NetworkImage(userData['profile_image_url']!)
                                : AssetImage("assets/profile2.jpg")
                                    as ImageProvider<Object>),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          width: 45,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.7),
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      title: Text(
                                        AppLocalizations.of(context)
                                                ?.chooseanimagesource ??
                                            "value becomes null",
                                      ),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _getImageFromCamera();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                    ?.takephoto ??
                                                "value becomes null",
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _getImageFromGallery();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                    ?.selectfromgallery ??
                                                "value becomes null",
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            removePhoto();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)
                                                    ?.removeyourphoto ??
                                                "value becomes null",
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.camera_alt,
                                size: 25,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 2.0,
                                  color: const Color.fromRGBO(97, 97, 97, 1),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomCard(
                                    Icons.person,
                                    AppLocalizations.of(context)?.username ??
                                        'value becomes null',
                                    userData['username']),
                                CustomCard(
                                    Icons.email,
                                    AppLocalizations.of(context)?.email ??
                                        'value becomes null',
                                    userData['email']),
                                CustomCard(
                                    Icons.location_city,
                                    AppLocalizations.of(context)?.location ??
                                        'value becomes null',
                                    userData['city']),
                                CustomCard(
                                    Icons.phone,
                                    AppLocalizations.of(context)?.phoneNumber ??
                                        'value becomes null',
                                    userData['phoneNumber']),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black12,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return UserInformationPage();
                              }),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                AppColors.darkblueColor, // Set the button color
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  (AppLocalizations.of(context)
                                          ?.userManagment ??
                                      "value becomes null"),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white, // Set the text color
                                  ),
                                ),
                                Spacer(), // Add spacing between text and button
                                Icon(
                                  Icons.chevron_right,
                                  size: 40.0,
                                  color: Colors.white, // Set the icon color
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
      ),
    );
  }

  CustomDropDownWidget buildAccountOptionRow1(
      BuildContext context, String title) {
    String selectedLanguage = 'English'; // Default language
    final provider = Provider.of<LocaleProvider>(context);

    return CustomDropDownWidget(provider: provider);
  }

  void logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  CustomCard(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              color: AppColors.darkblueColor, // Set the icon color
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(fontSize: 18),
            ),
            tileColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
