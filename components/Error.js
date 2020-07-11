import React from 'react';
import PropTypes from 'prop-types';

import styles from '../css/errors.module.css';

const Error = ({ code, description }) => (
  <>
    <h1 className={styles.code}>{code}</h1>
    <h2 className={styles.description}>{description}</h2>
  </>
);

Error.propTypes = {
  code: PropTypes.number.isRequired,
  description: PropTypes.string.isRequired,
};

export default Error;
