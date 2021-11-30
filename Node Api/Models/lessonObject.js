const { json } = require('express');
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const Lesson = new Schema({
    lessonInstructor: {
        type: String,
        required: true
    },

    lessonCredits:
    {
        type: Number,
        required: true
    },

    lessonID:
    {
        type: String,
        required: true
    },

    lessonName:
    {
        type: String,
        required: true
    },

    lessonEntered:
    {
        type: Date,
        default: Date.now
    },

    lessonClasslist:
    {
        type: [{ index: Number, StudentID: String }],
        default: null,
        _id: false
    }
});

mongoose.model('Lesson', Lesson);