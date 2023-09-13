const models = require("../../../models/index.js");
const jwt = require("jsonwebtoken");

const activeAccount = async (req, res, next) => {
  const { correctionsCode, username } = req.body;
  if (!correctionsCode || !username) {
    return res.json({
      success: false,
      message: "Doğrulama Başarısız!",
    });
  }
  const code = await models.Auth.findOne({ userID: username });
  const user = await models.User.findOne({ username: username });
  if (code.correctionsCode !== correctionsCode) {
    return res.json({
      success: false,
      message: "Doğrulama Başarısız!",
    });
  } else {
    await models.Auth.findOneAndDelete({ userID: username });
    user.accountStatus = "active";
    user.save();
    const token = jwt.sign({ id: user._id, role: user.role }, process.env.SECRET_KEY);
    res.json({
      success: true,
      message: "Giriş Başarılı!",
      accountStatus: user.accountStatus,
      token: token,
    });
  }
};

module.exports = activeAccount;
