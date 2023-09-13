const Event = require("./event/yarisma.js");
const Auth = require("./user/auth.js");
const User = require("./user/user.js");

const models = {};

models.Event = Event;
models.Auth = Auth;
models.User = User;

module.exports = models;
