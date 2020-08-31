const router = require('express').Router();
const { nanoid } = require('nanoid');

const Link = require('../models/Link');

router.post('/', async (req, res) => {
  const { body } = req;

  if (!body.url) {
    res.status(400).json({ error: { message: 'Missing URL field' } });
    return;
  }

  const slug = body.slug || nanoid(5);
  const url = !/^https?:\/\//i.test(body.url) ? `http://${body.url}` : body.url;

  if (
    !url.match(
      /(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_+.~#?&//=]*)/g,
    )
  ) {
    res.status(400).json({ error: { message: 'Invalid URL' } });
    return;
  }

  if (body.slug) {
    const taken = await Link.findOne({ slug }).then((link) => {
      if (link) {
        res.status(409).json({ error: { message: 'Slug already taken' } });
        return true;
      } else {
        return false;
      }
    });

    if (taken) return;
  }

  await new Link({ slug, url })
    .save()
    .then((link) => {
      res.status(200).json(link);
    })
    .catch((error) => {
      console.error(error);
      res.status(500).json({ error });
    });
});

router.get('/:slug', async (req, res) => {
  const { slug } = req.params;

  await Link.findOneAndUpdate({ slug }, { $inc: { visits: 1 } }, { new: true })
    .then((link) => {
      if (link) {
        res.status(200).json(link);
      } else {
        res.status(404).json({ error: { message: 'No URL found' } });
      }
    })
    .catch((error) => {
      console.error(error);
      res.status(500).json({ error });
    });
});

module.exports = router;
