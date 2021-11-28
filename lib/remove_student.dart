import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_app/api.dart';
import 'api.dart';
import 'main.dart';

class RemoveStudent extends StatefulWidget {
  final String id, lessonInstructor, lessonId, lessonName;
  final List lessonClassList;
  final int lessonCredits;

  final StudentAPI api = StudentAPI();

  RemoveStudent(this.id, this.lessonInstructor, this.lessonCredits,
      this.lessonId, this.lessonName, this.lessonClassList);

  @override
  _RemoveStudentState createState() => _RemoveStudentState(id, lessonInstructor,
      lessonCredits, lessonId, lessonName, lessonClassList);
}

class _RemoveStudentState extends State<RemoveStudent> {
  final String id, lessonInstructor, lessonId, lessonName;
  final List lessonClassList;
  final int lessonCredits;
  final StudentAPI api = StudentAPI();

  _RemoveStudentState(this.id, this.lessonInstructor, this.lessonCredits,
      this.lessonId, this.lessonName, this.lessonClassList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("These are the students of \n" +
            lessonName +
            ", click them to remove them."),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: OutlinedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                onPressed: () => {
                  api.deleteClass(id),
                  Navigator.pop(context),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: "Student Page")))
                },
                child: SizedBox(
                  height: 260,
                  width: 300,
                  child: Text(
                    "Delete Class",
                    style: TextStyle(color: Colors.white, fontSize: 100),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home_max_rounded),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: "Student Page")),
          ),
        },
      ),
    );
  }
}
