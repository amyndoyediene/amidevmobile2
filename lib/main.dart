import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'services/shared_service.dart';
import 'pages/success_page.dart';
import 'pages/acceuil_page.dart';
import 'pages/welcome_page.dart';

Widget _defaultHome = const LoginPage(
  username: '',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get result of the login function.
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const HomePage();
  }
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class Firebase {
  static initializeApp() {}
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
      // routes: {
      //   // '/': (context) => _defaultHome,
      //   // '/home': (context) => const HomePage(),
      //   '/welcome': (context) => const WelcomePage(),
      //   '/acceuil': (context) => accueuilPage(),
      //   '/login': (context) => const LoginPage(
      //         username: '',
      //       ),
      //   '/register': (context) => const RegisterPage(),
      //   '/success': (context) => const SuccessPage(
      //         username: 'ami',
      //       )
      // },
    );
  }
}
