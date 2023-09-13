const models = require("../../../../models/index.js");

const userSearch = async (req, res, next) => {
  const { username } = req.body;
  if (!username) {
    return res.json({
      success: false,
      message: "User Bulunamadı!",
    });
  }
  let user = await models.User.find({ username: username });
  if (user.length < 1) {
    return res.json({
      success: false,
      message: "User Bulunamadı!",
    });
  }
  res.json({
    success: true,
    user: user,
    message: "Bulunan User Getirildi!",
  });
};

module.exports = userSearch;
