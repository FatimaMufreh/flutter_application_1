import 'package:cremisan_app1/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'cremisan_wines/HouseWines.dart';
import 'cremisan_wines/Liqueurs.dart';
import 'cremisan_wines/NativeGrape .dart';
import 'cremisan_wines/Non-alcoholic.dart';
import 'cremisan_wines/ReservedWines.dart';
import 'cremisan_wines/SuperAlcohol.dart';
import 'package:provider/provider.dart';

import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class WineParts extends StatefulWidget {
  const WineParts({Key? key}) : super(key: key);

  @override
  _WinePartsState createState() => _WinePartsState();
}

class _WinePartsState extends State<WineParts> {
  int selectedIndex = 0; // Keep track of the selected button index
 Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
           
            title:  Text(    AppLocalizations.of(context)?.wineProducts ??
                                  "value becomes null",),
            centerTitle: true, // Center align the title
            backgroundColor: AppColors.darkblueColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Navigate back or perform any action needed
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PageButtons(
            selectedIndex: selectedIndex,
            onButtonTapped: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                HouseWines(), // Replace with the actual pages
                NativeGrape(),
                ReservedWines(),
                SuperAlcohol(),
                Liqueurs(),
                Nonalcoholic()
                // Add other pages here
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageButtons extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onButtonTapped;

  const PageButtons({
    Key? key,
    required this.selectedIndex,
    required this.onButtonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> buttonTitles = [
         AppLocalizations.of(context)?.housewines ?? "value becomes null",
      AppLocalizations.of(context)?.nativegrape ?? "value becomes null",
      AppLocalizations.of(context)?.reservedwines ?? "value becomes null",
     AppLocalizations.of(context)?.superalcohol ?? "value becomes null",
     AppLocalizations.of(context)?.liqueurs ?? "value becomes null",
    AppLocalizations.of(context)?.nonalcohol ?? "value becomes null",
    ];

    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => onButtonTapped(index),
            child: Container(
              width: 150, // Increased width to accommodate longer text
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColors.darkblueColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  buttonTitles[index], // Display the longer titles
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  maxLines: 1, // Limit to 2 lines to prevent overflow
                  overflow: TextOverflow.ellipsis, // Show ellipsis for overflow
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}