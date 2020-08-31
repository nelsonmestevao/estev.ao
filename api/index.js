const router = require("express").Router();

const links = require("./links");

const { name, description, version, author } = require("../package.json");

router.use("/links", links);

router.get("/", (req, res) => {
  res.json({
    name,
    description,
    version,
    author,
  });
});

module.exports = router;
