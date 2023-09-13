const models = require("../../../../models/index.js");

const changeAccountRole = async (req, res, next) => {
  const { updateingUserId, role } = req.body;
  if (!updateingUserId || !role) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  await models.User.findByIdAndUpdate(updateingUserId, {
    role: role,
  });

  res.json({
    success: true,
    message: "Hesap rolü değiştirildi!",
  });
};

module.exports = changeAccountRole;
