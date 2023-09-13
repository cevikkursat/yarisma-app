const router = require("express");
const authMiddleware = require("../../../middlewares/auth.js");
const userController = require("../controllers/index.js");

const userRouter = router.Router();

const isAuthenticatedUser = authMiddleware.isAuthenticatedUser;

userRouter.route("/create-event").post(isAuthenticatedUser, userController.createEvent); //? bitti
userRouter.route("/list-events").post(isAuthenticatedUser, userController.listEvent); //? bitti
userRouter.route("/play-event").post(isAuthenticatedUser, userController.playEvent); //? bitti
userRouter.route("/change-name").put(isAuthenticatedUser, userController.changeName); //? bitti
userRouter.route("/change-password").put(isAuthenticatedUser, userController.changePassword); //? bitti
userRouter.route("/change-phone").put(isAuthenticatedUser, userController.changePhone); //? bitti
userRouter.route("/deactive-account").put(isAuthenticatedUser, userController.deactiveAccount); //? bitti
userRouter.route("/get-user-details").post(isAuthenticatedUser, userController.getUserDetails); //? bitti
userRouter.route("/get-user-events").post(isAuthenticatedUser, userController.getUserEvents); //? bitti
userRouter.route("/event-search").post(isAuthenticatedUser, userController.eventSearch); //? bitti
userRouter.route("/get-event-detail").post(isAuthenticatedUser, userController.getEventDetails); //? bitti
userRouter.route("/end-event").post(isAuthenticatedUser, userController.endEvent); //? bitti

module.exports = userRouter;
