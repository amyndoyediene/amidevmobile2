import 'package:amimobile2/services/api_service.dart';
import 'package:amimobile2/services/shared_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter+NodeJS+JWT'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              SharedService.logout(context);
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: userProfile(),
    );
  }

  Widget userProfile() {
    return FutureBuilder(
      future: APIService.getUserProfile(),
      builder: (
        BuildContext context,
        AsyncSnapshot<String> model,
      ) {
        if (model.hasData) {
          return Center(child: Text(model.data!));
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}