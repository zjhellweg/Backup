import 'package:flutter/material.dart';
import 'package:test_app/api.dart';
import 'api.dart';
import 'main.dart';

class EditStudent extends StatefulWidget {
  final String id, fname, lname, studentID;

  final StudentAPI api = StudentAPI();

  EditStudent(this.id, this.fname, this.lname, this.studentID);

  @override
  _EditStudentState createState() =>
      _EditStudentState(id, fname, lname, studentID);
}

class _EditStudentState extends State<EditStudent> {
  final String id, fname, lname, studentID;
  final StudentAPI api = StudentAPI();

  _EditStudentState(this.id, this.fname, this.lname, this.studentID);

  TextEditingController Name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change " + fname + "'s Name "),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: Name,
            ),
            ElevatedButton(
                onPressed: () => {
                      api.editStudent(id, Name.text),
                      Navigator.pop(context),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: "Student Page"),
                        ),
                      ),
                    },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Change Name",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home_max_sharp),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: "Class List"),
            ),
          ),
        },
      ),
    );
  }
}
