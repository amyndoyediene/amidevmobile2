import 'package:amimobile2/pages/detail_articles.dart';
import 'package:amimobile2/pages/welcome_Page.dart';
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
                  MaterialPageRoute(builder: (context) => articlePage()),
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
                  MaterialPageRoute(builder: (context) =>  const DetailArticles()),
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
class articlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Météo')),
      body: Center(child: Text('Informations météo et')),
    );
  }
}

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: Center(child: Text('Informations de News et')),
    );
  }
}
