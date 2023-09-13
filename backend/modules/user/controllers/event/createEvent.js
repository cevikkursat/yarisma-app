const models = require("../../../../models/index.js");
const createEvent = async (req, res, next) => {
  let event;
  const { owner, eventName, eventFinishDate, award, awardCount, questions } = req.body;
  if (!owner || !eventName || !award || !awardCount || !questions || !eventFinishDate) {
    return res.json({
      success: false,
      message: "Bütün Bilgileri Doldurmanız Gerekmektedir!",
    });
  }
  event = await models.Event.findOne({ eventName: eventName });
  if (event) {
    return res.json({
      success: false,
      message: "Yarışma adı daha önce oluşturulmuş başka bir ad ile deneyin!",
    });
  }
  if (questions.length < 5) {
    return res.json({
      success: false,
      message: "En az 5 soru gerekmektedir!",
    });
  }

  await models.Event.insertMany({
    owner: owner,
    eventName: eventName,
    eventFinishDate: Date.parse(eventFinishDate),
    award: award,
    awardCount: awardCount,
    questions: questions,
  });
  let user = await models.User.findOne({ _id: owner });
  await models.User.findByIdAndUpdate(owner, {
    eventsCount: user.eventsCount + 1,
  });
  res.json({
    success: true,
    message: "Yarışma Eklendi!",
  });
};

module.exports = createEvent;
