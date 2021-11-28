import 'package:dio/dio.dart';

import 'Models/student_class.dart';
import 'Models/lesson_object.dart';

const String localhost = 'http://10.0.2.2:1200';

class StudentAPI {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getStudents() async {
    final response = await _dio.get('/getAllStudents');

    return response.data['students'];
  }

  editStudent(String id, String newName) async {
    await _dio.post('/editStudentById', data: {'id': id, 'fname': newName});
  }

  deleteClass(String id) async {
    await _dio.post('/deleteLessonById', data: {'id': id});
  }

  Future<List> getStudent(String query) async {
    final responce = await _dio.post('/findStudent', data: {'query': query});

    return responce.data['students'];
  }

  Future<List> getLessons() async {
    final response = await _dio.get('/getAllLessons');

    return response.data['lessons'];
  }
}
