import React from 'react';
import PropTypes from 'prop-types';
import Head from 'next/head';

import styles from '../css/layout.module.css';

const Cubes = () => (
  <>
    <div className={styles.cube} />
    <div className={styles.cube} />
    <div className={styles.cube} />
    <div className={styles.cube} />
    <div className={styles.cube} />
    <div className={styles.cube} />
  </>
);

export default function Layout({ children }) {
  return (
    <>
      <Head>
        <title>estev.ao</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <div className={styles.hero}>
        {children}
        <Cubes />
      </div>
      <style jsx global>
        {`
          body {
            margin: 0;
            padding: 0;
          }
        `}
      </style>
    </>
  );
}

Layout.propTypes = {
  children: PropTypes.any.isRequired,
};
