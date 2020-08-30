import React, { useState } from 'react';

import API from '../utils/API';

import styles from '../css/form.module.css';

export default () => {
  const [url, setUrl] = useState('');
  const [slug, setSlug] = useState('');
  const [link, setLink] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const submit = async (event) => {
    if (!url) return;
    setLink('');
    setError('');
    setLoading(true);

    const response = await API.post(`/links`, { url, slug })
      .then((reply) => {
        return reply;
      })
      .catch((err) => {
        return err.response;
      });

    if (response.data.error) {
      setError(
        `${response.data.error?.message || response.statusText} (Error code: ${
          response.status
        })`,
      );
    }

    if (response.data.slug) {
      setLink(`${process.env.NEXT_PUBLIC_APP_DOMAIN}/u/${response.data.slug}`);
      setUrl('');
      setSlug('');
    }

    setLoading(false);

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
        <div className={styles.wrapper}>
          <input
            className={styles.slug}
            type="text"
            name="slug"
            placeholder="Optional slug..."
            aria-label="Enter a custom slug"
            value={slug}
            onChange={(event) => setSlug(event.target.value)}
          />
          <button className={styles.submit} onClick={submit} type="button">
            Go
          </button>
        </div>
      </form>
      {loading ? (
        <div className={styles.loading}>Loading...</div>
      ) : (
        link && (
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
        )
      )}
      {error && (
        <div className={styles.result}>
          <p className={styles.error}>{error}</p>
        </div>
      )}
    </>
  );
};
