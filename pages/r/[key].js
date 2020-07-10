import React from 'react';
import Layout from '../../layouts/Layout';
import Error from '../../components/Error';

import redirects from '../../data/redirects.json';

export default function Key() {
  return (
    <Layout>
      <Error code={404} description="Key not found" />
    </Layout>
  );
}

Key.getInitialProps = async ({ res, query }) => {
  const { key } = query;
  const url = redirects[key];

  if (url) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return {};
};
