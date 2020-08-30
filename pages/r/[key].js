import Layout from '../../layouts/Layout';
import Error from '../../components/Error';

import redirects from '../../data/redirects.json';

export default ({ code, message }) => (
  <Layout>
    <Error code={code} description={message} />
  </Layout>
);

export async function getServerSideProps({ res, query }) {
  const { key } = query;
  const url = redirects[key];

  if (url) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return {
    props: {
      code: 404,
      message: 'Key not found',
    },
  };
}
