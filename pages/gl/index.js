import Layout from '../../layouts/Layout';
import Error from '../../components/Error';

import { gitlab } from '../../data/settings.json';

export default () => (
  <Layout>
    <Error code={500} description="Something went wrong" />
  </Layout>
);

export async function getServerSideProps({ res }) {
  const url = `${gitlab.base_url}/${gitlab.username}`;

  res.writeHead(301, {
    Location: url,
  });
  res.end();

  return { props: {} };
}
