import axios from 'axios';

const API = axios.create({
  baseURL: `${process.env.NEXT_PUBLIC_APP_DOMAIN}/api`,
  responseType: 'json',
  headers: {
    'Content-Type': 'application/json',
  },
});

export default API;
