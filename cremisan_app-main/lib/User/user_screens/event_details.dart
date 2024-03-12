import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_colors.dart';

class EventDetailScreen extends StatefulWidget {
  final imagePath;
  final event_name;
  final place;
  final info;
  final time;
  final address;
  final date;
  final location_url;
  final phoneNo;

  const EventDetailScreen(
      this.imagePath,
      this.event_name,
      this.place,
      this.info,
      this.time,
      this.address,
      this.date,
      this.location_url,
      this.phoneNo,
      {Key? key})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<EventDetailScreen> {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> toggleTextToSpeech(String text) async {
    if (isPlaying) {
      await flutterTts.stop();
    } else {
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///For image and back button and favorate button
            Container(
              child: Stack(
                children: [
                  ///Container for place quick info
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5 + 16,
                        bottom: 20,
                        right: 32,
                        left: 32),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                        ),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event_name,
                          style: GoogleFonts.poppins(
                              color: AppColors.blaskisColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w800),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          "${widget.place} - ${widget.address}",
                          style: GoogleFonts.poppins(
                              color: AppColors.greyishColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          "\u{1F4C5}  ${widget.date}",
                          style: GoogleFonts.poppins(
                              color: AppColors.greyishColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "\u{23F0}  ${widget.time}",
                          style: GoogleFonts.poppins(
                              color: AppColors.greyishColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          "\u{1F4DE}  ${widget.phoneNo}",
                          style: GoogleFonts.poppins(
                              color: AppColors.greyishColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        ///Container for data
                        Container(
                          margin: const EdgeInsets.only(right: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),
                        )
                      ],
                    ),
                  ),

                  ///Hero Image Container
                  Container(
                    child: Hero(
                      tag: 'Bethlehem',
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ClipRRect(
                          child: Image.network(
                            widget.imagePath,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(60),
                            bottomLeft: Radius.circular(60),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///Back button
                  Positioned(
                    top: 40,
                    left: 24,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // ),
                ],
              ),
            ),

            ///Spacing
            const SizedBox(
              height: 24,
            ),

            ///About text
            ///
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      "Activity Description",
                      style: GoogleFonts.poppins(
                          color: AppColors.blueshColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: GestureDetector(
                      onTap: () {
                        toggleTextToSpeech(widget.info);
                      },
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.volume_up,
                        size: 44.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            ///About detail text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                widget.info,
                style: GoogleFonts.poppins(
                    color: AppColors.greyishColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: OutlinedButton(
              onPressed: () {
                // Respond to button press
                openGoogleMaps();
              },
              child: Text(
                "Navigate Location",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff449282)),
              ),
            )),
          ],
        ),
      ),
    );
  }

  final double latitude = 31.7054;
  final double longitude = 35.2024;

  void openGoogleMaps() async {
    final url = widget.location_url;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps';
    }
  }
}
