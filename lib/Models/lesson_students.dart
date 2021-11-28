import 'package:test_app/Models/lesson_object.dart';

class LessonStudents {
  String studentId;

  LessonStudents(this.studentId);

  factory LessonStudents.fromJson(dynamic json) {
    return LessonStudents(json['StudentID'] as String);
  }

  @override
  String toString() {
    print('{${this.studentId}}');
    return '{${this.studentId}}';
  }
}
