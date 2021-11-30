const express = require('express');
const app = express();
const nodemon = require('nodemon');
app.use(express.json());

//mongoDB Package
const mongoose = require('mongoose');

const PORT = 1200;

const dbUrl = 'mongodb+srv://Drickikcha:12345@cluster0.iwesf.mongodb.net/Project1?retryWrites=true&w=majority';

mongoose.connect(dbUrl,
    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    })

//Mongo DB Connection

const db = mongoose.connection;

//handle DB Error, display connection

db.on('error', () => {
    console.error.bind(console, 'connection error: ');
});

db.once('open', () => {
    console.log('MongoDB Connected');
});

//Schema/Model Declaration
require('./Models/studentObject');
require('./Models/courseObject');
require('./Models/lessonObject');

const Student = mongoose.model('Student');
const Course = mongoose.model('Course');
const Lesson = mongoose.model('Lesson');

app.get('/', (req, res) => {
    return res.status(200).json("(message: OK)");
});

app.post('/addCourse', async (req, res) => {
    try {
        let course = {
            courseInstructor: req.body.courseInstructor,
            courseCredits: req.body.courseCredits,
            courseID: req.body.courseID,
            courseName: req.body.courseName
        }
        await Course(course).save().then(c => {
            return res.status(201).json("Course Added");
        });
    }
    catch {
        return res.status(400).json("(message: Failed to Add Course - Bad Data)");
    }
});

app.post('/addLesson', async (req, res) => {
    try {
        let lesson = {
            lessonInstructor: req.body.lessonInstructor,
            lessonCredits: req.body.lessonCredits,
            lessonID: req.body.lessonID,
            lessonName: req.body.lessonName
        }
        await Lesson(lesson).save().then(c => {
            return res.status(201).json("lesson Added");
        });
    }
    catch {
        return res.status(400).json({ "message": "Failed to Add Course - Bad Data" });
    }
});

app.get('/getAllCourses', async (req, res) => {
    try {
        let courses = await Course.find({}).lean();
        return res.status(200).json({ "courses": courses });
    }
    catch {
        return res.status(400).json("(message: Failed to Access Course Data)")
    }
});

app.get('/getAllLessons', async (req, res) => {
    try {
        let Lessons = await Lesson.find({}).sort({ lessonName: 1 });
        return res.status(200).json({ "lessons": Lessons });
    }
    catch {
        return res.status(400).json("(message: Failed to Access Course Data)")
    }
});

app.get('/findCourse', async (req, res) => {
    try {
        let query = req.body.courseID;
        let courses = await Course.find({ "courseID": query });
        return res.status(200).json({ "courses": courses });
    }
    catch {
        return res.status(400).json("(message: Failed to Access Course Data)")
    }
});

app.get('/findLesson', async (req, res) => {
    try {
        let query = req.body.lessonID;
        let lessons = await Lesson.find({ "lessonID": query });
        return res.status(200).json({ "lessons": lessons });
    }
    catch {
        return res.status(400).json("(message: Failed to Access Course Data)")
    }
});

app.post('/addStudent', async (req, res) => {
    try {
        let student = {
            fname: req.body.fname,
            lname: req.body.lname,
            studentID: req.body.studentID
        }
        await Student(student).save().then(s => {
            return res.status(201).json("Student Added");
        });
    }
    catch {
        return res.status(400).json("(message: Failed to Add Student - Bad Data)");
    }
});

app.get('/getAllStudents', async (req, res) => {
    try {
        let students = await Student.find({}).lean();
        return res.status(200).json({ "students": students });
    }
    catch {
        return res.status(400).json("(message: Failed to Access Student Data)")
    }
});

app.get('/findStudent', async (req, res) => {
    try {
        let query = req.body.fname;
        let student = await Student.find({ "fname": query });
        return res.status(200).json({ "students": student });
    }
    catch {
        return res.status(400).json("(message: Failed to Access Student Data)")
    }
});

app.post('/findStudentInClass', async (req, res) => {
    try {
        let query = req.body;
        let students = await Student.find({ _id: { $in: [query] } });
        return res.status(200).json({ "students": students });
    }
    catch {
        return res.status(400).json({ "message": "Server Error" });
    }
})

