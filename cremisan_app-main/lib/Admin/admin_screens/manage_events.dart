import 'package:flutter/material.dart';

import 'ListEvent.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
// import 'DashboardScreen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  final int _page = 0;

  int pageIndex = 0;
  Locale? initialValue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            extendBody: true,
            backgroundColor: const Color.fromARGB(235, 255, 255, 255),
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                AppLocalizations.of(context)?.activitiesdashboard ??
                    "value becomes null",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ListEvent()));
  }
}
