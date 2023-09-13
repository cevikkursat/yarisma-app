const models = require("../../../../models/index.js");

const changeEventStatus = async (req, res, next) => {
  const { updateingEventId, eventStatus } = req.body;
  if (!updateingEventId) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  await models.Event.findByIdAndUpdate(updateingEventId, {
    isActive: eventStatus,
  });

  res.json({
    success: true,
    message: "Yarışma Durumu değiştirildi!",
  });
};

module.exports = changeEventStatus;
