const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const ObjectID = mongoose.Schema.Types.ObjectID;

const userSchema = new Schema(
  {
    _id: ObjectID,
    username: String,
    fName: String,
    lName: String,
    phone: String,
    email: String,
    earnedAwards: { type: Array, default: [] },
    password: String,
    accountStatus: { type: String, enum: ["active", "inactive", "deactivated", "banned"], default: "inactive" },
    role: { type: String, enum: ["user", "admin"], default: "user" },
    events: { type: Array, default: [] },
  },
  { versionKey: false, timestamps: true }
);

const user = mongoose.model("user", userSchema);

module.exports = user;
