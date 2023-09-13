const models = require("../../../../models/index.js");

const getDetails = async (req, res, next) => {
  const { eventID } = req.body;
  if (!eventID) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  let event = await models.Event.findById(eventID);
  if (!event) {
    return res.json({
      success: false,
      message: "Yarışma Bulunamadı!",
    });
  }
  let user = await models.User.findById(event.owner);

  if (!event.isActive) {
    return res.json({
      success: false,
      message: "Yarışma Aktif Değil!",
    });
  }

  res.json({
    success: true,
    event: event,
    username: user.username,
    message: "Bulunan Yarışma Getirildi!",
  });
};

module.exports = getDetails;
