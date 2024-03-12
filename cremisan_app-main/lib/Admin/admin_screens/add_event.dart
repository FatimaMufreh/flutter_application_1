import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/app_colors.dart';
import '../admin_services/event_services.dart';
import '../admin_services/firebase_storage_helper.dart';
import '../admin_services/image_picker_helper.dart';
import 'DashboardAdmin.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class EventForm extends StatefulWidget {
  const EventForm({Key? key}) : super(key: key);

  @override
  _EventFormState createState() => _EventFormState();
}

DateTime date = DateTime(2022, 12, 24);

class _EventFormState extends State<EventForm> {
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
  final _phoneController = TextEditingController();

  String _imagePath = "assets/empty.png";

  String selectedCategoryEn = '';
  String selectedCategoryAr = '';
  String selectedCategoryKey = 'edu'; // Set an initial value
  bool isUploaded = false;
  Map<String, Map<String, String>> _categories = {
    'edu': {'en': 'Educational', 'ar': 'تعليمي'},
    'env': {'en': 'Environmental', 'ar': 'بيئي'},
    'relg': {'en': 'Religious', 'ar': 'ديني'},
    'recr': {'en': 'Recreational', 'ar': 'ترفيهي'},
  };
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      // await loadJson();
    });
    // getData();
    super.initState();
  }

  void _submitForm() async {
    _imagePathController.text = _imagePath;
    if (_formKey.currentState!.validate() && isUploaded) {
      _formKey.currentState!.save();

      if (_formKey.currentState!.validate()) {
        var response = await FirebaseEvent.addEvent(
          nameEn: _nameEnController.text,
          nameAr: _nameArController.text,
          infoEn: _infoEnController.text,
          infoAr: _infoArController.text,
          image: _imagePathController.text,
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
        elevation: 0.0,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            AppLocalizations.of(context)?.add_an_event ?? "value becomes null",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => DashboardAdmin(0),
              ),
              (route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back),
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
                      .uploadImage(path, 'events');
                  print(_imageRef);
                  _imagePath = _imageRef;
                  setState(() {
                    isUploaded = true;
                  });
                },
              ),
              TextFormField(
                controller: _nameEnController,
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context)?.event_name_english ??
                            "value becomes null"),
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
                    labelText:
                        AppLocalizations.of(context)?.event_name_arabic ??
                            "value becomes null"),
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
                hint: Text(AppLocalizations.of(context)?.select_category ??
                    "value becomes null"),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategoryKey = newValue!;
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
                            "value becomes null"),
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
                        "value becomes null"),
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
                        "value becomes null"),
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
                    labelText: AppLocalizations.of(context)
                            ?.detailed_address_english ??
                        "value becomes null"),
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
                            "value becomes null"),
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
                        "value becomes null"),
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
                        "value becomes null"),
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
                        "value becomes null"),
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
                child: isUploaded
                    ? Text(AppLocalizations.of(context)?.submit ??
                        "value becomes null")
                    : CircularProgressIndicator(
                        color: Colors.white,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
