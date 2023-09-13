const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const ObjectID = mongoose.Schema.Types.ObjectID;

const eventSchema = new Schema(
  {
    _id: ObjectID,
    owner: { type: ObjectID, ref: "User", required: true },
    isActive: { type: Boolean, default: true },
    eventFinishDate: Date,
    eventName: String,
    award: String,
    awardCount: Number,
    contestants: {
      type: [
        {
          username: { type: String, ref: "User", required: true },
          correctCount: Number,
          falseCount: Number,
          score: Number,
        },
      ],
      default: [],
    },
    questions: [
      {
        question: String,
        answerOne: String,
        answerTwo: String,
        answerThree: String,
        answerFour: String,
        trueAnswer: String,
      },
    ],
  },
  { versionKey: false, timestamps: true }
);
const event = mongoose.model("event", eventSchema);

module.exports = event;
