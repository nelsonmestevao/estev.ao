const axios = require('axios');

const API = axios.create({
  baseURL: `${process.env.DOMAIN}/api`,
  responseType: 'json',
  headers: {
    'Content-Type': 'application/json',
  },
});

module.exports = API;
