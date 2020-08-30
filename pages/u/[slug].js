import Layout from '../../layouts/Layout';
import Error from '../../components/Error';

import API from '../../utils/API';

export default ({ code, message }) => (
  <Layout>
    <Error code={code} description={message} />
  </Layout>
);

export async function getServerSideProps({ res, params }) {
  const { slug } = params;
  const reply = await await API.get(`/links/${slug}`)
    .then((response) => {
      return response;
    })
    .catch((error) => {
      return error.response;
    });

  const { url } = reply?.data;

  if (url) {
    res.writeHead(301, {
      Location: url,
    });
    res.end();
  }

  return {
    props: {
      code: reply?.status,
      message: reply?.data?.error?.message || reply?.statusText,
    },
  };
}
