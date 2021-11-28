import 'dart:convert';
import 'lesson_students.dart';

class Lesson {
  final String id;
  final String lessonInstructor;
  final int lessonCredits;
  final String lessonId;
  final String lessonName;
  final List<String> lessonClassList;

  Lesson._(this.id, this.lessonInstructor, this.lessonCredits, this.lessonId,
      this.lessonName, this.lessonClassList);

  factory Lesson.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId("', '').replaceAll('"', '');
    final lessonInstructor = json['lessonInstructor'];
    final lessonCredits = int.parse(json['lessonCredits']);
    final lessonId = json['lessonID'];
    final lessonName = json['lessonName'];
    final lessonClassList = jsonDecode(json['lessonClasslist']);

    return Lesson._(id, lessonInstructor, lessonCredits, lessonId, lessonName,
        lessonClassList);
  }
}
