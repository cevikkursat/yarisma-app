const models = require("../../../models/index.js");
const utility = require("../../../utils/utility.js");
const bcrypt = require("bcrypt");

const resetPassword = async (req, res, next) => {
  const email = req.body.email;
  if (!email) {
    return res.json({
      success: false,
      message: "İşlem Yapılamadı!",
    });
  }
  const user = await models.User.findOne({ email: email });
  if (!user) {
    return res.json({
      success: false,
      message: "User Bulunamadı!",
    });
  }
  if (user.accountStatus !== "active") {
    return res.json({
      success: false,
      message: "User Aktif Değil!",
    });
  }
  const sifreR = Math.floor(Math.random() * (9999 - 1000) + 1000);
  const sifre = "V1APP-" + sifreR;
  const htmlMessage = `<p>Merhaba ${user.fName},</p>
      <p>Hesaba girebilmeniz için şifrenizi sıfırladık.</p>
      <p> Aşağıdaki şifre ile uygulamaya giriniz </p>
      <h1><b>${sifre}</b></h1>
      <p>Bu bir otomatik mesajdır. lütfen cevaplamayınız.</p>
      <p><i>YarismaApp</i></p>`;
  try {
    await utility.sendEmail({
      email: user.email,
      subject: `YarışmaAPP Şifre Sıfırlama!`,
      htmlMessage: htmlMessage,
    });
  } catch (err) {
    console.log(err);
  }

  const pass = await bcrypt.hash(sifre, 16);
  user.password = pass;
  user.save();

  return res.json({
    success: true,
    message: "Şifre Sıfırlandı Mail olarak Gönderildi!",
  });
};

module.exports = resetPassword;
