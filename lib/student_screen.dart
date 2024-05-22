import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_lab_b/update_screen.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('student').get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Map<String, dynamic>>> snap =
                    snapshot.data!.docs;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      var student = snap[index];
                      return Dismissible(
                        key: Key(student.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (data) async {
                          await FirebaseFirestore.instance
                              .collection('student')
                              .doc(student.id)
                              .delete();
                        },
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(student['name']),
                          subtitle: Text(student['rollNo']),
                          trailing: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateScreen(docId: student.id)));
                              },
                              child: const Icon(Icons.edit)),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
