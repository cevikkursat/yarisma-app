const dotenv = require("dotenv");
dotenv.config();
const runApp = require("./app.js");
const initModules = require("./initModules.js");
const models = require("./models/index.js");
const connnect = require("./connectDB.js");
connnect();

const deneme = async () => {
  let events = await models.Event.find({ isActive: true });
  for (let i = 0; i < events.length; i++) {
    if (Date.parse(events[i].eventFinishDate) < Date.now()) {
      await models.Event.findByIdAndUpdate(events[i]._id, { isActive: false });
    }
  }
};

const app = runApp();
initModules(app);
setInterval(deneme, 1000 * 60 * 60);

app.listen(process.env.PORT, () => {
  console.log(`${process.env.PORT} Portu Dinleniyor!`);
});
