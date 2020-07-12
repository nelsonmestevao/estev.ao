import React from 'react';
import Layout from '../../layouts/Layout';
import Error from '../../components/Error';

import 'isomorphic-fetch';

export default function Slug({ code, message }) {
  return (
    <Layout>
      <Error code={code} description={message} />
    </Layout>
  );
}

Slug.getInitialProps = async ({ res, query }) => {
  const { slug } = query;
  const { url } = await (
    await fetch(`${process.env.NEXT_PUBLIC_APP_DOMAIN}/api/links/${slug}`)
  )
    .json()
    .catch((error) => {
      console.error(error);
      return { code: 500, message: "I don't know what happened" };
    });

  if (url) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return { code: 404, message: 'Slug not found' };
};
