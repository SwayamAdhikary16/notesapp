import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/screens/home.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  addtaskofirebase() async {
    FirebaseFirestore Firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    String uid = user.uid;
    var time = DateTime.now();
    await Firestore.collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': titlecontroller.text,
      'description': descriptioncontroller.text,
      'time': time.toString()
    });
    Fluttertoast.showToast(msg: 'Task Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff001222),
        elevation: 0,
        title: const Text(
          'Add Task',
          style: TextStyle(color: Color(0xff04F6C1)),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: const Color(0xff001222),
        child: Column(
          children: [
            TextField(
              controller: titlecontroller,
              style: const TextStyle(color: Color(0xff16deff), fontSize: 20),
              decoration: InputDecoration(
                label: const Text(
                  'Add Task',
                ),
                labelStyle: const TextStyle(
                  color: Color(0xff04F6C1),
                  fontSize: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xff04F6C1),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff16deff),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: descriptioncontroller,
              style: const TextStyle(color: Color(0xff16deff), fontSize: 20),
              decoration: InputDecoration(
                label: const Text(
                  'Enter Description',
                ),
                labelStyle: const TextStyle(
                  color: Color(0xff04F6C1),
                  fontSize: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color(0xff04F6C1),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff16deff),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                addtaskofirebase();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              style: ButtonStyle(backgroundColor:
                  MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return const Color(0xff16deff);
                }
                return const Color(0xff04f6c1);
              })),
              child: const Text('Add Task',
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
