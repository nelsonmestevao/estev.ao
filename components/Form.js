import React, { useState } from 'react';
import 'isomorphic-fetch';

import styles from '../css/form.module.css';

export default () => {
  const [url, setUrl] = useState('');
  const [link, setLink] = useState('');

  const submit = async (event) => {
    const response = await (
      await fetch(`${process.env.NEXT_PUBLIC_API_ENDPOINT}/links`, {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ url }),
      })
    ).json();

    setLink(response.link);
    setUrl('');
    event.preventDefault();
  };

  return (
    <>
      <form className={styles.form}>
        <input
          className={styles.url}
          type="text"
          placeholder="Type your url..."
          aria-label="URL"
          value={url}
          onChange={(event) => setUrl(event.target.value)}
        />
        <button className={styles.submit} onClick={submit} type="button">
          Go
        </button>
      </form>
      {link && (
        <div className={styles.result}>
          <span className={styles.link}>{link}</span>
          <button
            className={styles.copy}
            onClick={() => navigator.clipboard.writeText(`${link}`)}
            type="button"
          >
            Copy
          </button>
        </div>
      )}
    </>
  );
};
