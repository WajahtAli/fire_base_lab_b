import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {
  final String? docId;
  const UpdateScreen({required this.docId, super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final rollNo = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Update your Data '),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: name,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: rollNo,
            decoration: const InputDecoration(
              hintText: 'Enter your rollNo',
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
              FirebaseFirestore.instance
                  .collection('student')
                  .doc(docId)
                  .update({"name": name.text, "rollNo": rollNo.text});
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
