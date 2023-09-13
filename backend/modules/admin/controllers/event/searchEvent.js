const models = require("../../../../models/index.js");

const searchEvent = async (req, res, next) => {
  const { eventName } = req.body;
  if (!eventName) {
    return res.json({
      success: false,
      message: "Event Bulunamadı!",
    });
  }
  let event = await models.Event.find({ eventName: eventName });
  if (event.length < 1) {
    return res.json({
      success: false,
      message: "Event Bulunamadı!",
    });
  }
  let user = await models.User.findById(event[0].owner);
  res.json({
    success: true,
    event: event[0],
    username: user.username,
    message: "Bulunan Event Getirildi!",
  });
};

module.exports = searchEvent;
