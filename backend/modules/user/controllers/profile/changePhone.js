const models = require("../../../../models/index.js");
const changePhone = async (req, res, next) => {
  const { id, phone } = req.body;
  if (!phone) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  await models.User.findByIdAndUpdate(id, {
    phone: phone,
  });
  res.json({
    success: true,
    message: "Telefon Başarıyla Değiştirildi!",
  });
};

module.exports = changePhone;
