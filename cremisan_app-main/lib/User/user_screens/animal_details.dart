import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AnimalDetails extends StatefulWidget {
  final String name;
  final String imagePath;
  final String info;
  final String category_name;

  AnimalDetails(
    this.name,
    this.imagePath,
    this.info,
    this.category_name,
  );
  @override
  _AnimalDetailscreenState createState() => _AnimalDetailscreenState();
}

class _AnimalDetailscreenState extends State<AnimalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageSlider(),
            _buildDetailsInfo(context),
            _buildExpandableContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildImageSlider() {
    return Stack(
      children: [
        Hero(
          tag: 'Animal Image',
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: ClipRRect(
              child: Image.network(
                "${widget.imagePath}",
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(60),
                bottomLeft: Radius.circular(60),
              ),
            ),
          ),
        ),
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
      ],
    );
  }

  Widget _buildDetailsInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Card(
        // elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.name}",
                style: TextStyle(
                  fontFamily: "VT323",
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${widget.category_name}",
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label + ':',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableContent() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SignikaNegative',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${widget.info}",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SignikaNegative',
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
