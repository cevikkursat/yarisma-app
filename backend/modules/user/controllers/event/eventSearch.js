const models = require("../../../../models/index.js");

const eventSearch = async (req, res, next) => {
  const { eventName } = req.body;
  if (!eventName) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  let event = await models.Event.find({ eventName: eventName });
  if (event.length < 1) {
    return res.json({
      success: false,
      message: "Yarışma Bulunamadı!",
    });
  }
  let user = await models.User.findById(event[0].owner);

  if (!event[0].isActive) {
    return res.json({
      success: false,
      message: "Yarışma Aktif Değil!",
    });
  }

  res.json({
    success: true,
    event: event[0],
    username: user.username,
    message: "Bulunan Yarışma Getirildi!",
  });
};
module.exports = eventSearch;
