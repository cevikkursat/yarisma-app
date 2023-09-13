const models = require("../../../../models/index.js");

const playEvent = async (req, res, next) => {
  const { id, eventID } = req.body;
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

  let user = await models.User.findById(id);
  if (event.owner.toString() === user._id.toString()) {
    return res.json({
      success: false,
      message: "Yarışma düzenlenen tarafından oynanamaz!",
    });
  }

  let eventKatilanlar = event.contestants;
  let oynanabilirMi = true;
  for (let i = 0; i < eventKatilanlar.length; i++) {
    const element = eventKatilanlar[i];
    if (element.username === user.username) {
      oynanabilirMi = false;
      break;
    }
  }
  if (!oynanabilirMi) {
    return res.json({
      success: false,
      message: "Yarışma daha önce oynanmış!",
    });
  }
  if (!event.isActive) {
    return res.json({
      success: false,
      message: "Yarışma Oynamaya Kapalıdır!",
    });
  }
  res.json({
    success: true,
    message: "Yarışma Oynanabilir!",
  });
};

module.exports = playEvent;
