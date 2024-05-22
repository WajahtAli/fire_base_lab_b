import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_lab_b/student_screen.dart';
import 'package:firebase_lab_b/toast_messages.dart';
import 'package:firebase_lab_b/update_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController rollNo = TextEditingController();
  TextEditingController search = TextEditingController();

  File? _image;

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _image = File(selectedImage.path);
      });
    }
  }

  Future<void> pickImageFromCam() async {
    ImagePicker imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      setState(() {
        _image = File(selectedImage.path);
      });
      await uploadImageToFireBase();
    }
  }

  Future uploadImageToFireBase() async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await storageRef.putFile(_image!);
    final downloadUrl = await storageRef.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text('Home Screen'),
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
                  hintText: 'Enter your roll No',
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
                  if (name.text.isNotEmpty && rollNo.text.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('student')
                        .doc()
                        .set({  
                      "name": name.text,
                      "rollNo": rollNo.text,
                    }).then((value) {
                      WarningHelper.showSuccesToast(
                          "Successfully Submit", context);
                    });
                  } else {
                    return WarningHelper.showErrorToast(
                        'Fill All fields', context);
                  }
                },
                child: const Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: const Text('Pick image'),
              ),
              _image != null
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                      child: Stack(
                        children: [
                          CircleAvatar(
                              radius: 50, backgroundImage: FileImage(_image!)),
                          Positioned(
                              bottom: 0,
                              top: 60,
                              right: 0,
                              left: 60,
                              child: InkWell(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: const Icon(Icons.edit))),
                        ],
                      ),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: 0,
                              top: 60,
                              right: 0,
                              left: 60,
                              child: InkWell(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: const Icon(Icons.edit))),
                        ],
                      ),
                    ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentScreen()));
                },
                child: const Text('Student Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
