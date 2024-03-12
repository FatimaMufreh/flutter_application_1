import 'package:cremisan_app1/Admin/admin_screens/main_plants.dart';
import 'package:cremisan_app1/Admin/admin_services/plant_categories_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/app_colors.dart';
import '../admin_models/category.dart';
import '../admin_services/firebase_storage_helper.dart';
import '../admin_services/image_picker_helper.dart';
import 'DashboardAdmin.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class EditPlantCategory extends StatefulWidget {
  final CategoryModel? category;

  const EditPlantCategory({Key? key, this.category}) : super(key: key);

  @override
  _EditPlantCategoryState createState() => _EditPlantCategoryState();
}

class _EditPlantCategoryState extends State<EditPlantCategory> {
  final _formKey = GlobalKey<FormState>();
  final _imagePathValue = TextEditingController();
  final _en_name = TextEditingController();
  final _ar_name = TextEditingController();

  final _docId = TextEditingController();

  String _imagePath = "";

  @override
  void initState() {
    _imagePath = widget.category!.image.toString();

    _docId.value = TextEditingValue(text: widget.category!.uid.toString());
    _en_name.value =
        TextEditingValue(text: widget.category!.english_name.toString());
    _ar_name.value =
        TextEditingValue(text: widget.category!.arabic_name.toString());
    super.initState();
  }

  bool isUploading = false;
  String? path;

  void _submitForm() async {
    setState(() {
      isUploading = true;
      _imagePathValue.text = _imagePath;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (path != null) {
        // Upload the image first
        String _imageRef = await FirebaseStorageHelper.instance
            .uploadImage(path!, 'plant_categories');

        setState(() {
          _imagePath = _imageRef;
        });
      }

      if (_formKey.currentState!.validate()) {
        var response = await FirebaseCategories.updateCategory(
          docId: _docId.text,
          nameEn: _en_name.text, // Assuming English name
          nameAr: _ar_name.text, // You need to provide Arabic name here
          image: _imagePath,
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
          AppLocalizations.of(context)?.editplantcategory ??
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
                controller: _en_name,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.name_english ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.pleaseenteracategorynameinEnglish ??
                        "value becomes null";
                  }
                  return null;
                },
                onSaved: (value) {
                  // _name = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ar_name,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.name_arabic ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.pleaseenteracategorynameinarabic ??
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
                child: isUploading
                    ? Center(
                        child: CircularProgressIndicator(
                            color: Colors
                                .white) // Display progress indicator if uploading
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
}
