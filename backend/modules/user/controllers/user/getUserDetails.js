const models = require("../../../../models/index.js");
const getUserDetails = async (req, res, next) => {
  let user;
  const { id } = req.body;
  if (!id) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  user = await models.User.findOne({ _id: id });
  res.json({
    success: true,
    username: user.username,
    fName: user.fName,
    lName: user.lName,
    phone: user.phone,
    email: user.email,
    earnedAwards: user.earnedAwards,
    accountStatus: user.accountStatus,
    role: user.role,
    eventsCount: user.eventsCount,
    message: "User Bilgileri Getirildi!",
  });
};

module.exports = getUserDetails;
