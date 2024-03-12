import 'package:cremisan_app1/User/user_screens/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/l10n.dart';
import '../../provider/locale_provider.dart';

class CustomDropDownWidget extends StatelessWidget {
  const CustomDropDownWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final LocaleProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: DropdownButtonFormField<Locale>(
        iconEnabledColor: Colors.white,
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Language',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: (selectedLanguage) {
          if (selectedLanguage != null) {
            provider.setLocale(selectedLanguage);
            // _navigateToDashboard(context);
          }
        },
        value: provider.locale ?? const Locale("en"),
        items: L10n.all.map<DropdownMenuItem<Locale>>((value) {
          return DropdownMenuItem<Locale>(
            value: value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.languageCode,
                  // '${value.languageCode == 'en' ? 'English' : 'Arabic'} - ${value.toString()}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ),
    );
  }
}