app.post('/editStudentById', async (req, res) => {
    try {
        let student = await Student.updateOne({ _id: req.body.id }, {
            fname: req.body.fname
        }, { upsert: true });

        if (student) {
            return res.status(200).json("(message: Student updated.)");
        } else {
            return res.status(200).json("(message: No student found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to edit student - Bad Data)");
    }
});

app.post('/deleteStudentByName', async (req, res) => {
    try {
        let student = await Student.deleteOne({ fname: req.body.queryFname }, { upsert: true });

        if (student) {
            return res.status(200).json("(message: Student deleted.)");
        } else {
            return res.status(200).json("(message: No student found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to edit student - Bad Data)");
    }
})

app.post('/editStudentByFname', async (req, res) => {
    try {
        let student = await Student.updateOne({ fname: req.body.queryFname }, {
            queryFname: req.body.queryFname,
            fname: req.body.fname,
            lname: req.body.lname
        }, { upsert: true });

        if (student) {
            return res.status(200).json("(message: Student updated.)");
        } else {
            return res.status(200).json("(message: No student found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to edit student - Bad Data)");
    }
});

app.get('/restoreFreddy', async (req, res) => {
    try {
        let student = await Student.updateOne({ _id: "6189974228ea297d0bf4ac04" }, {
            fname: "Freddy",
            lname: "Riemann"
        }, { upsert: true });

        if (student) {
            return res.status(200).json("(message: Freddy is back!)");
        } else {
            return res.status(200).json("(message: No student found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to edit student - Bad Data)");
    }
});

app.post('/editCourseByCourseName', async (req, res) => {
    try {
        let course = await Course.updateOne({ _id: req.body.courseName }, {
            courseInstructor: req.body.instructorName
        }, { upsert: true });

        if (course) {
            return res.status(200).json("(message: Educator updated.)");
        } else {
            return res.status(200).json("(message: No class found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to edit class - Bad Data)");
    }
});

app.post('/editLessonByLessonName', async (req, res) => {
    try {
        let lesson = await Lesson.updateOne({ _id: req.body.lessonName }, {
            LessonInstructor: req.body.instructorName
        }, { upsert: true });

        if (lesson) {
            return res.status(200).json("(message: Educator updated.)");
        } else {
            return res.status(200).json("(message: No class found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to edit class - Bad Data)");
    }
});

app.post('/deleteCourseById', async (req, res) => {
    try {
        let course = await Course.deleteOne({ _id: req.body.id });

        if (course) {
            return res.status(200).json("(message: Course Deleted.)");
        } else {
            return res.status(200).json("(message: Class not found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to delete class - Bad Data)");
    }
});

app.post('/deleteLessonById', async (req, res) => {
    try {
        let lesson = await Lesson.deleteOne({ _id: req.body.id });

        if (lesson) {
            return res.status(200).json("(message: Course Deleted.)");
        } else {
            return res.status(200).json("(message: Class not found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to delete class - Bad Data)");
    }
});


app.post('/addStudentToLessonById', async (req, res) => {
    try {
        let lesson = await Lesson.findByIdAndUpdate(req.body.id, { $push: { "lessonClasslist": { index: req.body.Index, StudentID: req.body.StudentID } } }, { upsert: true });

        if (lesson) {
            return res.status(200).json("(message: Student added.)");
        } else {
            return res.status(200).json("(message: Class not found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to add student - Bad Data)");
    }
});

app.post('/removeStudentFromLessonById', async (req, res) => {
    try {
        let lesson = await Lesson.findByIdAndUpdate(req.body.id, { $pull: { "lessonClasslist": { StudentID: req.body.StudentID } } }, { upsert: true });

        if (lesson) {
            return res.status(200).json("(message: Student added.)");
        } else {
            return res.status(200).json("(message: Class not found");
        }
    }
    catch {
        return res.status(400).json("(message: Failed to add student - Bad Data)");
    }
});


app.listen(PORT, () => {
    console.log(`Server Started on Port ${PORT}`);
});