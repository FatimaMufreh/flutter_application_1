import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cremisan_app1/Admin/admin_screens/main_animals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/app_colors.dart';
import '../admin_models/animals.dart';
import '../admin_services/animal_services.dart';
import '../admin_services/firebase_storage_helper.dart';
import '../admin_services/image_picker_helper.dart';
import 'DashboardAdmin.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class EditAnimal extends StatefulWidget {
  final Animal? animal;

  const EditAnimal({Key? key, this.animal}) : super(key: key);

  @override
  _EditAnimalState createState() => _EditAnimalState();
}

class _EditAnimalState extends State<EditAnimal> {
  final _formKey = GlobalKey<FormState>();
  final _imagePathValue = TextEditingController();
  final _nameEn = TextEditingController();
  final _nameAr = TextEditingController();
  final _animalCategoryEn = TextEditingController();
  final _animalCategoryAr = TextEditingController();
  final _infoEn = TextEditingController();
  final _infoAr = TextEditingController();
  final _docId = TextEditingController();

  String _imagePath = "";
  String selectedCategoryEn = '';
  String selectedCategoryAr = '';
  late List<DocumentSnapshot> _allResults;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.animal?.image ?? "";
    _docId.value = TextEditingValue(text: widget.animal?.uid ?? "");
    _nameEn.value = TextEditingValue(text: widget.animal?.en_name ?? "");
    _nameAr.value = TextEditingValue(text: widget.animal?.ar_name ?? "");
    _animalCategoryEn.value =
        TextEditingValue(text: widget.animal?.en_animal_category ?? "");
    _animalCategoryAr.value =
        TextEditingValue(text: widget.animal?.ar_animal_category ?? "");
    _infoEn.value = TextEditingValue(text: widget.animal?.en_info ?? "");
    _infoAr.value = TextEditingValue(text: widget.animal?.ar_info ?? "");
    selectedCategoryEn = widget.animal?.en_animal_category ?? "";
    selectedCategoryAr = widget.animal?.ar_animal_category ?? "";
    getData();
  }

  bool isUploading = false;
  String? path;

  Future<void> getData() async {
    var data =
        await FirebaseFirestore.instance.collection('animal_categories').get();

    setState(() {
      _allResults = data.docs;
    });

    // Optionally, filter and process the data further
    // searchResultsList();
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
            await FirebaseStorageHelper.instance.uploadImage(path!, 'animals');

        setState(() {
          _imagePath = imageRef;
        });
      }

      if (_formKey.currentState!.validate()) {
        var response = await FirebaseAnimal.updateAnimal(
          nameEn: _nameEn.text,
          nameAr: _nameAr.text,
          animalCategoryEn: selectedCategoryEn,
          animalCategoryAr: selectedCategoryAr,
          infoEn: _infoEn.text,
          infoAr: _infoAr.text,
          image: _imagePath,
          docId: _docId.text,
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
              builder: (BuildContext context) => DashboardAdmin(1),
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
            AppLocalizations.of(context)?.editanimal ?? "value becomes null"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => DashboardAdmin(1),
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
                controller: _nameEn,
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
                controller: _nameAr,
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
                controller: _animalCategoryEn,
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
                controller: _infoEn,
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
                controller: _infoAr,
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
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: isUploading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 198, 224, 236),
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
          _animalCategoryEn.text = '$enCategory - $arCategory';
        });
        Navigator.pop(context);
      },
    );
  }
}

final _imagePathValue = TextEditingController();

final _speciesName_en = TextEditingController();
final _speciesName_ar = TextEditingController();

final _commonEngName = TextEditingController();
final _commonArName = TextEditingController();
final _familyEn = TextEditingController();
final _familyAr = TextEditingController();
final _docId = TextEditingController();
