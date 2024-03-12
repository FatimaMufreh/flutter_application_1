import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Animals Cremisan',
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0C9869),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(
              context,
              Icons.agriculture_outlined,
              'Orange',
              () => print('hello'),
            ),
            SizedBox(height: 20),
            buildButton(
              context,
              Icons.cut,
              'Melon',
              () => print('hello'),
            ),
            SizedBox(height: 20),
            buildButton(
              context,
              Icons.alarm,
              'Lemon',
              () => print('hello'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture_outlined),
            label: 'Potato',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cut),
            label: 'Tomato',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Dates',
          ),
        ],
        selectedItemColor: Color(0xFF0C9869),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget buildButton(BuildContext context, IconData icon, String label,
      VoidCallback onPressed) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 50.0,
        ),
        label: Text(
          label,
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
