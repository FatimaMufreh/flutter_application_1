import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cremisan_app1/Admin/admin_screens/main_animals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import '../../utils/app_colors.dart';
import '../admin_models/category.dart';
import '../admin_services/animal_services.dart';
import '../admin_services/firebase_storage_helper.dart';
import '../admin_services/image_picker_helper.dart';
import 'DashboardAdmin.dart';

class AnimalForm extends StatefulWidget {
  const AnimalForm({Key? key}) : super(key: key);

  @override
  _AnimalFormState createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  final _formKey = GlobalKey<FormState>();
  final _imagePathValue = TextEditingController();
  final _nameEn = TextEditingController();
  final _nameAr = TextEditingController();
  final _infoEn = TextEditingController();
  final _infoAr = TextEditingController();

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
        await firestore.collection('animal_categories').get();

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

      var response = await FirebaseAnimal.addAnimal(
        nameEn: _nameEn.text,
        nameAr: _nameAr.text,
        infoEn: _infoEn.text,
        infoAr: _infoAr.text,
        image: _imagePathValue.text,
        animalCategoryEn: selectedCategoryEn,
        animalCategoryAr: selectedCategoryAr,
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
            builder: (BuildContext context) => DashboardAdmin(1),
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
          AppLocalizations.of(context)?.add_animal ?? "value becomes null",
        ),
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
                initialImage: '',
                labelText:
                    AppLocalizations.of(context)?.image ?? "value becomes null",
                onSaved: (value) async {
                  String path = value!;
                  String imageRef = await FirebaseStorageHelper.instance
                      .uploadImage(path, 'animals');
                  setState(() {
                    _imagePath = imageRef;
                    isUploaded = true;
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
