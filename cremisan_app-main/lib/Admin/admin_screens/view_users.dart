import 'package:cremisan_app1/Admin/admin_screens/list_users.dart';
import 'package:flutter/material.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ViewUsers extends StatefulWidget {
  const ViewUsers({Key? key}) : super(key: key);

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
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
                AppLocalizations.of(context)?.view_users ??
                    "value becomes null",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ListUsers()));
  }
}
