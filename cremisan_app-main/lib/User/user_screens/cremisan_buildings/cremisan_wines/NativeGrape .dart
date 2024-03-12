import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_view/photo_view.dart';

class NativeGrape extends StatefulWidget {
  const NativeGrape({Key? key}) : super(key: key);

  @override
  State<NativeGrape> createState() => _NativeGrapeState();
}

class _NativeGrapeState extends State<NativeGrape> {
  late List<Map<String, dynamic>> sampleEvents;

  @override
  void initState() {
    super.initState();
    // Initialize sampleEvents here if the data is dynamic and comes from an external source.
    // For static data, it's better to initialize it in the build method or another function where context is available.
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sampleEvents = [
      {
        'name': AppLocalizations.of(context)?.baladi ?? "value becomes null",
        'image': "assets/baladi.png",
      },
      {
        'name': AppLocalizations.of(context)?.rose ?? "value becomes null",
        'image': "assets/rose.png",
      },
      {
        'name': AppLocalizations.of(context)?.hamdani ?? "value becomes null",
        'image': "assets/testt.png",
      },
      {
        'name': AppLocalizations.of(context)?.dabouki ?? "value becomes null",
        'image': "assets/dabouki.png",
      },
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: sampleEvents.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LargeImagePage(
                            imageUrl: sampleEvents[index]['image'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.asset(
                              sampleEvents[index]['image'],
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              sampleEvents[index]['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LargeImagePage extends StatelessWidget {
  final String imageUrl;

  const LargeImagePage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Replace with your desired color
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: AssetImage(imageUrl),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          enableRotation: true,
        ),
      ),
    );
  }
}
