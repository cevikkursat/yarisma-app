const models = require("../../../../models/index.js");

const changeAccountStatus = async (req, res, next) => {
  const { updateingUserId, accountStatus } = req.body;
  if (!updateingUserId || !accountStatus) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  await models.User.findByIdAndUpdate(updateingUserId, {
    accountStatus: accountStatus,
  });

  res.json({
    success: true,
    message: "Hesap durumu değiştirildi!",
  });
};

module.exports = changeAccountStatus;
