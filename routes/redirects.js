const router = require('express').Router();
const API = require('../utils/API');

router.get('/:slug', async (req, res) => {
  const { slug } = req.params;

  const result = await API.get(`/links/${slug}`)
    .then((response) => {
      return response;
    })
    .catch((error) => {
      console.log(error);
      return error.response;
    });

  console.log(result);
  res.json(result.data, result.status);
  // res.redirect(result.url)
});

module.exports = router;
