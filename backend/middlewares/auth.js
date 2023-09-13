const models = require("../models/index.js");

const authMiddleware = {};

authMiddleware.isAuthenticatedUser = async (req, res, next) => {
  const id = req.body.id;
  let user = await models.User.findOne({ _id: id });
  if (!user) {
    return res.json({
      success: false,
      message: "İşlem Başarısız!",
    });
  }
  if (user.accountStatus !== "active") {
    return res.json({
      success: false,
      accountStatus: req.user.accountStatus,
      message: "Hesap Aktif Değil!",
    });
  }
  next();
};

module.exports = authMiddleware;
