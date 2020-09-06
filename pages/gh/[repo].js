import { github } from '../../data/settings.json';

export default function Repo() {
  return (
    <Layout>
      <Error code={500} description="Something went wrong" />
    </Layout>
  );
}

Repo.getInitialProps = async ({ res, query }) => {
  const { repo } = query;
  const url = `${github.base_url}/${github.username}/${repo}`;

  res.writeHead(301, {
    Location: url,
  });
  res.end();
};
