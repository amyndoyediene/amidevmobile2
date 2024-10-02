import 'package:flutter/material.dart';
import 'package:amimobile2/models/article_model.dart';
class DetailArticles extends StatefulWidget {
  const DetailArticles({super.key});

  @override
  State<DetailArticles> createState() => _DetailArticlesState();
}

class _DetailArticlesState extends State<DetailArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details articles"),
      ),
      // fgf
      //ggg
      body: Center(
        child: Text('Bienvenu dans votre news '),
      ),
    );
  }
}
