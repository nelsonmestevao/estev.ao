import { gitlab } from '../../data/settings.json';

export default function Repo() {
  return (
    <Layout>
      <Error code={500} description="Something went wrong" />
    </Layout>
  );
}

Repo.getInitialProps = async ({ res, query }) => {
  const { repo } = query;
  const url = `${gitlab.base_url}/${gitlab.username}/${repo}`;

  res.writeHead(301, {
    Location: url,
  });
  res.end();
};
