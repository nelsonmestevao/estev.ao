import Layout from '../layouts/Layout';
import Form from '../components/Form';

import styles from '../css/home.module.css';

export default function Index() {
  return (
    <Layout>
      <div className={styles.title}>estev.ao</div>
      <div className={styles.description}>
        A short and simple redirecting service
      </div>
      <Form />
    </Layout>
  );
}
