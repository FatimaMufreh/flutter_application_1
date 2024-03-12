import 'package:cremisan_app1/Admin/admin_screens/DashboardAdmin.dart';
import 'package:cremisan_app1/Admin/admin_screens/list_plant_categories.dart';
import 'package:cremisan_app1/Admin/admin_screens/list_plants.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class MainPlants extends StatefulWidget {
  const MainPlants({Key? key}) : super(key: key);

  @override
  State<MainPlants> createState() => _MainPlantsState();
}

class _MainPlantsState extends State<MainPlants> {
  @override
  final int _page = 0;

  int pageIndex = 0;
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBody: true,
          backgroundColor: const Color.fromARGB(235, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)?.plantdashboard ??
                  "value becomes null",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: AppColors.uniformColor,
              indicatorColor: AppColors.uniformColor,
              tabs: [
                Tab(
                  text: AppLocalizations.of(context)?.plants ??
                      "value becomes null",
                ),
                Tab(
                  text: AppLocalizations.of(context)?.category ??
                      "value becomes null",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [ListPlants(), ListPlantCategories()],
          ),
        ));
  }
}
