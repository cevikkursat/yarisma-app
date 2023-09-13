const models = require("../../../../models/index.js");

const listEvent = async (req, res, next) => {
  let events = await models.Event.find({ isActive: true });
  if (events.length < 1) {
    return res.json({
      success: false,
      message: "Yarışma Bulunamadı!",
    });
  }
  let arr = [];
  for (let i = 0; i < events.length; i++) {
    let user = await models.User.findById(events[i].owner);
    arr.push(user.username);
  }
  res.json({
    success: true,
    events: events,
    eventsCount: events.length,
    usernames: arr,
    message: "Bulunan Yarışma Getirildi!",
  });
};

module.exports = listEvent;
