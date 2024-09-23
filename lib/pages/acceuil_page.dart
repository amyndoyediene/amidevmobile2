import 'package:flutter/material.dart';

class accueuilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Action pour la météo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage()),
                );
              },
              child: Text('Météo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action pour les news
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage()),
                );
              },
              child: Text('News'),
            ),
          ],
        ),
      ),
    );
  }
}

// Créez des pages vides pour WeatherPage et NewsPage pour l'instant
class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Météo')),
      body: Center(child: Text('Informations météo')),
    );
  }
}

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: Center(child: Text('Informations de News')),
    );
  }
}
