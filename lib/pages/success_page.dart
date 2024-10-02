import 'package:flutter/material.dart';
import 'login_page.dart'; // Import de la page de connexion ou une autre page si nécessaire

class SuccessPage extends StatelessWidget {
  final String username;

  const SuccessPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Success"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome, $username!",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your registration was successful.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),

              // Bouton pour rediriger vers la page de connexion
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Redirection vers la page de connexion ou la page d'accueil
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage(
                              username: '',
                            )), // Remplacez LoginPage par la page que vous souhaitez
                    (route) => false, // Supprime toutes les routes précédentes
                  );
                },
                child: const Text(
                  "Go to Login",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
