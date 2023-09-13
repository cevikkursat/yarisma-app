const adminModule = require("./modules/admin/index.js");
const authModule = require("./modules/auth/index.js");
const userModule = require("./modules/user/index.js");

const initModules = (app) => {
  adminModule.init(app);
  authModule.init(app);
  userModule.init(app);
};

module.exports = initModules;
