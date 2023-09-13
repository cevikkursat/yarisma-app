const models = require("../../../../models/index.js");
const getUserEvents = async (req, res, next) => {
  const { id, username } = req.body;
  if (!username && !id) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  let user;
  if (!username) {
    user = await models.User.findById(id);
  } else {
    user = await models.User.findOne({ username: username });
  }
  let userEvents = await models.Event.find({ owner: user._id });
  res.json({
    success: true,
    userEvents: userEvents,
    username: user.username,
    message: "User Eventleri Getirildi!",
  });
};

module.exports = getUserEvents;
