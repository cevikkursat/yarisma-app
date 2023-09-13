const router = require("express");
const authMiddleware = require("../../../middlewares/auth.js");
const adminController = require("../controllers/index.js");

const isAuthenticatedUser = authMiddleware.isAuthenticatedUser;

const adminRouter = router.Router();

adminRouter.route("/change-event-status").post(isAuthenticatedUser, adminController.changeEventStatus); //? bitti
adminRouter.route("/admin-event-search").post(isAuthenticatedUser, adminController.searchEvent); //? bitti
adminRouter.route("/change-account-role").post(isAuthenticatedUser, adminController.changeAccountRole); //? bitti
adminRouter.route("/change-account-stattus").post(isAuthenticatedUser, adminController.changeAccountStatus); //? bitti
adminRouter.route("/admin-user-search").post(isAuthenticatedUser, adminController.userSearch); //? bitti

module.exports = adminRouter;
