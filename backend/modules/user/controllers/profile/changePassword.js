const bcrypt = require("bcrypt");
const models = require("../../../../models/index.js");
const changePassword = async (req, res, next) => {
  const { id, password } = req.body;
  if (!password) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  const pass = await bcrypt.hash(password, 16);
  await models.User.findByIdAndUpdate(id, {
    password: pass,
  });
  res.json({
    success: true,
    message: "Şifre Başarıyla Sıfırlandı!",
  });
};

module.exports = changePassword;
