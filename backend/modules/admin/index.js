const adminRouter = require("./routes/index.js");

const adminModule = {
  init: (app) => {
    app.use("/api/yarismaAPP", adminRouter);
    console.log("[module]: admin module yuklendi!");
  },
};

module.exports = adminModule;
