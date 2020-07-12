import React from 'react';
import Layout from '../../layouts/Layout';
import Error from '../../components/Error';

import API from '../../utils/API';

export default function Slug({ code, message }) {
  return (
    <Layout>
      <Error code={code} description={message} />
    </Layout>
  );
}

Slug.getInitialProps = async ({ res, query }) => {
  const { slug } = query;
  const response = await API.get(`/links/${slug}`)
    .then((response) => {
      return response;
    })
    .catch((error) => {
      return error.response;
    });

  const { url } = response.data;

  if (url) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return {
    code: response.status,
    message: response.data?.error?.message || response.statusText,
  };
};
