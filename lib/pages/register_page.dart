import 'package:flutter/material.dart';
import 'package:amimobile2/models/register_request_model.dart';
import 'package:amimobile2/services/api_service.dart';
import 'success_page.dart'; // Import de la SuccessPage

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Ajoute FF pour l'opacité
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;

  const ProgressHUD({
    required this.child,
    required this.inAsyncCall,
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (inAsyncCall)
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (inAsyncCall) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? password;
  String? confirmPassword;
  String? email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            const Center(
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Champ de nom d'utilisateur
            TextFormField(
              decoration: InputDecoration(
                hintText: "Username",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSaved: (input) => userName = input,
              validator: (input) =>
                  input!.isEmpty ? "Username cannot be empty" : null,
            ),
            const SizedBox(height: 20),

            // Champ d'e-mail
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSaved: (input) => email = input,
              validator: (input) =>
                  !input!.contains("@") ? "Email is not valid" : null,
            ),
            const SizedBox(height: 20),

            // Champ de mot de passe
            TextFormField(
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),
              onSaved: (input) => password = input,
              validator: (input) => input!.length < 4
                  ? "Password must be at least 4 characters"
                  : null,
            ),
            const SizedBox(height: 20),

            // Champ de confirmation de mot de passe
            TextFormField(
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSaved: (input) => confirmPassword = input,
              validator: (input) =>
                  input != password ? "Passwords do not match" : null,
            ),
            const SizedBox(height: 30),

            // Bouton d'inscription
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("283B71"),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                    });

                    RegisterRequestModel model = RegisterRequestModel(
                      username: userName!,
                      password: password!,
                      email: email!,
                    );

                    APIService.register(model).then((response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response.data != null) {
                        // Redirection vers la page SuccessPage après inscription
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessPage(
                              username: userName!,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Error"),
                            content: Text(response.message),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  }
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  bool _validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
