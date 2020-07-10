import React from 'react';
import Layout from '../../layouts/Layout';
import Error from '../../components/Error';

import 'isomorphic-fetch';

export default function Slug() {
  return (
    <Layout>
      <Error code={404} description="Slug not found" />
    </Layout>
  );
}

Slug.getInitialProps = async ({ res, query }) => {
  const { slug } = query;
  const { url } = await (
    await fetch(`http://localhost:3000/api/links/${slug}`)
  ).json();

  if (url) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return {};
};
