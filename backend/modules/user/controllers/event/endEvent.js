const models = require("../../../../models/index.js");

const endEvent = async (req, res, next) => {
  const { id, eventID, dSayisi, ySayisi, score } = req.body;
  let event = await models.Event.findById(eventID);
  if (!event) {
    return res.json({
      success: false,
      message: "Yarışma Bulunamadı!",
    });
  }
  let user = await models.User.findById(id);
  let katilanlar = event.contestants;
  katilanlar.push({ username: user.username, correctCount: dSayisi, falseCount: ySayisi, score: score });
  katilanlar.sort(function (a, b) {
    return b.score - a.score;
  });
  await models.Event.findByIdAndUpdate(eventID, {
    contestants: katilanlar,
  });
  res.json({
    success: true,
    message: "Yarışma Kaydedildi!",
  });
};

module.exports = endEvent;
