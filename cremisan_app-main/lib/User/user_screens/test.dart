import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image at the top
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  child: Image.asset(
                    'assets/garden2.jpg', // Replace with your image asset
                    width: double.infinity,
                    height: 400.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ],
            ),

            // Separated space
            SizedBox(height: 20.0),

            // Box with circular radius, padding, and spaces between text rows
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(248, 228, 251, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  buildTextRow('English Name', 'Wild Almond'),
                  buildTextRow('Arabic Name', 'اللوز الحلو'),
                  buildTextRow('Family', 'Rosacaea'),
                  buildTextRow('Species Name', 'Amygdalus communis'),
                ],
              ),
            ),

            // Separated space
            SizedBox(height: 10.0),

            // Additional info as Header text and paragraph
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Info',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SignikaNegative'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'It is used for kidney stones, gallstones and constipation. Its oil is used for dry skin conditions.',
                    style: TextStyle(
                        fontSize: 16.0, fontFamily: 'SignikaNegative'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextRow(String leadText, String trailText) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leadText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SignikaNegative',
                  fontSize: 14),
            ),
            Text(trailText),
          ],
        ),
        SizedBox(height: 15.0),
      ],
    );
  }
}
