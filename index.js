const express = require('express');

const app = express();
const api = require('./api');
const redirects = require('./routes/redirects');

const PORT = process.env.PORT || 3000;

app.use(express.static('public'));
app.use(express.json());

app.use('/api', api);

app.use('/u', redirects);

app.get('/:main/:slug', (req, res) => {
  const { main, slug } = req.params;

  res.status(200).json({ main, slug });
});

app.listen(PORT, () => {
  console.log(`Listening at http://localhost:${PORT}`);
});
