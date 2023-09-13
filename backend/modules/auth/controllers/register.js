const bcrypt = require("bcrypt");
const models = require("../../../models/index.js");

const register = async (req, res, next) => {
  let { username, fName, lName, phone, email, password } = req.body;
  if (!username || !fName || !lName || !phone || !email || !password) {
    return res.json({
      success: false,
      message: "Bütün Alanlar Doldurulmalıdır!",
    });
  }
  let ifade = /^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/;
  let sonuc = ifade.test(email);
  if (!sonuc) {
    return res.json({
      success: false,
      message: "Emaili kontrol ediniz!",
    });
  }

  let usern = await models.User.findOne({ username: username });
  if (usern) {
    return res.json({
      success: false,
      message: "Username daha önce alınmış.",
    });
  }
  username = username.toLowerCase();

  let userm = await models.User.findOne({ email: email });
  if (userm) {
    return res.json({
      success: false,
      message: "email daha önce alınmış.",
    });
  }

  const pass = await bcrypt.hash(password, 16);

  await models.User.insertMany({
    username: username,
    fName: fName,
    lName: lName,
    phone: phone,
    email: email,
    password: pass,
  });
  await models.Auth.insertMany({
    userID: username,
    correctionsCode: Math.floor(Math.random() * (999999 - 100000) + 100000).toString(),
  });

  res.json({
    success: true,
    message: "Register başarılı",
  });
};

module.exports = register;
