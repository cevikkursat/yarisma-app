const login = require("./login.js");
const register = require("./register.js");
const resetPassword = require("./resetPassword.js");
const activeAccount = require("./activeAccount.js");

const authController = {};

authController.login = login;
authController.activeAccount = activeAccount;
authController.register = register;
authController.resetPassword = resetPassword;

module.exports = authController;
