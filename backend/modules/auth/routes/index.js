const router = require("express");
const authController = require("../controllers/index.js");

const authRouter = router.Router();

authRouter.route("/login").post(authController.login); //? bitti
authRouter.route("/activeAccount").post(authController.activeAccount); //? bitti
authRouter.route("/register").post(authController.register); //? bitti
authRouter.route("/reset-password").post(authController.resetPassword); //? bitti

module.exports = authRouter;
