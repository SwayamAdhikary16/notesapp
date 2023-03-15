import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String title, description;

  const Description(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff001222),
      ),
      body: Container(
        color: const Color(0xff001222),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 3, 159, 125)),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: 500,
              width: 350,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 3, 159, 125),
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  description,
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
