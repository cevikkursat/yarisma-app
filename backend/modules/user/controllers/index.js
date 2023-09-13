const createEvent = require("./event/createEvent.js");
const listEvent = require("./event/listEvent.js");
const playEvent = require("./event/playEvent.js");
const changeName = require("./profile/changeName.js");
const changePassword = require("./profile/changePassword.js");
const changePhone = require("./profile/changePhone.js");
const deactiveAccount = require("./profile/deactiveAccount.js");
const getUserDetails = require("./user/getUserDetails.js");
const getUserEvents = require("./user/getUserEvents.js");
const eventSearch = require("./event/eventSearch.js");
const getEventDetails = require("./event/getEventDetails.js");
const endEvent = require("./event/endEvent.js");

const userController = {};

userController.createEvent = createEvent;
userController.listEvent = listEvent;
userController.playEvent = playEvent;
userController.changeName = changeName;
userController.changePassword = changePassword;
userController.changePhone = changePhone;
userController.deactiveAccount = deactiveAccount;
userController.getUserDetails = getUserDetails;
userController.getUserEvents = getUserEvents;
userController.eventSearch = eventSearch;
userController.getEventDetails = getEventDetails;
userController.endEvent = endEvent;

module.exports = userController;
