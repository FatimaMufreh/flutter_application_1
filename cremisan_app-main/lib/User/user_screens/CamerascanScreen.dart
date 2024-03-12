import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import 'MainDrawer.dart';
import 'ProfilePage.dart';

class Qrscan extends StatefulWidget {
  Qrscan({Key? key});
  Locale? initialValue;
  @override
  State<Qrscan> createState() => _QrscanState();
}

class _QrscanState extends State<Qrscan> {
  String _scanBarcodeResult = '';
  bool _showLinkButton = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 200,
              child: Image.asset(
                "assets/qr.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 70),
            Text(
              AppLocalizations.of(context)?.scan ?? "value becomes null",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => scanQR(true), // Scan from camera
              child: Text(
                AppLocalizations.of(context)?.qr ?? "value becomes null",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(13, 71, 161, 1),
              ),
            ),
            SizedBox(height: 20),
            if (_showLinkButton)
              ElevatedButton(
                onPressed: () => launchURL(_scanBarcodeResult),
                child: Text(
                  AppLocalizations.of(context)?.open ?? "value becomes null",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(13, 71, 161, 1),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQR(bool fromCamera) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR,
      );

      if (!mounted) return; // Avoid setState() called after dispose()

      setState(() {
        _scanBarcodeResult = barcodeScanRes;
        _showLinkButton = true; // Set the flag to show the link button
      });
    } on PlatformException {
      setState(() {
        _scanBarcodeResult = "Failed to get platform version";
        _showLinkButton = false; // Set the flag to hide the link button
      });
    }
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      setState(() {
        _showLinkButton =
            false; // Remove the link button after opening the link
      });
    } else {
      throw 'Could not launch $url';
    }
  }
}
