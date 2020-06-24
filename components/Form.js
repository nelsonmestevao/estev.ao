import React, { useState } from 'react';
import 'isomorphic-fetch';

import styles from '../css/form.module.css';

export default () => {
  const [url, setUrl] = useState('');
  const [link, setLink] = useState('');

  const submit = async (event) => {
    if(!url) return;

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
    </>
  );
};
