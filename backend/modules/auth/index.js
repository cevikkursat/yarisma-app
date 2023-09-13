const authRouter = require("./routes/index.js");

const authModule = {
  init: (app) => {
    app.use("/api/yarismaAPP", authRouter);
    console.log("[module]: auth module yuklendi!");
  },
};

module.exports = authModule;
