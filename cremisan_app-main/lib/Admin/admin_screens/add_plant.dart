import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cremisan_app1/Admin/admin_screens/DashboardAdmin.dart';
import 'package:cremisan_app1/Admin/admin_screens/main_plants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/app_colors.dart';
import '../admin_models/category.dart';
import '../admin_services/firebase_storage_helper.dart';
import '../admin_services/image_picker_helper.dart';
import '../admin_services/plant_services.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class PlantForm extends StatefulWidget {
  const PlantForm({Key? key}) : super(key: key);

  @override
  _PlantFormState createState() => _PlantFormState();
}

class _PlantFormState extends State<PlantForm> {
  final _formKey = GlobalKey<FormState>();
  final _imagePathValue = TextEditingController();
  final _name_en = TextEditingController();
  final _name_ar = TextEditingController();

  final _info_en = TextEditingController();
  final _info_ar = TextEditingController();

  final _speciesName_en = TextEditingController();
  final _speciesName_ar = TextEditingController();

  final _commonEngName = TextEditingController();
  final _commonArName = TextEditingController();
  final _familyEn = TextEditingController();
  final _familyAr = TextEditingController();

  String selectedCategoryId = '';
  List<CategoryModel> _categories = [];
  String selectedCategoryEn = '';
  String selectedCategoryAr = '';

  String _imagePath = "assets/empty.png";
  bool isUploaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection('plant_categories').get();

    setState(() {
      _categories = querySnapshot.docs.map((doc) {
        return CategoryModel(
          uid: doc.id,
          arabic_name: doc['name']['ar'],
          english_name: doc['name']['en'],
          image: doc['image'],
        );
      }).toList();
      selectedCategoryId = _categories.isNotEmpty ? _categories[0].uid! : '';
      selectedCategoryEn =
          _categories.isNotEmpty ? _categories[0].english_name! : '';
      selectedCategoryAr =
          _categories.isNotEmpty ? _categories[0].arabic_name! : '';
    });
  }

  void _submitForm() async {
    _imagePathValue.text = _imagePath;
    if (_formKey.currentState!.validate() && isUploaded) {
      _formKey.currentState!.save();

      var response = await FirebasePlant.addPlant(
        image: _imagePathValue.text,
        en_name: _name_en.text,
        ar_name: _name_ar.text,
        en_info: _info_en.text,
        ar_info: _info_ar.text,
        en_plant_category: selectedCategoryEn,
        ar_plant_category: selectedCategoryAr,
        en_species_name: _speciesName_en.text,
        ar_species_name: _speciesName_ar.text,
        en_family: _familyEn.text,
        ar_family: _familyAr.text,
      );

      if (response.code != 200) {
        Fluttertoast.showToast(
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => DashboardAdmin(2),
          ),
          (route) => false,
        );
      }
    }
  }

  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.uniformColor,
        centerTitle: true,
        title: Text(
            AppLocalizations.of(context)?.add_plant ?? "value becomes null"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => DashboardAdmin(2),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ImagePickerFormField(
                initialImage: '',
                labelText:
                    AppLocalizations.of(context)?.image ?? "value becomes null",
                onSaved: (value) async {
                  String path = value!;
                  String imageRef = await FirebaseStorageHelper.instance
                      .uploadImage(path, 'plants');
                  setState(() {
                    _imagePath = imageRef;
                    isUploaded = true;
                  });
                },
              ),
              TextFormField(
                controller: _name_en,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.name_english ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_english_name ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _name_ar,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.name_arabic ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_name_arabic ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _info_en,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context)?.description_english ??
                          "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_description_english ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _info_ar,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.description_arabic ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_description_arabic ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedCategoryId,
                hint: Text(
                  AppLocalizations.of(context)?.select_category ??
                      "value becomes null",
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategoryId = newValue!;
                    final selectedCategory = _categories
                        .firstWhere((category) => category.uid == newValue);
                    selectedCategoryEn = selectedCategory.english_name!;
                    selectedCategoryAr = selectedCategory.arabic_name!;
                  });
                },
                items: _categories.map((CategoryModel category) {
                  return DropdownMenuItem<String>(
                    value: category.uid,
                    child: Text(
                        '${category.english_name!} / ${category.arabic_name!}'),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _speciesName_en,
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)?.speciesnameenglish ??
                            "value becomes null"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.pleaseenteraspeciesnameinenglish ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _speciesName_ar,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.speciesnamearabic ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)?.king ??
                        "value becomes null";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _familyEn,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.family_english ??
                        "value becomes null"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.pleaseenterfamily_english ??
                        "value becomes null";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _familyAr,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.family_arabic ??
                        "value becomes null"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.pleaseenterfamily_arabic ??
                        "value becomes null";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: isUploaded
                    ? Text(AppLocalizations.of(context)?.submit ??
                        "value becomes null")
                    : CircularProgressIndicator(
                        color: Colors.white,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
