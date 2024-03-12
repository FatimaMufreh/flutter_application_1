import 'package:cremisan_app1/Admin/admin_services/firebase_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/app_colors.dart';
import '../admin_models/event.dart';
import '../admin_services/event_services.dart';
import '../admin_services/image_picker_helper.dart';
import 'DashboardAdmin.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class EditEvent extends StatefulWidget {
  final Event? event;

  const EditEvent({Key? key, this.event}) : super(key: key);

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _formKey = GlobalKey<FormState>();
  final _imagePathController = TextEditingController();
  final _nameEnController = TextEditingController();
  final _nameArController = TextEditingController();
  final _infoEnController = TextEditingController();
  final _infoArController = TextEditingController();
  final _placeEnController = TextEditingController();
  final _placeArController = TextEditingController();
  final _addressEnController = TextEditingController();
  final _addressArController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationUrlController = TextEditingController();
  final _docIdController = TextEditingController();
  final _categoryController = TextEditingController();
  final _phoneController = TextEditingController();

  String _imagePath = "";
  String selectedCategoryKey = 'edu'; // Set an initial value
  String selectedCategoryEn = '';
  String selectedCategoryAr = '';
  Map<String, Map<String, String>> _categories = {
    'edu': {'en': 'Educational', 'ar': 'تعليمي'},
    'env': {'en': 'Envionmental', 'ar': 'بيئي'},
    'relg': {'en': 'Releigious', 'ar': 'ديني'},
    'recr': {'en': 'Recreational', 'ar': 'ترفيهي'},
  };

  @override
  void initState() {
    _imagePath = widget.event!.image.toString();
    _docIdController.text = widget.event!.docId.toString();
    _nameEnController.text = widget.event!.nameEn.toString();
    _nameArController.text = widget.event!.nameAr.toString();
    _infoEnController.text = widget.event!.infoEn.toString();
    _infoArController.text = widget.event!.infoAr.toString();
    _placeEnController.text = widget.event!.placeEn.toString();
    _placeArController.text = widget.event!.placeAr.toString();
    _addressEnController.text = widget.event!.addressEn.toString();
    _addressArController.text = widget.event!.addressAr.toString();
    _dateController.text = widget.event!.date.toString();
    _timeController.text = widget.event!.time.toString();
    _locationUrlController.text = widget.event!.location_url.toString();
    _phoneController.text = widget.event!.phoneNo.toString();
    selectedCategoryEn = widget.event!.eventCategoryEn.toString();
    selectedCategoryAr = widget.event!.eventCategoryAr.toString();
  }

  bool isUploading = false;
  String? path;

  void _submitForm() async {
    setState(() {
      isUploading = true;
      _imagePathController.text = _imagePath;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (path != null) {
        // Upload the image first
        String _imageRef =
            await FirebaseStorageHelper.instance.uploadImage(path!, 'events');

        setState(() {
          _imagePath = _imageRef;
        });
      }
      if (_formKey.currentState!.validate()) {
        var response = await FirebaseEvent.updateEvent(
          nameEn: _nameEnController.text,
          nameAr: _nameArController.text,
          infoEn: _infoEnController.text,
          infoAr: _infoArController.text,
          image: _imagePath,
          eventCategoryEn: selectedCategoryEn,
          eventCategoryAr: selectedCategoryAr,
          placeEn: _placeEnController.text,
          placeAr: _placeArController.text,
          addressEn: _addressEnController.text,
          addressAr: _addressArController.text,
          date: _dateController.text,
          time: _timeController.text,
          location_url: _locationUrlController.text,
          phoneNo: _phoneController.text,
          docId: _docIdController.text,
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
              builder: (BuildContext context) => DashboardAdmin(0),
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
        centerTitle: true,
        backgroundColor: AppColors.uniformColor,
        title: Text(
            AppLocalizations.of(context)?.editactivity ?? "value becomes null"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => DashboardAdmin(0),
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
                initialImage: _imagePath,
                labelText:
                    AppLocalizations.of(context)?.image ?? "value becomes null",
                onSaved: (value) async {
                  setState(() {
                    path = value!;
                  });
                },
              ),
              TextFormField(
                controller: _nameEnController,
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
                controller: _nameArController,
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
                value: selectedCategoryKey,
                hint: Text(
                  AppLocalizations.of(context)?.select_category ??
                      "value becomes null",
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategoryEn =
                        _categories[selectedCategoryKey]!['en']!;
                    selectedCategoryAr =
                        _categories[selectedCategoryKey]!['ar']!;
                  });
                },
                items: _categories.keys.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_categories[item]!['en']!), // English value
                        Text(_categories[item]!['ar']!), // Arabic value
                      ],
                    ),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _infoEnController,
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
                controller: _infoArController,
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)?.description_arabic ??
                            "value becomes null"),
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
                controller: _placeEnController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.place_english ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_place_arabic ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _placeArController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.place_arabic ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_place_arabic ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressEnController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context)?.detailed_address_english ??
                          "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_detailed_address_english ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressArController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context)?.detailed_address_arabic ??
                          "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_detailed_address_arabic ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.date ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_event_date ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.time ??
                        "value becomes null"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_event_time ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.phoneNumber ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)?.pleaseEnterPhone ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationUrlController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)?.location_url ??
                      "value becomes null",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)
                            ?.please_enter_url_location ??
                        "value becomes null";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.uniformColor,
                ),
                onPressed: _submitForm,
                child: isUploading
                    ? Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 182, 231,
                                253)) // Display progress indicator if uploading
                        )
                    : Text(AppLocalizations.of(context)?.update ??
                        "value becomes null"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
