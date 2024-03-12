import 'package:cremisan_app1/Admin/admin_services/animal_categories_services.dart';
import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../admin_services/firebase_storage_helper.dart';
import '../admin_services/image_picker_helper.dart';
import 'DashboardAdmin.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class AddAnimalCategory extends StatefulWidget {
  const AddAnimalCategory({Key? key}) : super(key: key);

  @override
  _AddAnimalCategoryState createState() => _AddAnimalCategoryState();
}

class _AddAnimalCategoryState extends State<AddAnimalCategory> {
  final _formKey = GlobalKey<FormState>();
  final _imagePathValue = TextEditingController();
  final _en_name = TextEditingController();
  final _ar_name = TextEditingController();

  String _imagePath = "assets/empty.png";

  void _submitForm() async {
    _imagePathValue.text = _imagePath;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_formKey.currentState!.validate()) {
        var response = await FirebaseAnimalCategories.addCategory(
          nameEn: _en_name.text, // Assuming English name
          nameAr: _ar_name.text, // You need to provide Arabic name here
          image: _imagePathValue.text,
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
          AppLocalizations.of(context)?.add_animal_category ??
              "value becomes null",
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
              (route) => false, //To disable back feature set to false
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
                  String _imageRef = await FirebaseStorageHelper.instance
                      .uploadImage(path, 'animal_categories');
                  print(_imageRef);
                  print(' test -----');
                  _imagePath = _imageRef;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _en_name,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.english_name ??
                      "value becomes null",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_category_name ??
                        "value becomes null";
                  }
                  return null;
                },
                onSaved: (value) {
                  // _name = value;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _ar_name,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.name_arabic ??
                      "value becomes null",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_category_name ??
                        "value becomes null";
                  }
                  return null;
                },
                onSaved: (value) {
                  // _name = value;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return AppColors
                            .disabledColor; // Color for disabled state
                      }
                      return AppColors.uniformColor; // Default color
                    },
                  ),
                ),
                onPressed: _submitForm,
                child: Text(AppLocalizations.of(context)?.submit ??
                    "value becomes null"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
