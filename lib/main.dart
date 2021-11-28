// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_app/remove_student.dart';
import 'api.dart';

import 'edit_student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Page',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MyHomePage(title: 'Student Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final StudentAPI api = StudentAPI();
  String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _dbLoaded = false;
  bool _Students = false;
  bool _Delete = false;
  String _DeleteID = "";
  List Students = [];
  List Lessons = [];

  void initState() {
    super.initState();
    widget.api.getStudents().then((data) {
      setState(() {
        Students = data;
        _dbLoaded = true;
      });
    });

    widget.api.getLessons().then((data) {
      setState(() => {Lessons = data});
      //print(Lessons);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _dbLoaded
            ? _Students
                ? Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            ...Students.map<Widget>(
                              (Student) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditStudent(
                                              Student['_id'],
                                              Student['fname'],
                                              Student['lname'],
                                              Student['studentID']),
                                        ))
                                  },
                                  child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        child: Text(Student['studentID']),
                                      ),
                                      title: Text(
                                        (Student['fname'] +
                                            ' ' +
                                            Student['lname']),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                          child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(15.0),
                        children: [
                          ...Lessons.map<Widget>(
                            (Lesson) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                onDoubleTap: () => {
                                  if (_Delete)
                                    {_Delete = false}
                                  else
                                    {_Delete = true},
                                  _DeleteID = Lesson['_id'],
                                  (context as Element).reassemble()
                                },
                                child: Card(
                                  color: Colors.grey[400],
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: SizedBox(
                                            width: 60,
                                            child: Text(
                                              Lesson['lessonID'],
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          title: Text(Lesson['lessonName']),
                                          subtitle: Text("Taught by " +
                                              Lesson['lessonInstructor']),
                                          trailing: Text(Lesson['lessonCredits']
                                                  .toString() +
                                              " Credits"),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Visibility(
                                              visible: (_Delete &&
                                                  _DeleteID == Lesson['_id']),
                                              child: TextButton(
                                                  child: Text("Delete Class"),
                                                  onPressed: () => {
                                                        Navigator.pop(context),
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => RemoveStudent(
                                                                  Lesson['_id'],
                                                                  Lesson[
                                                                      'lessonInstructor'],
                                                                  Lesson[
                                                                      'lessonCredits'],
                                                                  Lesson[
                                                                      'lessonID'],
                                                                  Lesson[
                                                                      'lessonName'],
                                                                  Lesson[
                                                                      'lessonClasslist']),
                                                            ))
                                                      }),
                                            )
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                    ],
                  )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text("Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  CircularProgressIndicator()
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_Students ? Icons.arrow_forward : Icons.arrow_back),
        onPressed: () => {
          if (_Students == true)
            {_Students = false, widget.title = "Class List"}
          else
            {_Students = true, widget.title = "Student Page"},
          _DeleteID = "",
          (context as Element).reassemble()
        },
      ),
    );
  }
}
