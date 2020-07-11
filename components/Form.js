import React, { useState } from 'react';
import 'isomorphic-fetch';

import styles from '../css/form.module.css';

export default () => {
  const [url, setUrl] = useState('');
  const [link, setLink] = useState('');
  const [error, setError] = useState('');

  const submit = async (event) => {
    if (!url) return;
    setLink('');
    setError('');

    const response = await (
      await fetch(`/api/links`, {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ url }),
      })
    ).json();

    if (response.slug) {
      setLink(`${process.env.NEXT_PUBLIC_APP_DOMAIN}/u/${response.slug}`);
      setUrl('');
    }

    if (response.error) {
      setError(response.error.message || 'Something went wrong :(');
    }

    event.preventDefault();
  };

  return (
    <>
      <form
        className={styles.form}
        onSubmit={(event) => {
          event.preventDefault();
          submit(event);
        }}
      >
        <input
          className={styles.url}
          type="text"
          name="url"
          placeholder="Type your url..."
          aria-label="Enter an URL to shorten"
          value={url}
          onChange={(event) => setUrl(event.target.value)}
        />
        <button className={styles.submit} onClick={submit} type="button">
          Go
        </button>
      </form>
      {link && (
        <div className={styles.result}>
          <a className={styles.link} href={link}>
            {link.split('://')[1]}
          </a>
          <button
            className={styles.copy}
            onClick={() => navigator.clipboard.writeText(`${link}`)}
            type="button"
          >
            Copy
          </button>
        </div>
      )}
      {error && (
        <div className={styles.result}>
          <p className={styles.error}>{error}</p>
        </div>
      )}
    </>
  );
};
