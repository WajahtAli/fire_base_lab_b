import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_lab_b/home_screen.dart';
import 'package:firebase_lab_b/toast_messages.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Login '),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: email,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: password,
            obscureText: isObsecure,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
                child: isObsecure == true
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.enhanced_encryption_outlined),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: email.text.trim(), password: password.text.trim())
                  .then((value) {
                WarningHelper.showSuccesToast('Successfully Login', context);
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()))
                    .onError((error, stackTrace) {
                  print("hello $error");
                });
              });
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
