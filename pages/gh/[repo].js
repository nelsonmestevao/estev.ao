import Layout from '../../layouts/Layout';
import Error from '../../components/Error';

import { github } from '../../data/settings.json';

export default () => (
  <Layout>
    <Error code={500} description="Something went wrong" />
  </Layout>
);

export async function getServerSideProps({ res, query }) {
  const { repo } = query;
  const url = `${github.base_url}/${github.username}/${repo}`;

  res.writeHead(301, {
    Location: url,
  });
  res.end();

  return { props: {} };
}
