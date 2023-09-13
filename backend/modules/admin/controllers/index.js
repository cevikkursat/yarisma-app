const changeEventStatus = require("./event/changeEventStatus.js");
const changeAccountRole = require("./user/changeAccountRole.js");
const changeAccountStatus = require("./user/changeAccountStatus.js");
const userSearch = require("./user/userSearch.js");
const searchEvent = require("./event/searchEvent.js");

const adminController = {};

adminController.changeEventStatus = changeEventStatus;
adminController.changeAccountRole = changeAccountRole;
adminController.changeAccountStatus = changeAccountStatus;
adminController.userSearch = userSearch;
adminController.searchEvent = searchEvent;

module.exports = adminController;
