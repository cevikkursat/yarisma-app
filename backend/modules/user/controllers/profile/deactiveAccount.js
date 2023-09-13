const models = require("../../../../models/index.js");
const deactiveAccount = async (req, res, next) => {
  let userEvents;
  let itCanDeactive = true;
  const { id } = req.body;
  if (!id) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  userEvents = await models.Event.find({ owner: id });
  for (let i = 0; i < userEvents.length; i++) {
    const element = userEvents[i];
    if (element.isActive) itCanDeactive = false;
  }
  if (!itCanDeactive) {
    return res.json({
      success: false,
      message: "Hesaba Ait Bitmemiş Event Bulunuyor!",
    });
  }
  await models.User.findByIdAndUpdate(id, {
    accountStatus: "deactivated",
  });
  res.json({
    success: true,
    message: "Hesap Kapatıldı!",
  });
};

module.exports = deactiveAccount;
