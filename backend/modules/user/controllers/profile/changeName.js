const models = require("../../../../models/index.js");
const changeName = async (req, res, next) => {
  const { id, fName, lName } = req.body;
  if (!fName || !lName) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  await models.User.findByIdAndUpdate(id, {
    fName: fName,
    lName: lName,
  });
  res.json({
    success: true,
    message: "İsim Güncellendi!",
  });
};

module.exports = changeName;
