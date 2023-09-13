const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const models = require("../../../models/index.js");
const utility = require("../../../utils/utility.js");

const login = async (req, res, next) => {
  const { username, password } = req.body;
  let user;
  if (!username || !password) {
    return res.json({
      success: false,
      message: "username ve password gereklidir!",
    });
  } else {
    user = await models.User.findOne({ username: username });
    if (!user) {
      return res.json({
        success: false,
        message: "User Bulunamadı!",
      });
    }
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.json({
        success: false,
        message: "Password Yanlış",
      });
    }
    if (user.accountStatus !== "active" && user.accountStatus !== "inactive") {
      return res.json({
        success: false,
        accountStatus: user.accountStatus,
        message: "Hesap Kullanım Dışı!",
      });
    }
    if (user.accountStatus === "inactive") {
      const code = await models.Auth.findOne({ userID: username });
      const htmlMessage = `<p>Merhaba ${user.fName},</p>
      <p>Hesaba ilk girişte giriş yapmak için mail kontrolüdür.</p>
      <p> Aşağıdaki giriş kodunu giriniz </p>
      <h1><b>${code.correctionsCode}</b></h1>
      <p>Bu bir otomatik mesajdır. lütfen cevaplamayınız.</p>
      <p><i>YarismaApp</i></p>`;
      try {
        await utility.sendEmail({
          email: user.email,
          subject: `YarışmaAPP'e Hoş Geldiniz!`,
          htmlMessage: htmlMessage,
        });
      } catch (err) {
        console.log(err);
      }
      return res.json({
        success: false,
        accountStatus: user.accountStatus,
        message: "Hesap Aktif Değil! Mail Adresinize Gelen Kodu Girerek Aktifleştiriniz!",
      });
    }

    const token = jwt.sign({ id: user._id, role: user.role }, process.env.SECRET_KEY);
    res.json({
      success: true,
      message: "Giriş Başarılı!",
      accountStatus: user.accountStatus,
      token: token,
    });
  }
};

module.exports = login;
