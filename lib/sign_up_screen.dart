import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_lab_b/home_screen.dart';
import 'package:firebase_lab_b/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Sign up'),
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
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: email.text.trim(), password: password.text.trim())
                  .then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen())))
                  .onError((error, stackTrace) {
                print('hello $error');
              });
            },
            child: const Text('Sign up'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account'),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
