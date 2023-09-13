const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const ObjectID = mongoose.Schema.Types.ObjectID;

const correctionsSchema = new Schema(
  {
    _id: ObjectID,
    userID: { type: String, ref: "User", required: true },
    correctionsCode: String,
  },
  { versionKey: false }
);
const correction = mongoose.model("correction", correctionsSchema);

module.exports = correction;
