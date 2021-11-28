class Student {
  final String id;
  final String fname;
  final String lname;
  final String studentId;

  Student._(this.id, this.fname, this.lname, this.studentId);

  factory Student.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId("', '').replaceAll('"', '');
    final fname = json['fname'];
    final lname = json['lname'];
    final studentId = json['studentId'];

    return Student._(id, fname, lname, studentId);
  }
}
