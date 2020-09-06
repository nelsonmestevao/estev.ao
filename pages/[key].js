import React from 'react';
import Layout from '../layouts/Layout';
import Error from '../components/Error';

const links = {
  bio: 'https://nelsonmestevao.keybase.pub',
};

export default function Key({ code, message }) {
  return (
    <Layout>
      <Error code={code} description={message} />
    </Layout>
  );
}

Key.getInitialProps = async ({ res, query }) => {
  const { key } = query;
  const url = links[key];

  if (url) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return { code: 404, message: 'Key not found' };
};
