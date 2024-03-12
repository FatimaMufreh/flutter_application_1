import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cremisan_app1/Admin/admin_screens/main_plants.dart';
import 'package:cremisan_app1/Admin/admin_services/plant_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/app_colors.dart';
import '../admin_models/plants.dart';
import '../admin_services/firebase_storage_helper.dart';
import '../admin_services/image_picker_helper.dart';
import 'DashboardAdmin.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class EditPlant extends StatefulWidget {
  final Plant? plant;

  const EditPlant({Key? key, this.plant}) : super(key: key);

  @override
  _EditPlantState createState() => _EditPlantState();
}

class _EditPlantState extends State<EditPlant> {
  final _formKey = GlobalKey<FormState>();
  final _imagePathValue = TextEditingController();
  final _name_en = TextEditingController();
  final _name_ar = TextEditingController();

  final _info_en = TextEditingController();
  final _info_ar = TextEditingController();
  final _plantCategoryEn = TextEditingController();
  final _plantCategoryAr = TextEditingController();
  final _speciesName_en = TextEditingController();
  final _speciesName_ar = TextEditingController();

  final _familyEn = TextEditingController();
  final _familyAr = TextEditingController();
  final _docId = TextEditingController();

  String _imagePath = "";
  String selectedCategoryEn = '';
  String selectedCategoryAr = '';
  late List<DocumentSnapshot> _allResults;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.plant?.image ?? "";
    _docId.value = TextEditingValue(text: widget.plant?.uid ?? "");
    _speciesName_en.value =
        TextEditingValue(text: widget.plant?.en_species_name ?? "");
    _speciesName_ar.value =
        TextEditingValue(text: widget.plant?.ar_species_name ?? "");

    _familyEn.value = TextEditingValue(text: widget.plant?.en_family ?? "");
    _familyAr.value = TextEditingValue(text: widget.plant?.ar_family ?? "");

    _name_en.value = TextEditingValue(text: widget.plant?.en_name ?? "");
    _name_ar.value = TextEditingValue(text: widget.plant?.ar_name ?? "");
    _plantCategoryEn.value =
        TextEditingValue(text: widget.plant?.en_plant_category ?? "");
    _plantCategoryAr.value =
        TextEditingValue(text: widget.plant?.ar_plant_category ?? "");
    _info_en.value = TextEditingValue(text: widget.plant?.en_info ?? "");
    _info_ar.value = TextEditingValue(text: widget.plant?.ar_info ?? "");
    selectedCategoryEn = widget.plant?.en_plant_category ?? "";
    selectedCategoryAr = widget.plant?.ar_plant_category ?? "";
    getData();
  }

  bool isUploading = false;
  String? path;

  Future<void> getData() async {
    var data =
        await FirebaseFirestore.instance.collection('plant_categories').get();

    setState(() {
      _allResults = data.docs;
    });
  }

  void _submitForm() async {
    setState(() {
      isUploading = true;
      _imagePathValue.text = _imagePath;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (path != null) {
        // Upload the image first
        String imageRef =
            await FirebaseStorageHelper.instance.uploadImage(path!, 'plants');

        setState(() {
          _imagePath = imageRef;
        });
      }

      if (_formKey.currentState!.validate()) {
        var response = await FirebasePlant.updatePlant(
          en_name: _name_en.text,
          ar_name: _name_ar.text,
          en_plant_category: selectedCategoryEn,
          ar_plant_category: selectedCategoryAr,
          en_info: _info_en.text,
          ar_info: _info_ar.text,
          image: _imagePath,
          docId: _docId.text,
          en_species_name: _speciesName_en.text,
          ar_species_name: _speciesName_ar.text,
          en_family: _familyEn.text,
          ar_family: _familyAr.text,
        );

        isUploading = false;

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
            AppLocalizations.of(context)?.editplant ?? "value becomes null"),
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
                labelText:
                    AppLocalizations.of(context)?.image ?? "value becomes null",
                initialImage: _imagePath,
                onSaved: (value) {
                  setState(() {
                    path = value!;
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
                controller: _plantCategoryEn,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.category ??
                      "value becomes null",
                ),
                readOnly: true,
                onTap: () => _showCategoryDialog(context),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.pleaseentercategoryname ??
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
                child: isUploading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        AppLocalizations.of(context)?.update ??
                            "value becomes null",
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showCategoryDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)?.select_category ??
                "value becomes null",
          ),
          content: Column(
            children:
                _allResults.map((doc) => _buildCategoryItem(doc)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(DocumentSnapshot doc) {
    String enCategory = doc['name']['en'];
    String arCategory = doc['name']['ar'];

    return ListTile(
      title: Text('$enCategory - $arCategory'),
      onTap: () {
        setState(() {
          selectedCategoryEn = enCategory;
          selectedCategoryAr = arCategory;
          _plantCategoryEn.text = '$enCategory - $arCategory';
        });
        Navigator.pop(context);
      },
    );
  }
}
