import redirects from '../../data/redirects.json';

export default function Key() {}

Key.getInitialProps = async ({ req, res }) => {
  const key = req.url.split('/r/')[1];
  const url = redirects[key];

  if (res) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return {};
};
