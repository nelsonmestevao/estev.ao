import 'isomorphic-fetch';

export default function Slug() {}

Slug.getInitialProps = async ({ req, res }) => {
  const slug = req.url.split('/u/')[1];
  const { url } = await (
    await fetch(`${process.env.NEXT_PUBLIC_API_ENDPOINT}/links/${slug}`)
  ).json();

  if (res) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return {};
};
