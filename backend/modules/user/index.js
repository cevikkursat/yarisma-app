const userRouter = require("./routes/index.js");

const userModule = {
  init: (app) => {
    app.use("/api/yarismaAPP", userRouter);
    console.log("[module]: user module yuklendi!");
  },
};

module.exports = userModule;
